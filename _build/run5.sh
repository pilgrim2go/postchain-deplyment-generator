#!/bin/sh
# Author: van.le@chromaway.com
# -------------------------------------------------
PGHOST=${PGHOST:-localhost}
POSTGRES_USER=${POSTGRES_USER:-postchain}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postchain}
# replace postgres_db instead localhost
sed -i "s/localhost/$PGHOST/g" /usr/src/rell/config/common.properties
sed -i "s/localhost/$PGHOST/g" /usr/src/rell/config/node-config.properties
# replace postgres credential  instead postchain
sed -i "s/__postchain_db_user__/$POSTGRES_USER/g" /usr/src/rell/config/common.properties
sed -i "s/__postchain_db_password__/$POSTGRES_PASSWORD/g" /usr/src/rell/config/common.properties


# cat /usr/src/rell/config/node-config.properties

/opt/postchain-node/postchain.sh wipe-db -nc /usr/src/rell/config/node-config.properties
/opt/postchain-node/postchain.sh add-blockchain -bc  /usr/src/rell/config/0.xml -cid 0 -nc /usr/src/rell/config/node-config.properties
/opt/postchain-node/postchain.sh peerinfo-add -h node0 -nc /usr/src/rell/config/node-config.properties -p 9870 -pk 02A35356A347B693C3E973EC857C749C0001802DC9B85FF09C27310DF8F33D6BD6
/opt/postchain-node/postchain.sh peerinfo-add -h node5 -nc /usr/src/rell/config/node-config.properties -p 9870 -pk 0226866380BD1F6AE84F43BD301D95F275C40BCC4E1A56FF8425D8E6BF079D60BF

exec /opt/postchain-node/postchain.sh run-node -cid 0 -nc /usr/src/rell/config/node-config.properties