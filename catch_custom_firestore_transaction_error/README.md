### Problem:
How to catch a custom error from a Firestore transaction?

### Methodology
#### Cloud Firestore Version
https://pub.dev/packages/cloud_firestore

Multiple buttons are created, all of which triggers a transaction. 
* Button A throws a Future.error()
* Button B throws a PlatformException()
* Button C throws a FirebaseException()
* Button D throws an Exception().

### Findings
* Exception thrown at Button A results to an unhandled exception, meaning it cannot be caught.
* Exception thrown at Button B returns a Firebase Exception with code of `unknown`.
* Exception thrown at Button C returns a Firebase Exception with the provided code. (IDEAL)
* Exception thrown at Button D lands on the most basic Exception.

### Conclusion
To catch a custom error from a Firestore transaction, it is best to use a Firebase Exception with your custom code for proper identification.
