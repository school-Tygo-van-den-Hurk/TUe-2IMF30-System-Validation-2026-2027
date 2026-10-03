# 2IMF30 System Validation

## Purpose

The purpose of this course is to learn how to abstractly design behavior of a
system and to analyze this behavior before the system is built. You'll learn
how to precisely write down behavior and prove it. With this practical
assignment you will experience how to apply the techniques.

## Tooling

Current version of mCRL2 toolset used is 202607.0.b3762fd537 (Release). To make
your life a bit easier, use `./run` bash script. It has some frequently used
actions that do not pollute the root dir, namely,

```
./run compile # compiles the model.
./run sim     # runs the simulation (gui).
./run lts     # generates labeled transition system, detecting deadlocks,
              # outputs their pretty-printed traces.
./run watch   # Compile on save, assumes you have `entr` on your system.
```
