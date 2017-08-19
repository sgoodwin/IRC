//
//  IRCServerTests.swift
//  IRCTests
//
//  Created by Samuel Ryan Goodwin on 8/2/17.
//  Copyright © 2017 Roundwall Software. All rights reserved.
//

import XCTest
@testable import IRC

class IRCServerTests: XCTestCase {
    func testServerDelegateGetsServerMessages() {
        
        let user = IRCUser(username: "sgoodwin", realName: "Samuel Goodwin", nick: "mukman")
        let server = IRCServer.connect("127.0.0.1", port: 6667, user: user)
        
        class ServerDelegate: IRCServerDelegate {
            let expectation = XCTestExpectation(description: "Any message receieved")
            
            func didRecieveMessage(_ server: IRCServer, message: String) {
                expectation.fulfill()
                // In real life, the developer would maybe update the UI or something here. They're free to do whatever they want.
            }
        }
        
        let serverDelegate = ServerDelegate()
        server.delegate = serverDelegate
        
        wait(for: [serverDelegate.expectation], timeout: 1.0)
    }
    
    func testJoiningAChannel() {
        let user = IRCUser(username: "sgoodwin", realName: "Samuel Goodwin", nick: "mukman")
        let server = IRCServer.connect("127.0.0.1", port: 6667, user: user)
        
        let channel = server.join("clearlyafakechannel")
        
        struct ChannelDelegate: IRCChannelDelegate {
            let expectation = XCTestExpectation(description: "Any message receieved")
            
            func didRecieveMessage(_ channel: IRCChannel, message: String) {
                expectation.fulfill()
            }
        }
        
        let channelDelegate = ChannelDelegate()
        channel.delegate = channelDelegate
        
        wait(for: [channelDelegate.expectation], timeout: 1.0)
    }
    
    func testSendingAChannelMessage() {
        class MockServer: IRCServer {
            var sentMessage: String?
            
            override func send(_ message: String) {
                sentMessage = message
            }
        }
        
        let user = IRCUser(username: "sgoodwin", realName: "Samuel Goodwin", nick: "mukman")
        let server = MockServer.connect("127.0.0.1", port: 6667, user: user)
        
        let channel = server.join("clearlyafakechannel")
        channel.send("hey sup")
        
        XCTAssertEqual(server.sentMessage, "PRIVMSG #clearlyafakechannel :hey sup")
    }
}
