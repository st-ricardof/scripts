#!/bin/bash

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::.. RELACAO de quotas de usuarios para o site Web da FFLCH ..::"
echo ""

echo "Informe o nome do usuario (ou deixe em branco para ver a quota de todos os usuarios): " ; read Usuario
if [ -x $Usuario ] ; then
  repquota -ast | grep -v 'www-data\|root'
else
  repquota -ast | grep $Usuario --color
fi
