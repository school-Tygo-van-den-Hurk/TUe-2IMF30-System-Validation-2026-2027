# 2IMF30 System Validation

The purpose of this course is to learn how to abstractly design behavior of a system and to analyze this behavior before the system is built. You'll learn how to precisely write down behavior and prove it. With this practical assignment you will experience how to apply the techniques.

## Assignment

In the first weeks you are supposed to work through the practical assignment that you can find on canvas. The goal is to install and learn the tools, and obtain an idea of the overall goal of the assignment. See [the introductory assignment][introductory assignment].

The main assignment consists of designing a controller for a small distributed and/or embedded system. Below a suggestion for such a system can be found. However, you are free (and even encouraged) to choose to design a controller of a system of your liking in consultation with the teachers.

This year the default assignment is to design and document a controller for a Festo storage station which we recently acquired for our new Nexus lab. The storage system provides the infrastructure to store objects autonomously, and the request is to develop a controller that allows users to store and retrieve items, with the guarantee that the system will not damage those items.

Carrying out the assignment consists of executing the following steps:

1. Shortly describe the system and its purpose. Identify in words global requirements for the whole system. If the assignment were about a bridge, typical requirements would be: 'A bridge will never open when the barriers are not closed'; 'If an operator instructs the bridge to open, the bridge will open unless the barriers are not closed'; and 'A bridge will never open spontaneously'. These requirements are initially to be described in natural language.
1. Identify the interactions that are relevant to your system. Describe clearly but compactly the meaning of each interaction in words.
1. Translate the global requirements in terms of these interactions.
1. Describe a compact architecture of the structure of the system. It is required that the controller has at least three different parallel components.
1. Describe the behavior of all components using mCRL2.
1. Verify using the toolset that all requirements given in item 3 above are valid for the design in mCRL2.

The assignment must be documented in a technical report that covers all items above. This report must be a concise technical account of the system and must be written such that from it the requirements, action interface, architecture and behavioral design can be easily understood. With this report a software engineer should be able to build the controller exactly as intended, without consulting the authors.

It must also be clear how the requirements are verified, in such a way that this can easily be repeated. So, for instance the exact commands that are used must be listed, and it must be obvious which version of the toolset was used for the verification and on which platform and operating system the verification was done.

There will be a pre-final and a final report. The pre-final report is the primary report that will be judged. The final report is only meant to incorporate feedback, to add omissions and to improve an accidentally wrong modal formula. The report and all its content must be written by group members. It is not allowed to use parts of other reports.

The use of AI is discouraged. But when AI has been used, it should explicitly be indicated in the report that it has been used and all group members should clearly understand what has been written in the report. The use of AI should be in accordance with the TU/e regulations.

### Default assignment

Festo makes robots and robotic equipment for educational purposes. The department recently
acquired some of these robots for our new Nexus lab, in particular a storage station, see [their website][festo].

This robot consists of a small conveyor belt with two sensors, one at the entry point, and one where objects can be picked up by a robot arm using a gripper. The robot arm can move upwards, sidewards and forwards and put objects at any of the positions of the platforms. The whole system has an emergency button. Whenever that button is pressed the robot and the conveyor belt should stop moving.

The robot should take care that objects do not collide, as that may damage those objects. Due to vibration and electricity constraints upward, sideward and forward movements should not be carried out simultaneously.

It should also carry out its primary task well, namely store objects that will be delivered when a customer asks for it. Asking for the return of a stored item, and offering new items can take place simultaneously. For instance, the robot can be in the process of delivering a requested item, but then the conveyor belt to deliver it is blocked by a new item. The robot should then first handle this new item before doing the delivery as it is unacceptable to request a customer to remove a newly offered item from the conveyor belt.

Another complication is that sometimes items fall from the storage shelves, or are being put there manually. For this reason the robot can be assumed to have a gripper sensor that detects whether there is an object in front of the gripper. If it is detected that an object is absent or present contra expectations, the control system should report this adequately. It can be assumed that initially both the conveyor belt, the gripper and the storage places are all empty.

The description above will turn out to be rather vague when the behaviour of the system
is precisely being modelled, and may even be intrinsically inconsistent. This is typical for such textual descriptions. When this happens you must choose your own view of the system respecting the description above as much as possible. You should describe your choice clearly in the report and be able to defend it. In case there is unclarity on how to design the system, you are urged to make your own choice and not wait for a consultation with the teachers. One of the reasons for this is that the time to accomplish this assignment is rather short.

[festo]: https://ip.festo-didactic.com/Infoportal/MPS/StorageStation/EN/index.html.
