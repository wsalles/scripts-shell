#!/bin/bash

root="/mnt"
days=7

# Fluxo 4k
for dst in \
        elemental/elemental/Fluxo_4k/output; do
        find ${root}/${dst} -type f -mtime +$days -exec rm -f "{}" \; >> /var/log/removeOutput_Fluxo4k.log
done

# Ateme_EG 4k
for dst in \
        ateme/ateme_EG; do
        find ${root}/${dst} -type f ! -path "/mnt/ateme/ateme_EG/Amostras*" -mtime +$days -exec rm -f "{}" \; >> /var/log/removeOutput_AtemeEG4k.log
done
~
