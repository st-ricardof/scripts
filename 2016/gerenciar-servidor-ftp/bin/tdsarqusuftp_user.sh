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
  out='/tmp/estranhos_usuario.txt'

  echo "::.. relatório salvo em: $out  - Usuári@ em questão: $Usuario ..::" > $out
  echo "::.. Arquivos/Diretorio vazios  ..::" >> $out
  find /home/sftpfflch -empty -user $Usuario| sort >> $out

  echo "::.. Arquivos maiores que 100 MB ..::" >> $out
  find /home/sftpfflch -user $Usuario -size +100M -exec ls -lh {} + >> $out

  estranhos="*exe dll asp lck mno avi mp3"
  for i in $estranhos; do
    echo " "
    echo " ::.. Arquivos com extensao $i  ..::" >> $out
    find /home/sftpfflch -user $Usuario -iname *.$i >> $out
  done

vim $out
fi

