#!/bin/bash

Opcao = "N"

clear
echo "::..                Universidade de Sao Paulo               ..::"
echo "::..    Faculdade de Filosofia, Letras e Ciencias Humanas   ..::"
echo "::..              Secao Tecnica de Informatica              ..::"
echo "::..                ALTERACAO de quota de usuarios               ..::"
echo ""
echo "Informe o nome do usuario: " ; read Usuario
echo ""
echo "Informe a quota de espaco em disco (em megabytes -  0 para ilimitado):" ; read QuotaE
echo ""
echo "Informe a quota de arquivos (0 para ilimitado):" ; read QuotaA
echo ""
echo "::.. Dados para alteracao ..::"
echo " Usuario: "$Usuario 
echo "  Espaco: "$QuotaE "MB"
echo "Arquivos: "$QuotaA "arquivos"
echo ""
echo "Os dados estao corretos? (s/N)" ; read Opcao

if [ $Opcao = "s" ]
then
  let QuotaE="$QuotaE * 1024"
  let QuotaE20="$QuotaE + ($QuotaE * 20 / 100)"
  let QuotaA20="$QuotaA + ($QuotaA * 20 / 100)"
  setquota -u $Usuario $QuotaE $QuotaE20 $QuotaA $QuotaA20 -a
  exit
else
  echo "Alteracao nao realizada! Saindo do programa."
  exit
fi
