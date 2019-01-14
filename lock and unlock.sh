#!/bin/bash
LOCK_NAME="rsync_4k_SDR"
LOCK_DIR="/tmp/"${LOCK_NAME}".lock"
PROFILES=(2398 2997 5994)

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
pTar () {
   find $path -type f \( -name \*.mp4 -o -name \*.mxf \) ! -empty -printf "%h/%f\n" | while read f; do
        fileName=$(echo "$f" | rev | cut -d"/" -f1 | rev)
        if ! lsof | grep "$fileName"; then
            if ! [ -e $dest/"$fileName".tar ]; then
                echo "$(date +%F\ %T) Tar não encontrado no destino. Executando ""$fileName""." >> $log
                #sleep 50
                sleep 15
                pushd $(dirname "$f")
                tar -cvf $dest/"$fileName".tar "$fileName" 2>> $log;
                if [ $? -eq 0 ]; then
                    echo -e "Arquivo ""$fileName"" foi entregue com sucesso!" | mail -S smtp=10.62.0.121 -r "suporte.plataformas@tvglobo.com.br" -s "[Publicação 4k] HQ: Sucesso" "$mailList";
                    curl --data '{"file_name" : "'"${fileName}"'"}' -X PUT $URL_APP_JOB_DATA -H  "Content-Type: application/json"
                    echo "$(date +%F\ %T) tar feito "$f"" >> $log
                fi
                popd
            fi
        fi
    done
}

lock;
pTar;
unlock;