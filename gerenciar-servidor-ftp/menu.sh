#!/bin/bash

#Este Shell Script é o menu para gerenciar os usuários FTP para o site Web da FFLCH.

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..                     Menu de Scripts                    ..::"
echo ""

echo " 1. Cadastro de usuarios"
echo " 2. Consulta de usuarios"
echo " 3. Exclusao de usuarios"
echo " 4. Relatorio de Quotas - Todos usuarios ou usuario especifico"
echo " 5. Relatorio de Quotas - Usuarios com quota excedida"
echo " 6. Alterar quota de usuarios"
echo " 7. Usuári@s logad@s por SFTP"
echo " 8. Arquivos 'estranhos' - Todos usuári@s"
echo " 9. Arquivos 'estranhos' - Por usuári@"
echo "10. Todos os Arquivos - Por usuario"
echo " 0. Sair do programa"
echo ""
echo "Informe a opcao desejada:" ; read Opcao
echo ""

cd $(dirname $0)

if [ $Opcao = "1" ] ; then
  accounts_manager_cadusuftp
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "2" ] ; then
  accounts_manager_conusuftp
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "3" ] ; then
  accounts_manager_excusuftp
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "4" ] ; then
  accounts_manager_relquousu
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "5" ] ; then
  repquota -uts /home/sftpfflch | grep +
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "6" ] ; then
  accounts_manager_setquousu
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
elif [ $Opcao = "7" ] ; then
  ps ax | grep sftpfflch --color
  echo " "
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
  exit
elif [ $Opcao = "8" ] ; then
  accounts_manager_tdsarqusuftp
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
  exit
elif [ $Opcao = "9" ] ; then
  accounts_manager_tdsarqusuftp_user
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
  exit
elif [ $Opcao = "10" ] ; then
  accounts_manager_alluserfiles
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
  exit
elif [ $Opcao = "0" ] ; then
  clear 
  echo "O programa foi encerrado com sucesso." ; 
  exit
else
  echo "Informe uma opcao valida." ;
  echo "Tecle ENTER para continuar ..." ; read Espera
  accounts_manager
fi
