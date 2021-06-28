#!/bin/sh

LOCAL_PORT=13306
# ping ensembldb.ensembl.org
# PING hl-ensembl-databases.ebi.ac.uk (193.62.192.245)
TARGET_HOST=193.62.192.245
TARGET_PORT=3306

# iptables
iptables -t nat -A PREROUTING -p tcp --dport $LOCAL_PORT -j DNAT --to-destination $TARGET_HOST:$TARGET_PORT
iptables -t nat -A POSTROUTING -d $TARGET_HOST -j MASQUERADE

# routing
echo "1" > /proc/sys/net/ipv4/ip_forward

# view rules
iptables -t nat -nvL --line-numbers

# to remove a rule by its number, for example, 2:
# iptables -t nat -D PREROUTING 2



# # persist iptables rules
# apt install iptables-persistent netfilter-persistent && systemctl enable netfilter-persistent
# cat <<EOF > /etc/iptables/rules.v4
# *nat
# # reset counters
# :PREROUTING - [0:0]
# :OUTPUT - [0:0]
# # flush
# -F PREROUTING
# -F OUTPUT
# # rules
# -A PREROUTING -p tcp --dport $LOCAL_PORT -j DNAT --to-destination $TARGET_HOST:$TARGET_PORT
# -A POSTROUTING -d $TARGET_HOST -j MASQUERADE
# COMMIT
# EOF
