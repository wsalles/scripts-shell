#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
#
#   * Website    : https://wallacesalles.dev/
#   * Author     : Wallace Salles
#   * Mainteiner : Wallace Salles
#
#- VARIABLES -----------------------------------------------------------------------------------------------------------#
path=(/home /tmp)
days=10
LOG_FILE="/var/log/my-awesome-app.log"

#- FUNCTIONS -----------------------------------------------------------------------------------------------------------#
# Loading Default Functions
. $(dirname $0)/functions/others

#- Starting ------------------------------------------------------------------------------------------------------------#
log "Lista de arquivos deletados:" >> "$LOG_FILE"

for dst in $path; do
  find ${dst} -type f -mtime +$days -print -exec rm -f "{}" \; >> "$LOG_FILE"
done
