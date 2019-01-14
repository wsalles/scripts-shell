#!/bin/bash

#Config
path=/mnt/ateme/ateme_EG
dest=/home/ateme/GloboPlayAtemeTar
log=/var/log/scripts/4kpublish_standard.log
mailList="TO"

if mkdir /var/lock/4kpublish_standard.lock; then
    sleep 1;
else
    echo "Lock failed. Exiting." >> "$log"
    exit 1
fi

tarMaker () {
#NEW busca tudo até _SDR e _HDR
totalPrograma=$(ls $path | grep -Po ".+?(?=_SDR)|.+?(?=_HDR)" | sort --unique | wc -l)
for (( i=0; i<$totalPrograma; i++ ));
do
    programa=$(ls $path | grep -Po ".+(?=$1)" | sort --unique | head -n$(($i+1)) | tail -n1)
    progFrameRate=$(ls $path/"$programa"* | tail -n1| rev | cut -d"_" -f2 | rev)
    fileCount=$(ls $path | grep -v ".temp" | egrep -v '(06|12|18|24).mp4$'| grep -c "$programa"$1)
    fileName=$(ls $path | grep "$programa"$1 | grep '\.mp4$')
    if [ $fileCount -eq 5 ]; then
        if ! lsof | grep "$programa""$1"; then
            if ! [ -e $dest/"$programa""$1""$progFrameRate"_replace.tar ]; then
                echo $(date) >>$log
                pushd $path
                tar --exclude="*.temp" -cvf $dest/"$programa""$1""$progFrameRate"_replace.tar "$programa"$1*.mp4 2>>$log
                if [ $? -eq 0 ]; then
                    ssh 10.62.0.121 "echo -e \"Tar do programa \""$programa"\"_\""$1"\" foi entregue com sucesso!\" | mail -r \"suporte.plataformas@tvglobo.com.br\" -s \"[Publicação 4k] Tar: Sucesso\" \""$mailList"\"";
                fi
                popd
            fi
        fi
    fi
done
}

tarMaker "_SDR";
tarMaker "_HDR";
rm -rf /var/lock/4kpublish_standard.lock
