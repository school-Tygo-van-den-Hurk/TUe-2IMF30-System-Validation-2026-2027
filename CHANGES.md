# Changes to src_spec.mcrl2

These changes fix a few problems in the model. The main one was that the
gripper couldn't move so most properties weren't really being tested. (We were warned this would happen lol)
The other problems only showed up once that was fixed.

## 1. The gripper couldn't move (opAllowed)
Both the arm and the emergency controller used s_opAllowed (send).
Nobody used r_opAllowed (receive) so the arm never got permission.
**Fix:** the arm now uses r_opAllowed.

## 2. The handoff cleared signal was blocked
handoffCleared wasn't in the allow list so it could never happen.
**Fix:** added it. Also renamed handoffClearedBtn to handoffCleared and
comm_clearHandoff to clearHandoff so the names match the report.

## 3. Stuck when the handoff point is busy (TRE06)
While waiting for "operation done", the UI didn't listen for
clearHandoff. So storage and the UI waited for each other forever.
**Fix:** new WaitCompleted(slot) process that listens for both.

## 4. The arm kept going after an emergency (TRE10, TRE11)
The emergency button could be pressed right after the arm got
permission, and the arm would still engage or start moving.
**Fix:** new opDone step. The emergency controller waits until the arm
is done with its current step. Engage, disengage and starting a move all
use it.
**Note:** this means an emergency happens right after the current step,
not in the middle of it.

## 5. The model never ended (StorageClearHandoff)
Every retry on a busy handoff point added another unfinished step so
the model kept growing and mCRL2 couldn't finish.
**Fix:** moved things around so the retry is the last step.

## 6. New Held type (for TRE06)
Added Held = Nothing | Pickup | item(Slot). It's called item instead of
slot because slot is already used as a variable name. The report should
say item(Slot) too (please someone check in case i forget to change it).


## Result
./run solve now gives true for every property, and it's actually
testing things: picking up, storing, retrieving, a busy handoff point
and emergencies.
