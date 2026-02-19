#!/bin/zsh

INT_DEVS="wlp113s0f0 enp56s0"
EXT_DEVS="enx00e04d600197 enx00000000338d"

if [ "x$1" = "x1" ] ; then
    sudo -s <<-EOF
        echo 1 > /proc/sys/net/ipv4/ip_forward
        #sysctl -w net.ipv4.ip_forward=1
EOF

    for INT_DEV in `echo $INT_DEVS`; do
        for EXT_DEV in `echo $EXT_DEVS`; do
            sudo /sbin/iptables -t nat -A POSTROUTING -o $INT_DEV -j MASQUERADE -v
            sudo /sbin/iptables -A FORWARD -i $INT_DEV -o $EXT_DEV -m state --state RELATED,ESTABLISHED -j ACCEPT -v
            sudo /sbin/iptables -A FORWARD -i $EXT_DEV -o $INT_DEV -j ACCEPT -v
        done
    done
else
    sudo -s <<-EOF
        echo 0 > /proc/sys/net/ipv4/ip_forward
        #sudo sysctl -w net.ipv4.ip_forward=1

        /sbin/iptables -F
EOF
fi
