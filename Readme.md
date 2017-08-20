# IRC

A Swift framework for interacting with IRC servers.

## Supported Features
- Connect to IRC servers
- Join IRC Channels
- Send and receieve messages to and from said channels

There's quite a bit more to IRC in general, but for now this is all we support. Feel free to file an issue to request anything else if you're trying to use this somewhere.

# Usage

## Connecting To A Server

```swift
let user = IRCUser(username: "sgoodwin", realName: "Samuel Goodwin", nick: "mukman")
let server = IRCServer.connect("127.0.0.1", port: 6667, user: user)
```

From here a connection is established. To receieve any messages from the server, such as the message of the day, you must adopt the `IRCServerDelegate` protocol with some object and assign it to the delegate property of the server.

## Joining IRC Channels

```swift
let channel = server.join("clearlyafakechannel")
```

This will cause you to join the channel `#clearlyafakechannel`.

## Receieving Channel Messages

To receieve messages from a channel, have one of your objects adopt the `IRCChannelDelegate` protocol and assign it to the delegate property of the channel.

## Sending Channel Messages

```swift
channel.send("Hey sup")
```

This will send "Hey sup" for everyone in the channel to see.


## FIN

That's it for now. There may be more functionality in the future, but this is enough to make a fun demo and show people. Most error conditions are also not considered, because demos don't need to care!
