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
# Usage: ./run <command>
# Commands:
#    lps        Compile mcrl2 to lps.
#    lts        Generate state space, traces and detect deadlocks.
#    pbes       Builds pbes from properies.
$    watch      Watch the input, builds lps and pbes on changes.
```
