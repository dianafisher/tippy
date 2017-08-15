# Pre-work - *Tippy*

**Tippy** is a tip calculator application for iOS.

Submitted by: **Diana Fisher**

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Additional: Overall theme to look like a diner receipt
- [x] Additional: Toggle switch to include tax in tip calculation
- [x] Additional: Include amount per person in party
- [x] Additional: Settings page remembers guest count and whether to include tax in calculation
- [x] Additional: Validation of bill and tax entry.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/dianafisher/tippy/blob/master/tippy_walkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I've been developing apps on the iOS development platform for a few years now.  My initial reaction when I first started was that it is a powerful platform with a vast set of features.  I struggled at first with knowing how to architect my app using UIViewControllers and UIViews and the navigation controller.  Now that I have written several apps I am much more comfortable with the design patterns used for iOS app development.

An outlet is a property of an object that references another object.  Outlets are defined so that messages can be sent to view objects such as UITextField, UIButton, etc from their managing view controller.  Outlets can be set up graphically in a storyboard in XCode.

Actions are part of the target-action design pattern in iOS where one object holds information needed to send a message to another object when an event occurs.  The stored information includes an action selector and a target object to receive the message.  Actions can be set up in a storyboard with the IBAction type qualifier.


Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** If you assign a closure to the propery of a class instance, the body of that closure may 'capture' that instance (also known as 'capturing self').  By assigning a closure to a property, you are assigning a reference to that closure.  So now the class instance has a strong reference to the closure, and the closure has a strong reference to the class instance (through the use of self).


## License

Copyright [2017] [Diana Fisher]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
