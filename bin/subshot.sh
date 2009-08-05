#!/bin/bash

# Config
NAME="subtle"
SHOT=1

# Args
case "x$1" in
  x-d|x--debug) set -x ;;
  x-n|x--noshot) SHOT=0 ;;
  x) ;;
  x-h|x--help|*) echo "$0: [-d|--debug|-n|--noshot|-h|--help]"; exit ;;
esac

# Path
for P in subtle subtler import ompload
do
  PROG=`whereis $P | awk '{print $2}'`

  if [ -z $PROG ] ; then
    echo "$0: '$P' not found in path"
    exit
  fi

  eval `echo $P | tr "[:lower:]" "[:upper:]"`=$PROG
done

# Filename
IDX=1
DATE=`date +%Y%m%d`

while [ -e "$DATE-subtag-$IDX.png" ] 
do
  IDX=`expr $IDX + 1`
done

FILE="$DATE-subtag-$IDX.png"

# Fetch data
VIEW="`$SUBTLER -vCf | awk '{print $1}'`"
CLIENT="`$SUBTLER -cCf | awk '{print $1}'`"
GRAVITY="`$SUBTLER -cCf | awk '{print $5}'`"

# Create tag/view and jump
$SUBTLER -ta $NAME
$SUBTLER -va $NAME
$SUBTLER -vT $NAME $NAME
$SUBTLER -cT $CLIENT $NAME
$SUBTLER -cg $CLIENT 5
$SUBTLER -vj $NAME

clear

# Info
VERSION="`cat /etc/arch-release`"
KERNEL="`uname -r`"
WM="`$SUBTLE -v | head -n 1 | cut -d '-' -f 1`"

# Print info
echo -e "\e[0;34m"
echo -e "                 __"
echo -e "            _=(SDGJT=_"
echo -e "          _GTDJHGGFCVS)"
echo -e "         ,GTDJGGDTDFBGX0"
echo -e "        JDJDIJHRORVFSBSVL\e[0;30m-=+=,_\e[0;34m"
echo -e "       IJFDUFHJNXIXCDXDSV,\e[0;30m  \"DEBL\e[0;34m      OS: \e[0;37m$VERSION\e[0;34m"
echo -e "      |LKDSDJTDU=OUSCSBFLD.\e[0;30m   '?ZWX,\e[0;34m   Kernel: \e[0;37m$KERNEL\e[0;34m"
echo -e "      LMDSDSWH'   \`?DCBOSI\e[0;30m     DRDS],\e[0;34m  WM: \e[0;37m$WM\e[0;34m"
echo -e "     SDDFDFH'        \`0YEWD,\e[0;30m   )HDROD\e[0;34m"
echo -e "    !KMDOCG            &GSU|\e[0;30m_GFHRGO'\e[0;34m"
echo -e "    HKLSGP'           \e[0;30m__\e[0;34mTKM0\e[0;30mGHRBV)'\e[0;34m"
echo -e "   JSNRVW'       \e[0;30m__+MNAEC\e[0;34mIOI,\e[0;30mBN'\e[0;34m"
echo -e "   HELK['  \e[0;30m  __,=OFFXCBGHC\e[0;34mFD)"
echo -e "  JKGHEH\e[0;30m_-#DASDFSLSV='\e[0;34m    'EF"
echo -e "  !EHTI                    !H"
echo -e "   \`0F'                    '!"


# Shooting time
if [ $SHOT -eq 1 ] ; then
  $IMPORT -window root $FILE
  URL=`$OMPLOAD -u $FILE | awk '{print $4}'`
fi

# Tidy up
$SUBTLER -vj $VIEW
$SUBTLER -vk $NAME
$SUBTLER -tk $NAME
$SUBTLER -cg $CLIENT $GRAVITY

clear

echo $URL
