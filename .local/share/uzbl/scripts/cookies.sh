#!/bin/sh

echo $*

# Config
cookie_config=$XDG_CONFIG_HOME/cookies/uzbl
cookie_data=$XDG_DATA_HOME/cookies/uzbl

# uri=$6
# uri=${uri/http:\/\/} # strip 'http://' part
# host=${uri/\/*/}
action=$8 # GET/PUT
host=$9
shift
path=$9
shift
cookie=$9

field_domain=$host
field_path=$path
field_name=
field_value=
field_exp='end_session'

# FOR NOW LETS KEEP IT SIMPLE AND JUST ALWAYS PUT AND ALWAYS GET
function parse_cookie () {
	IFS=$';'
	first_pair=1
	for pair in $cookie
	do
		if [ "$first_pair" -eq 1 ]
		then
			field_name=${pair%%=*}
			field_value=${pair#*=}
			first_pair=0
		else
			read -r pair <<< "$pair" #strip leading/trailing wite space
			key=${pair%%=*}
			val=${pair#*=}
			[ "$key" = "expires" ] && field_exp=`date -u -d "$val" +'%s'`
			# TODO: domain
			[ "$key" = "path" ] && field_path=$val
		fi
	done
	unset IFS
}

# match cookies in cookies.txt against hostname and path
function get_cookie () {
	path_esc=${path//\//\\/}
	search="^[^\t]*$host\t[^\t]*\t$path_esc"
	cookie=`awk "/$search/" $cookie_data 2>/dev/null | tail -n 1`
	if [ -z "$cookie" ]
	then
		false
	else
		read domain alow_read_other_subdomains path http_required expiration name value <<< "$cookie"
		cookie="$name=$value" 
		true
	fi
}

function save_cookie () {
	if parse_cookie
	then
		data="$field_domain\tFALSE\t$field_path\tFALSE\t$field_exp\t$field_name\t$field_value"
		echo -e "$data" >> $cookie_data
	fi
}

[ "x$action" = "xPUT" ] && save_cookie
[ "x$action" = "xGET" ] && get_cookie && echo "$cookie"

exit


# TODO: implement this later.
# $1 = section (TRUSTED or DENY)
# $2 =url
function match () {
	sed -n "/$1/,/^\$/p" $cookie_config 2>/dev/null | grep -q "^$host"
}

function fetch_cookie () {
	cookie=`cat $cookie_data`
}

function store_cookie () {
	echo $cookie > $cookie_data
}

if match TRUSTED $host
then
	[ $action = "PUT" ] && store_cookie $host
	[ $action = "GET" ] && fetch_cookie && echo "$cookie"
elif ! match DENY $host
then
	[ $action = "PUT" ] && store_cookie $host
	[ $action = "GET" ] && fetch_cookie && echo $cookie
fi
exit 0
