### Fidelio

Unlock your mac with your iPhone.


#### Current Status

This is really just a hack right now.  It uses iBeacon protocol to determine
when two phones are close to each other, and past a certain threshold will
toggle a boolean on my Parse backend.

The mac should be running `run.py` which just makes rest calls indefinitely to
check the status of proximity from Parse.

When it detects a state change, it will run the appropriate apple script to log
the computer in or start the screen saver.

Unfortunately I couldn't find a way in Mountain Lion to just disable the screen
saver and log in in an effective way. So this is **super** hacky in that it uses
apple script to manually type in the users password into the password field and
hit enter.  If you know a better way please submit a pull request!


#### Setup

For this to work for you, you will need two iPhones (or equivalent mobile apple
products that support bluetooth 4.0) and a Mac. Also, you should set up your own
Parse account and use that.
