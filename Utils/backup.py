#!/usr/bin/env python
import shutil
import tarfile
import os
import time
from datetime import datetime


def make_tarfile():
    time_format = '%H:%M:%S'
    start_time = datetime.now().strftime(time_format)
    dev_dir = '/home/shanej/Development'
    scripts_dir = '/home/shanej/Scripts'
    output_filename = 'backup-' + time.strftime("%d-%m-%Y-%H:%M:%S") + '.tar.gz'

    with tarfile.open(output_filename, "w:gz") as tar:
        tar.add(scripts_dir, arcname=os.path.basename(scripts_dir))

    print 'archive ' + output_filename + ' generated'

    dest_folder = '/run/media/shanej/Data/Linux/Development'

    shutil.rmtree(dest_folder)
    shutil.copytree(dev_dir, dest_folder)

    print dev_dir + ' copied to ' + dest_folder

    backups_folder = '/run/media/shanej/Data/Linux/Backups'

    shutil.move(output_filename, backups_folder)

    print 'archive moved to ' + backups_folder

    finish_time = datetime.now().strftime(time_format)

    time_delta = datetime.strptime(finish_time, time_format) - datetime.strptime(start_time, time_format)

    print 'backup complete in ' + str(time_delta)


make_tarfile()