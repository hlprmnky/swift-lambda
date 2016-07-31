# swift-lambda
AWS λ in Swift

## Building

To build the zip file to upload to AWS, simply run `make`.

## Dependencies

Swift 3.0 Preview 3

## Status

This currently does not work. Running it in the AWS λ runtime environment yields:

    {
      "errorMessage": "Command failed: /bin/sh -c ./request_handler\n/bin/sh: error while loading shared libraries: /var/task/lib/libc.so.6: invalid ELF header\n",
      "errorType": "Error",
      "stackTrace": [
        "/bin/sh: error while loading shared libraries: /var/task/lib/libc.so.6: invalid ELF header",
        "",
        "ChildProcess.exithandler (child_process.js:213:12)",
        "emitTwo (events.js:87:13)",
        "ChildProcess.emit (events.js:172:7)",
        "maybeClose (internal/child_process.js:821:16)",
        "Socket.<anonymous> (internal/child_process.js:319:11)",
        "emitOne (events.js:77:13)",
        "Socket.emit (events.js:169:7)",
        "Pipe._onclose (net.js:469:12)"
      ]
    }
  
I think the root of the issue is that the AWS λ runtime environment is RHEL-based, but I compiled this using Ubuntu since that is the only Linux distro for which Apple provides binaries. I was not able to get a Swift compiler working on an EC2 instance running AWS Linux.
