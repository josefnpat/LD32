#!/bin/sh

# Love doesn't like symlinks! Oh noes!
SRC="src"
LOVE="love"
#LOVE="env DISPLAY=:0.0 love"

sh ./gengit.sh $SRC

# *.love
cd $SRC

TEMPFILE="._temp.love"
echo "Updating '$TEMPFILE' ..."
zip --filesync -r ../$TEMPFILE *
cd ..
exec $LOVE --fused $TEMPFILE "$@"
