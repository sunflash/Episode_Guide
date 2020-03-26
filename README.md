# Silicon Valley Episode Guide

This branch contains a MVP version of the implementation, with support for iPhone, iPad and mac.

Implementation use swiftUI and has basic support for dark mode.

Following items are nice to have, was not part of the MVP version.

- HTTP request to fetch data from remote endpoint (https://github.com/swift-server/async-http-client)
- HTTP cache for data and image (Offline support)
- Unit test for data decoding and parsing
- Transition animation from placeholder image to poster image
- Better polish and feel in general
  
Known issues with Xcode 11.3 and earlier version

- There seems to be a bug with the navigation link in Xcode version 11.3
    The problem only appears in simulator, but works fine on a real device.
    Navigation link work as expect the first time you tap it.
    But it becomes unresponsive the second time around.

- SwiftUI split view implementation don't work on iPad that build with Xcode version 11.3 and earlier version.

Both issue seem to be fix in Xcode 11.4 with iOS 13.4 framework.