XAAS_VIP=$1 
crm <<EOD
configure
primitive haproxy lsb:haproxy op monitor interval="2s"
colocation haproxy-with-virtual-ip inf: haproxy $XAAS_VIP
order haproxy-after-virtual-ip Mandatory: $XAAS_VIP  haproxy
verify
commit
up
quit
EOD
