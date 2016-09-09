# UIKit-Re-Animator
Sample code to play with new iOS 10 animation API's for my talk at CocoaConf DC 2016 on Sep 9, 2016

[Slides](https://dl.dropboxusercontent.com/u/1353697/CocoaConf%20DC%202016/UIKit%20Reanimator.pdf)

There are 6 view controllers containing code that I demonstrated. You have to instantiate the one you want in AppDelegate (all 6 are there, 5 are commented out)

* __Animator1ViewController__: simple animator that moves a ball on tap gesture, but it has a bug in how reversed is used
* __Animator2ViewController__: fixes the above bug, but still has an auto-layout bug
* __Animator3ViewController__: fixes the auto-layout bug
* __Animator4ViewController:__ adds a scale animation in response to pan gesture that runs on its own or interrupts the tap gesture animation.
* __PreviewInteractionViewController__: handles preview and commit preview interactions with distinct animators for each and scrubs the animator proportionally with the amount of 3D force applied.
* __GraphicsRendererViewController:__ table view with rows that each display a CoreGraphics created chart image. Code uses both the old way and the new way (UIGraphicsImageRenderer) to achieve the same results.
