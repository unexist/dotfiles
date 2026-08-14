#!/usr/bin/env python3
import subprocess
import time
import sys

# read arguments from the run command: idel time (in seconds
dimtime = int(sys.argv[1])*1000
# brightness when dimmed (between 0 and 1)
dimmed = sys.argv[2]

def get(cmd):
    # just a helper function
    return subprocess.check_output(cmd).decode("utf-8").strip()

# get the connected screens
screens = [l.split()[0] for l in get("xrandr").splitlines()
           if " connected" in l]

# initial state (idle time > set time
check1 = False

while True:
    time.sleep(2)
    # get the current idle time (millisecond)
    t = int(get("xprintidle"))
    # see if idle time exceeds set time (True/False)
    check2 = t > dimtime
    # compare with last state
    if check2 != check1:
        # if state chenges, define new brightness...
        newset = dimmed if check2 else "1"
        # ...and set it
        for scr in screens:
            subprocess.Popen([
                "xrandr", "--output", scr, "--brightness", newset
                ])
    # set current state as initial one for the next loop cycle
    check1 = check2
