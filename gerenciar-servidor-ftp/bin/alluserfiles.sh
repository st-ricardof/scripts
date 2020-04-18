#!/bin/bash

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..    RELACAO de arquivos FTP para o site Web da FFLCH    ..::"
echo ""

echo "Informe o nome do usuario (ou deixe em branco para voltar ao menu principal): " ; read Usuario
if [ -x $Usuario ] ; then
  exit
else
  echo "Aguarde. Fazendo a consulta e carregando arquivo ..."
  out="/tmp/alluserfiles.txt"
  echo "::.. relatório salvo em: $out  ..::" > $out
  echo "::.. Todos arquivos de $Usuario  ..::" >> $out
  find /home/sftpfflch -user $Usuario | sort >> $out
  vim $out
fi

