
#! /bin/sh
#
# chknme, converts spaces to underscores, upper to lowercase
# and umlauts in the current and all other subfolders.
#
# by unexist @ 14th March 2002

### variables

build=68
version=0.2
year='twothousandtwo'

working=`pwd`
local=`pwd`
depths=0

### functions

sign() {
        echo -e "\n\033[01;37;m>\033[01;36;m>>\033[00;38;m $1"
}

base() {
	origin="`basename "$1"`"
	origin="`echo $origin | tr A-Z a-z | tr ' ' '_' | sed s/[Ää]/'ae'/g | sed s/[Öö]/'oe'/g | sed s/[Üü]/'ue'/g `"
	echo "$origin"
}

join() {
	if [ -d "$1" ] ; then
		depths=`expr $depths + 1`
		cd "$1"
	fi
}

part() {
	depths=`expr $depths - 1`
	cd ..
}

depth() {

	for (( i=1; i<=$depths; i++ )) ; do
		
		if [ -z "$result" ] ; then
			local result="|"
		else
			result="$result  |"
		fi
	done

	echo "$result"
}

utilize() {

	local origin="$1"
	local utilized="`base "$1"`"

	if [ "$origin" != "$utilized" ] ; then
		mv "$origin" "$utilized"
	fi
}

count() {
	
	local dirs=0
	local files=0

	for item in * ; do

		if [ -d "$item" ] ; then
			dirs=`expr $dirs + 1`
		elif [ -f "$item" ] ; then	
			files=`expr $files + 1`
		fi

		utilize "$item"

	done

	echo -e "\033[01;36;m(\033[00;38;mfiles: \033[01;33;m$files\033[00;38;m, dirs: \033[01;33;m$dirs\033[00;36;m)"
}	

tree() {
	if [ -d "$1" ] ; then
		join "$1"
		echo -e "\033[01;37;m `depth`-[+] \033[01;36;m$1\033[00;38;m `count $1`"

		for item in * ; do
			tree "$item"
		done

		part
	fi
}


### main

echo -e "\n\033[01;36;mchknme name-checker \033[01;38;mv\033[01;33;m$version \033[01;36;m[\033[01;37;mbuild: \033[01;33;m$build\033[01;36;m]\033[00;38;m"
echo -e "\033[01;36;m(\033[01;38;mc\033[01;36;m) \033[01;37;mby \033[01;36;munexist \033[01;36;m[\033[01;37;m$year\033[01;36;m]\033[01;38;m\n"

echo -e "\033[01;37;m[+] \033[01;36;m`base $working`\033[00;38;m `count $working`"

for parent in *
do
	tree "$parent"
done

echo -e "\n\033[01;36;mdone.\033[00;38;m\n"

