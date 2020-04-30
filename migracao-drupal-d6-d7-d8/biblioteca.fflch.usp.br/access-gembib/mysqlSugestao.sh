#!/bin/bash

mysqlimport \
    --ignore-lines=1 \
    --lines-terminated-by="\r\n" \
    --local \
    --user=master \
    --password=master \
    --compress \
    --fields-terminated-by=, \
    --fields-optionally-enclosed-by='"' \
    --fields-escaped-by='' \
    --lines-terminated-by='\n' \
    --lock-tables \
    --verbose \
    --columns=sugerido_por,\
moeda,\
preco,\
autor,\
titulo,\
edicao,\
volume,\
parte,\
fasciculo,\
local,\
editora,\
ano,\
colecao,\
isbn,\
escala,\
link,\
dpto,\
pedido_por,\
finalidade,\
procedencia,\
data_sugestao,\
created_at,\
updated_at,\
prioridade,\
status,\
observacao \
    gembib /home/thiago/itens.csv
