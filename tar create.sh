#!/bin/bash

set -e

#Config
paths=(/mnt/ateme/ateme_EG/{2398,2997,5994}/{HDR,SDR}/Audio_5_1/)
dest=/home/ateme/GloboPlayAtemeTar
log=/var/log/scripts/4kpublish_standard.log
mailList="TO"
mailListTeste="TO_TEST"
quantidadeTotal=6


lock () {
if mkdir /var/lock/4kpublish_standard.lock; then
    sleep 1;
else
    echo "Lock failed. Exiting." >> "$log"
    exit 1
fi
}

unlock () {
rm -rf /var/lock/4kpublish_standard.lock
}

check_use () {
  if ! lsof | grep "$1";
  then
    if ! [ -e $dest/"$1"_replace.tar ];
    then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

sendMail () {
  echo -e "Arquivo ""$filename"" foi entregue com sucesso!" | mail -S smtp=10.62.0.121 -r "suporte.plataformas@tvglobo.com.br" -s "[Publicação 4k] Replace: Sucesso" "$1";
}

tarMaker () {
for path in "${paths[@]}";
do
  find $path -maxdepth 1 -type f ! -empty -printf "%f\n" | grep -Po ".+?(?=_SDR)|.+?(?=_HDR)" | sort --unique | while read filename;
  do
    #fileList=( $(find $path -maxdepth 1 -type f -name "${filename}"*.mp4 ! -empty ! -name "*1PASS*" -printf "%f\n") )
    fileCount=$(find $path -maxdepth 1 -type f -name "${filename}"*.mp4 ! -empty ! -name "*1PASS*" -printf "%f\n" | wc -l)
    #sleep 3
    if [ $fileCount -eq $quantidadeTotal ];
    then
      if check_use "$filename";
      then
        echo $(date) >> $log
        pushd $path
        tar cf $dest/"$filename"_replace.tar --files-from /dev/null
        find $path -maxdepth 1 -type f -name "${filename}*.mp4" ! -empty ! -name "*1PASS*" -printf "%f\n" | while read f;
        do
          tar rf $dest/"$filename"_replace.tar "$f"
        done
        if [ $? -eq 0 ];
        then
          sendMail "$mailList";
        fi
        popd
      fi
    fi
  done
done
}

lock;
tarMaker;
unlock;