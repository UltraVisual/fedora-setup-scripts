#!/usr/bin/python

import os

for root, dirs, files in os.walk("/home/shanej/Development/python"):
    if files.__len__() > 0:
        print 'files for ' + root
    for filename in files:
        print os.path.join(root, filename)
    if dirs.__len__() > 0:
        print 'subdirectories for ' + root
    for directory in dirs:
        print os.path.join(root, directory)
