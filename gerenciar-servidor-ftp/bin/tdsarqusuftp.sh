#!/bin/bash

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..    RELACAO de arquivos FTP para o site Web da FFLCH    ..::"
echo ""

echo "Aguarde. Fazendo a consulta e carregando arquivo ..."
out='/tmp/estranhos.txt'

echo "::.. relatório salvo em: $out  ..::" > $out
echo "::.. Arquivos/Diretorio vazios  ..::" >> $out
find /home/sftpfflch -empty | sort >> $out

echo "::.. Arquivos maiores que 100 MB ..::" >> $out
find /home/sftpfflch -size +100M -exec ls -lh {} + >> $out

estranhos="*exe dll asp lck mno avi mp3"
for i in $estranhos; do
  echo " "
  echo " ::.. Arquivos com extensao $i  ..::" >> $out
  find /home/sftpfflch -iname *.$i >> $out
done

vim $out
