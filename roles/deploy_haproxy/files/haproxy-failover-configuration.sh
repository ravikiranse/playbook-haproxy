#!/bin/bash

echo "prepare haproxy resource"

crm <<EOD
configure
primitive haproxy lsb:haproxy op monitor interval=2s
colocation haproxy-with-virtual-ip inf: haproxy virtual-ip
order haproxy-after-virtual-ip Mandatory: virtual-ip haproxy
verify
commit
up
quit
EOD
