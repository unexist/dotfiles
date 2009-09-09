#! /bin/bash
#
# toupper - Bash script that replaces the first
#						letter of every word with it's upper
#						case
#
# Copyright (c) 2004, Christoph Kappel <unexist@prime.zapto.org>
# Released under the GNU Public License
#

read init

retval=""

for w in $init
	do
		for ((i=0; i<${#w}; i++))
			do
				if [ $i -eq 0 ] ; then
					retval="${retval}`echo ${w:$i:1} | tr [:lower:] [:upper:]`"
				else
					retval="${retval}${w:i:1}"
				fi
			done

		retval="${retval} "
	done

echo $retval
