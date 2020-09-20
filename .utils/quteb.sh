#!/bin/bash

cmnd=""
for arg in "$@" 
do
cmnd="${cmnd} ${arg}"
done

qutebrowser "${cmnd}" &
