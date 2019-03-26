#!/bin/bash

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..    EXCLUSAO de usuarios FTP para o site Web da FFLCH   ..::"
echo ""

echo "Informe o nome do usuario (ou deixe em branco para voltar ao menu principal): " ; read Usuario
if [ -x $Usuario ] ; then
  exit
else
  echo "Observação: Se o usuári@ estiver logad@ é necessário matar o processo antes" ;
  echo " "
  ps aux | grep $Usuario
  echo " "
  echo "Deseja realmente excluir o usuario" $Usuario " (escolha N caso o mesmo esteja logado)? [S/N]" ; read Resposta
  if [ $Resposta = "S" ] ; then
    userdel $Usuario
    rm -rf /home/sftpfflch/$Usuario
    exit
  else
    echo "O usuario $Usuario nao foi excluido."
    exit
  fi
fi
