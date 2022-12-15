#!/usr/bin/python3
import os
from datetime import datetime

DIRPATH = '/etc'

# Get all entries in the directory w/ stats
entries = (os.path.join(DIRPATH, fn) for fn in os.listdir(DIRPATH))
entries = ((os.stat(path), path) for path in entries)

# Get the modified time only
entries_times = (entry[0].st_ctime for entry in entries)
entries_times = sorted(entries_times)

# Get the lowest timestamp (the creation date!)
distro_creation_timestamp = entries_times[0]

# Calculate alive time (delta)
creation_dt = datetime.fromtimestamp(distro_creation_timestamp)
now_dt = datetime.now()
alive_dt = now_dt - creation_dt

print(alive_dt)
