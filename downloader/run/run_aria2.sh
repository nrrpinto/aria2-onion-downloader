#!/bin/sh
set -e

touch /conf/aria2.session
touch /log/aria2_log.txt /log/v2ray_access.log /log/v2ray_error.log
chmod 644 /log/*.log

python /home/creatorrc/creatorrc.py --speetor && cat tor_config.txt >> /conf/torrc && tor --runasdaemon 1 -f /conf/torrc || tor --runasdaemon 1

exec v2ray run -c /conf/config.json &
exec aria2c --conf-path=/conf/aria2.conf --log=/log/aria2_log.txt --rpc-listen-port=${RPCPORT} --rpc-secret=${RPCSECRET} --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15"

