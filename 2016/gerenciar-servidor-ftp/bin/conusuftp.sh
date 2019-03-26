#!/bin/bash

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..    CONSULTA de usuarios FTP para o site Web da FFLCH   ..::"
echo ""

cat /etc/passwd | grep /home/sftpfflch | cut -d ":" -f 1,5,6 | sort
echo " "
