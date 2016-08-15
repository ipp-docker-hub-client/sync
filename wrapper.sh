#!/bin/bash
a="$1 $2 $3 $4 $5 $6 $7 $8 $9"
exec $a & pid=$!
sleep 10
kill -9 $pid
echo "Process code $! terminated with exit code $?"
