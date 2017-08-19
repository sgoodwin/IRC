//
//  IRCServerInputParser.swift
//  IRCTests
//
//  Created by Samuel Ryan Goodwin on 7/22/17.
//  Copyright © 2017 Roundwall Software. All rights reserved.
//

import XCTest
@testable import IRC

class IRCServerInputParserTests: XCTestCase {
    
    func testPingMessage() {
        let input = IRCServerInputParser.parseServerMessage("PING :development.irc.roundwallsoftware.com")
        
        XCTAssertEqual(input, .ping)
    }
    
    func testServerMessage() {
        let input = IRCServerInputParser.parseServerMessage(":tolkien.freenode.net 001 mukman :Welcome to the freenode Internet Relay Chat Network mukman")

        XCTAssertEqual(input, IRCServerInput.serverMessage(server: "tolkien.freenode.net", message: "Welcome to the freenode Internet Relay Chat Network mukman"))
    }
    
    func testChannelMessage() {
        let input = IRCServerInputParser.parseServerMessage(":sgoodwin!~sgoodwin@ip-213-127-113-249.ip.prioritytelecom.net PRIVMSG #clearlynotarealchannel :this is so cool")
        
        XCTAssertEqual(input, IRCServerInput.channelMessage(channel: "clearlynotarealchannel", user: "sgoodwin", message: "this is so cool"))
    }
    
    func testJoinMessage() {
        let input = IRCServerInputParser.parseServerMessage(":mukman!~sgoodwin@188.202.247.233 JOIN #clearlyatestchannel\r\n")

        XCTAssertEqual(input, IRCServerInput.joinMessage(user: "mukman", channel: "clearlyatestchannel"))
    }
    
    func testUserListMessage() {
        let input = IRCServerInputParser.parseServerMessage(":development.irc.roundwallsoftware.com 353 mukman = #clearlyafakechannel :mukman @sgoodwin\r\n:development.irc.roundwallsoftware.com 366 mukman #clearlyafakechannel :End of /NAMES list.")
        
        XCTAssertEqual(input, IRCServerInput.userList(channel: "clearlyafakechannel", users: ["mukman"]))
    }
}
