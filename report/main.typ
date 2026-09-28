#set heading(numbering: "1.");
#set page(numbering: "1");

= Requirements

// I read that it is supposed to be in the form of:
//
//    <Object> shall <action> <object> <condition/constraint>
// 
// https://www.softkraft.co/how-to-write-software-requirements/ 
// 
// So I rewrote them to that format, and sorted them into "the machine" and
// "the arm" because I thought we might be able to separate those into
// components as we need 3 of those in the end.
// 
// I also think we should be consistent with the use of "pick up" and
// "drop off". I'm currently using the word "insertion" for going in
// storage, "retrieval" for going out of storage.
// 
// I also thought the notion of states was a good idea. Then we can have 3
// main modes: Emergency, Insertion, and Retrieval. With a state machine
// looking like this:
// 
//    +--- Insertion <---> Retrieval ---+
//    |                                 |
//    +----------> Emergency <----------+
// 
// Another thing I noticed is that we're also not consistent with
// "storage spot" and "storage spot". Because we used "spot" more I went with
// that one.

== Emergency State

- The machine shall enter into a state of emergency when the emergency button is pressed. 
- The machine shall not move the gripper when in a state of emergency.
- The machine shall not move the conveyor belt when in a state of emergency.
- The machine shall not change the state of the gripper while in the emergency state.
- The machine shall not leave the state of emergency when in the state of emergency

== Insertion Mode

- The machine shall only insert an item designated for insertion when in insertion mode.
- The machine shall not pick up any item designated for insertion when there is no free spot available on the requested shelf.
- The machine shall reject any item designated for insertion when there is no free spot  available on the requested shelf.
- The machine shall not insert an item in a spot already occupied by another item.

== Retrieval Mode

// TODO: improve phrasing from how to transition from retrieval to insertion mode.

- The machine shall go into retrieval mode when no items designated for insertion are on the conveyor belt.
- The machine shall not retrieve an item while not in retrieval mode.
- The machine shall process pending retrieval requests in FIFO order while in retrieval mode.
- The machine shall not remove requests from the list until they are completed.
- The machine shall abort any ongoing retrieval of the item $I$ by reinserting $I$ back on a valid empty spot on the shelf $I$ came from when any item designated for insertion is placed on the conveyor belt.
- The machine shall go into insertion mode when any item designated for insertion is placed on the conveyor belt after handling any potential reinsertion first.
- The machine shall add queue request $R$ for the retrieval of an item $I$ at the back of the list of pending requests when $R$ is received.

== Gripper 

- The robot arm shall not open its gripper to release an item designated for insertion unless it is positioned at an empty storage spot on the requested shelf.
- The robot arm shall not open its gripper to release an item designated for retrieval unless it is positioned at the conveyor belt drop off point.

== Power Constraints

- The machine shall move the gripper in at most one of the following directions at a time: forward, backward, up, down, left, and right.

== Errors

- The machine shall report an error when storage spot $P$ is internally registered as empty but the sensors detect an item stored in $P$.

= Verification

#let nix = link("http://nixos.org/", "Nix");

#let distribution = link(
  "http://nixos.org/",
  [`NixOS 26.05 (Yarara)`],
);

#let configuration = link( // TODO add commit
  "https://github.com/Tygo-van-den-Hurk/NixOS/tree/<COMMIT>",
  [`github:Tygo-van-den-Hurk/NixOS/<COMMIT>`],
);

#let nixpkgs = link(
  "https://github.com/NixOS/nixpkgs/tree/d2f67949798825fe853f7c5d0492b8bf016d3f88",
  [`github:NixOS/NixPkgs/d2f67949798825fe853f7c5d0492b8bf016d3f88`],
);

#let version = [`202507.0.1db00c84f6 (Release)`];

Verification was performed inside the #nix sandbox, on the following machine:

- *Kernel*: `Linux 6.18.48`
- *Architecture*: `x86_64`
- *Distribution*: #distribution using configuration #configuration.
- *mCRL2 toolset*: using version #version packaged from #nixpkgs.

Using this information an exact replica of the system and environment can be reconstructed.

= AI Notice

== Requirements

When we created our requirements we used AI for feedback and validation. You can see our first draft at @first-draft-requirements. We got as feedback to use the following structure:

> The system shall [action] [object] [condition/constraint].

Which we also googled to see if others agreed: https://www.softkraft.co/how-to-write-software-requirements/. We used this to first of all change the structure of what we had, and used the feedback to iterate. For transparency you can see #link("https://chatgpt.com/share/6a9fe052-e070-83eb-b1f0-26061bab0bde", "the entire chat").

#pagebreak();

= Appendix <appendix>

== First Draft Requirements <first-draft-requirements>

These are the original requirements we came up with during our first meeting:

- The machine should be set into a state of emergency if the emergency button was pressed. 
- The machine should not pick up an item if there are no free spots available.
- The robot arm will never open its gripper to release an item unless it is positioned at a valid storage slot or at the conveyor belt drop off point.
- If a spot is taken [machine is aware of that] the machine should not put an item in that spot.
- If the robot arm moves to place an item into a storage location but the gripper sensor detects an unexpected item is already there, the system will immediately report a presence error.
- While an item is on the conveyor belt awaiting storage, no action that delivers a requested item to the conveyor belt can occur. 
- If the machine is in state of emergency, it should not move and the state of the gripper is not changing.
- If an item is placed onto the pickup point, the machine determines if there is a spot available, if so, it places the item there, else rejects it.
- If the machine gets the pickup request with a certain shelf ID, it fetches the item and puts it onto drop off point.
- If the conveyor belt is clear and no new item arrives, pending retrieval requests will be processed in FIFO order, unless an emergency stop or error occurs.
- If an emergency signal is received, the machine is set to the emergency state.
