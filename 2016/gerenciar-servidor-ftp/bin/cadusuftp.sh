#!/bin/bash

Opcao = "N"

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::.. CADASTRAMENTO de usuarios SFTP para o site Web da FFLCH ..::"
echo ""
echo "Informe o nome do usuario: " ; read Usuario
echo ""
echo "Informe uma senha para a conta:" ; read Senha
echo ""
echo "::.. Dados para cadastramento ..::"
echo "  Usuario: "$Usuario 
echo "  Senha: "$Senha
echo ""
echo "Os dados estao corretos? (s/N)" ; read -e Opcao

if [ $Opcao = "s" ]
then
  useradd --home /home/sftpfflch/$Usuario --create-home --shell /bin/false $Usuario
  echo $Usuario:"$Senha" | chpasswd
  usermod -G sftpfflch $Usuario
  chown root:root /home/sftpfflch/$Usuario
  chmod 755 /home/sftpfflch/$Usuario
  cd /home/sftpfflch/$Usuario
  mkdir public_html files
  chown $Usuario:sftpfflch *
  setquota -u $Usuario 512000 1024000 0 0 -a
  exit
else
  echo "Cadastramento nao realizado! Saindo do programa."
  exit
fi
