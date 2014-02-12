#!/usr/bin/env python2.7
import json,httplib
import time
import os
from subprocess import Popen, PIPE

connection = httplib.HTTPSConnection('api.parse.com', 443)
connection.connect()
time.sleep(5)
notRun = True;

while(1):
    connection.request('GET', '/1/classes/unlock/GZXPOuOy6R', '', {
       "X-Parse-Application-Id": "ybIY0GZfWSUTcHQyV2ix9OZgUeUbEOMcI6KSeSSk",
       "X-Parse-REST-API-Key": "IYQvkcy7ch7m8aDxmmHFC9OkMG4jqM81uIWNSqS4"
       })
    result = json.loads(connection.getresponse().read())
    value = result['nearby']

    if(value and notRun):
        print "phone nearby"
        #the phone is nearby, open up the applescript
        try:
            scpt =''' 
                     on run
                          tell application "/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app" to quit
                          tell application "System Events" to key code 125
                          delay .1
                          tell application "System Events" to keystroke "asdf"
                          delay .1
                          tell application "System Events" to keystroke return
                          delay 5
                     end run
                '''
            args = ['2', '2']
            p = Popen(['osascript', '-'] + args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
            stdout, stderr = p.communicate(scpt)
            notRun = False;
        
        except Exception as e:
            print "Caught " , str(e)
    elif (not value):
        print "Lost proximity"
        scpt = '''
                     on run
                        tell application "System Events" to start current screen saver
                     end run
            '''
        args = ['2', '2']
        p = Popen(['osascript', '-'] + args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
        stdout, stderr = p.communicate(scpt)
        notRun = True;


    time.sleep(5)
