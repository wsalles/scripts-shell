#!/usr/bin/env bash

root="/home"
days=10
NOW=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="/var/log/remove_GloboPlayAtemeTar.log"

# GloboPlayAtemeTar
alias echo='echo $NOW' >> "$LOG_FILE"
echo "Lista de arquivos deletados:" >> "$LOG_FILE"

for dst in \
        ateme/GloboPlayAtemeTar; do
        find ${root}/${dst} -type f -mtime +$days -print -exec rm -f "{}" \; >> "$LOG_FILE"
done
