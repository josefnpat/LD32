#!/bin/sh

cd assets

find . -name "*.png" > list

texpack --trim --pretty --max-size 2048x2048 --padding 1 --output ../../src/assets/ss list

rm list
