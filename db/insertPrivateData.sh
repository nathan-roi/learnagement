#!/bin/bash

for i in $(ls ./data/[0-9]*.sql); do ln -s ../$i $(pwd)/sql/9_$(basename $i); done
