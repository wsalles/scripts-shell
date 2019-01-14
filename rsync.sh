#!/bin/bash
LOCK_NAME="rsync_4k_HDR"
LOCK_DIR="/tmp/"${LOCK_NAME}".lock"
FRAMERATE=(2398 2997 5994)
log="/var/log/rsync_HDR.log"

lock () {
if mkdir ${LOCK_DIR}; then
    sleep 1;
else
    date >> "$log"
    echo "Lock failed. Exiting." >> "$log"
    exit 1
fi
}

unlock () {
rm -rf ${LOCK_DIR}
token=$(curl --header "Content-Type: application/json" -X POST --data '{"username" : "wsalles","password" : "Globo123"}' http://10.62.0.121:3333/auth| jq '.access_token' -r)
curl -X PUT http://10.62.0.121:3333/processes/rsync_4K_HDR -H "authorization: JWT $token" -H 'cache-control: no-cache' -H 'content-type: application/json' -d "{\"working\" : \"\", \"extras1\" : \"$extras1\", \"extras2\" : \"$extras2\"}"
}
rsyncExec () {
    for x in "${FRAMERATE[@]}"
    do
        echo "____________________"
        echo  "FRAMERATE: "$x
        echo "____________________"
        token=$(curl --header "Content-Type: application/json" -X POST --data '{"username" : "wsalles","password" : "Globo123"}' http://10.62.0.121:3333/auth| jq '.access_token' -r)
        curl -X PUT http://10.62.0.121:3333/processes/rsync_4K_HDR -H "authorization: JWT $token" -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"working" : "true"}'

        find /mnt/DISTRIBUICAO/$x/HDR/Audio_5_1/ -mmin +2 -printf %P\\0 \
         | rsync --log-file=/opt/output_4k_HDR_$x -aHAXxv --progress --files-from=- --from0 /mnt/DISTRIBUICAO/$x/HDR/Audio_5_1 /mnt/elemental-new/Fluxo_4k/input/HDR_$x
        #rsync --log-file=/opt/output_4k_HDR_$x -aHAXxv --numeric-ids --progress /mnt/DISTRIBUICAO/$x/HDR/Audio_5_1 /mnt/elemental-new/Fluxo_4k/input/HDR_$x

    done
}

lock;
rsyncExec;
unlock;