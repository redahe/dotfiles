#!/usr/bin/python

import sys
import os

if len(sys.argv)<2:
    print("Usage: filename2dos.py longname")
    sys.exit(-1)

nm = sys.argv[1]
nm=os.path.basename(nm)
nm = nm.replace(' ', '')
end = nm[-4:]
beg = nm[:-4]
beg.replace('.', '')

if len(beg) > 8:
    beg = beg[:6] + '~1'

print os.path.basename(beg+end)
