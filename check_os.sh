#!/bin/bash
log="/opt/scripts/list_os.txt"
#ip=(10.14.160.114 10.14.160.118)
values=$(<ips.csv)
ip=($values)

check () {
        for x in "${ip[@]}"
        do
                command=$(ping ""$x"" -c 1 | head -n2 | tail -n1 | awk '{ print $6 }' | awk -F "=" '{print $2}')
                if [ "$command" -le 64 ]; then
                        echo "$x"";Linux" >> "$log"
                else
                        if [ "$command" -eq 128 ]; then
                                echo "$x"";Windows" >> "$log"
                        else
                                echo "O IP ""$x"" nao foi encontrado"
                                echo "$x"";Unknown" >> "$log"
                        fi
                fi
        done
}

empty_log () {
        echo -n "" > "$log"
}

empty_log;
check;