#!/bin/bash
# Scripta de BKP e RESTORE DE MYSQL

#"ESTE SCRIPT FOI CRIADO PARA RODAR DIRETAMENTE DA MÁQUINA LO-G-BD VIRTUAL (10.14.166.13) PARA FAZER BACKUP DO BD-FISICO (10.4.155.10) "


backup_parent_dir="drop/folder"

# Definição do MySQL
mysql_user="user_db"
mysql_password="password_db"
mysql_host=host_db

# Criando o diretório baseado na data e hora do backup
backup_date=`date +%Y-%m-%d_%H-%M`

backup_dir="${backup_parent_dir}/${backup_date}"

log_date=`date +%Y_%m_%d_%H-%M`

echo "${log_date} - Diretório do Backup: ${backup_dir}" > /var/log/backup_mysql.log

mkdir -p "${backup_dir}"


# Criando o DUMP, com as opções:
# --all-database (copia todos os schemas disponiveis)
# --routines (copia as procedures, triggers e rotinas)
# --quick (copia linha a linha ao invés de guardar em memória toda a tabela, aumenta a velocidade do dump)
# --lock-tables=false (não trava as tabelas do tipo MySAM, evita que o banco não permita escrita durante o dump)
# --single-transactions (separa as inserções em memória durante o dump em tabelas InnoDB, evitando travamento de tabelas)

log_date=`date +%Y_%m_%d_%H-%M`
echo "${log_date} CRIANDO DUMP\n" >> /var/log/backup_mysql.log

mysqldump -h ${mysql_host} --user=${mysql_user} --password=${mysql_password} --all-databases --add-drop-database --routines --quick --lock-tables=false --single-transaction > ${backup_dir}/DB.sql

log_date=`date +%Y_%m_%d_%H-%M`
echo "${log_date} - DUMP REALIZADO, REALIZANDO O RESTORE PARA O BANCO ${mysql_by} \n" >> /var/log/backup_mysql.log

#Com o DUMP criado com sucesso apaga os dumps mais antigos que 3 dias
find /box/SNAPSHOT_BD_LOSYSWEB/* -mmin +4320 -delete

#Restaura o DUMP criado para o banco virtual
#mysql --user=${mysql_user} --password=${mysql_password} < ${backup_dir}/DB.sql

#log_date=`date +%Y_%m_%d_%H-%M`
#echo  "${log_date} - RESTORE REALIZADO\n" >> /var/log/backup_mysql.log

#Renovando as permissões dos usuários
#mysql -u root --password=${mysql_password} -e "FLUSH PRIVILEGES"


#log_date=`date +%Y_%m_%d_%H-%M`
#echo  "${log_date} - Script encerrado corretamente\n" >> /var/log/backup_mysql.log
#exit 0