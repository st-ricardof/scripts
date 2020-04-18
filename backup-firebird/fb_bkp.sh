#!/bin/bash

# variaves
dia=$(date +%Y%m%d)
userpw="-user SYSDBA -password SENHA"
dir_bkp="/bkp/fb"
log=$dir_bkp/$dia"-bkp.log"
files=($(find /bdfb -type f -user firebird))

# verificando se o diretorio de backup existe, caso contrario, cria. 
if [ ! -d $dir_bkp ]; then
  # criando o diretorio de backup 
  mkdir -p $dir_bkp
  chown firebird:firebird $dir_bkp
  echo "Criando diretorio de backup" >> $log
else
  # remove o arquivo de log anterior
  rm -f $dir_bkp/*.log 2> /dev/null
  # pega a permissao (%a) e o dono (%U) do diretorio 
  info=( $(stat -c "%a %U" $dir_bkp) )
  if [ ${info[0]} != 755 ] ; then
    echo "Colocando a permissao correta" >> $log
    chmod 755 $dir_bkp
  fi
  if [ ${info[1]} != firebird ] ; then
    echo "setando firebird como owner" >> $log 
    chown firebird:firebird $dir_bkp
  fi
fi

echo "*** Iniciando Backup ***" >> $log
echo -n "Data: " >> $log && date +%d/%m/%Y-%H:%M:%S >> $log

for item in ${files[*]}
do
  bd=$(echo $item | cut -d '/' -f 4)
  echo -e "\nbackup do banco: " $bd >> $log
  gbak -B $item $dir_bkp/$bd.fbk $userpw >> $log 2>&1
done
echo -e "\n*** Finalizando Backup ***" >> $log
