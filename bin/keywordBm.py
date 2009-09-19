#!/usr/bin/env python
#Vincent Kriek <vincent at vincentkriek dot nl>
#
import sys
import os
import subprocess

### Config settings, remember, everything must be a string!!!
y 						= "0" #This is the y-pos of dzen
x 						= "0" #This is the x-pos of dzen
width 				= "1000" #Dzen's width
lines 				= "10" #Number of vertical lines in dzen
bg 						= "darkgrey" #Dzen's background color
fg 						= "darkgreen" #Dzen's foreground
sb 						= "black"
sf 						= "red"
font 					= "monospace"

file = os.path.join(os.environ['XDG_DATA_HOME'],'uzbl/bookmarks.txt')



def addBookmark(url, keyword, title):
	f = open(file, 'a')
	f.write("%s %s %s\n" % (url, keyword, title))
	f.close()
	createBookmarkpage();

def getBookmark(keyword):
	f = open(file, 'r')
	newKeyword = " %s" % keyword 
	for line in f:
		words = line.split(" ", 2)
		if(words[1] == keyword):
			return words[0]

def removeBookmark():
	xwin = subprocess.Popen(["xwininfo", "-id", sys.argv[3]], stdout=subprocess.PIPE)
	xwininfo = xwin.communicate()[0]
	xwinArray = xwininfo.split("\n")
	print len(xwinArray)
	for line in xwinArray:
		if line.find("Absolute upper-left X") != -1:
			print line
			x = line.split(":")[1]
			x = x.strip(" ");
			print x
		if line.find("Absolute upper-left Y") != -1:
			y = line.split(":")[1]
			y = y.strip(" ")
		if line.find("Width") != -1:
			width = line.split(":")[1]
			width = width.strip(" ")
	cat = subprocess.Popen(["cat", file], stdout=subprocess.PIPE)
	dmenu = subprocess.Popen(["dmenu", "-xs", "-fn", font, "-l", lines, "-x", x, "-y", y, "-w", width, "-sb", sb, "-sf", sf, "-nb", bg, "-nf", fg], stdin=cat.stdout, stdout=subprocess.PIPE)
	output = dmenu.communicate()[0]
	output = output.strip(" ")
	old = open(file, 'r')
	new = open(file + ".tmp", 'w')
	for line in old:
		line = line.strip("\n")
		if line != output:
			new.write("%s\n" % line)
	
	old.close()
	new.close()

	os.rename(file + ".tmp", file)

def openUrl(url):
	if url != None:
		url = url
	elif sys.argv[9].find(".") == -1: 
		url = "http://www.google.com/search?hl=en&ie=ISO-8859-1&q=%s&aq=f" % sys.argv[9]
	else:
		url = sys.argv[9]
	
	if sys.argv[8] == "open":
		os.system("echo \"uri %s\" | socat - unix-connect:%s" % (url, sys.argv[5]))
	elif sys.argv[8] == "tab":
		os.system("uzbl \"%s\" &" % url)
		
if len(sys.argv) > 9:
	newurl = getBookmark(sys.argv[9])
else: 
	newurl = None

if(sys.argv[8] == "add" and newurl == None):
	addBookmark(sys.argv[6], sys.argv[9], sys.argv[7])
elif(sys.argv[8] == "get"): 
	if newurl != None:
		openUrl(newurl)
elif sys.argv[8] == "del":
	removeBookmark()
else:
	openUrl(newurl)
