#!/bin/bash
LOCK_NAME="rsync_4k_SDR"
LOCK_DIR="/tmp/"${LOCK_NAME}".lock"
FRAMERATE=(2398 2997 5994)

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
}
rsyncExec () {
    for x in "${FRAMERATE[@]}"
    do
        rsync --log-file=/opt/output_4k_SDR_$x -aHAXxv --numeric-ids --progress /mnt/DISTRIBUICAO/$x/SDR/Audio_5_1 /mnt/elemental-new/Fluxo_4k/input/SDR_$x
    done
}

lock;
rsyncExec;
unlock;