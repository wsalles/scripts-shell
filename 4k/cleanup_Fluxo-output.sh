#!/bin/bash

root="/mnt"
days=10
NOW=$(date '+%Y-%m-%d %H:%M:%S')
LOG_PATH="/var/log/"


# Elemental 4k
alias echo='echo $NOW' >> "$LOG_PATH""remove_Output_Elemental4k.log"
echo "Lista de arquivos deletados:" >> "$LOG_PATH""remove_Output_Elemental4k.log"

for dst in \
        elemental/elemental/Fluxo_4k/output; do
        find ${root}/${dst} -type f -mtime +$days -print -exec rm -f "{}" \; >>  "$LOG_PATH""remove_Output_Elemental4k.log"
done



# Ateme_EG 4k
alias echo='echo $NOW' >> "$LOG_PATH""remove_Output_AtemeEG4k.log"
echo "Lista de arquivos deletados:" >> "$LOG_PATH""remove_Output_AtemeEG4k.log"

for dst in \
        ateme/ateme_EG; do
        find ${root}/${dst} -type f ! -path "/mnt/ateme/ateme_EG/Amostras*" -mtime +$days -print -exec rm -f "{}" \; >> "$LOG_PATH""remove_Output_AtemeEG4k.log"

done
