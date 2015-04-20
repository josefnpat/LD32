#!/bin/sh

cd assets
find . -name "*.png" > list
texpack --trim --pretty --max-size 2048x2048 --padding 1 --output ../../src/assets/ss list
rm list
cd -

cd hearts
find . -name "*.png" > list
texpack --output ../../src/assets/hearts --max-size 2048x2048 --pretty --trim list 
rm list
cd -
