crouton-ios
===========

iOS "clone" of the Android Crouton framework

The goal of this small framework is to offer a quick and easy way to show notifications.

eg. 

- an error
- an information message
- a message that asks the user to "wait"
 

Examples

```objectivec

#import "Crouton.h"
...
[Crouton showAlert:@"This is an alert" inView:self.view];
...

```


