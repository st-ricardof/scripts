# filosofia.fflch.usp.br
rm(list=ls())
library(stringr)
setwd("~/repos/scripts/migracao-drupal-d6-d7-d8/projetosp2010.fflch.usp.br/")

######################
# Agenda de Defesas (Identificador: agenda_de_defesas)
df = read.csv("./export.csv", stringsAsFactors = F)
nrow(df)
# trim nas colunas:
df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

df$field_nomes_arquivos = str_replace_all(df$field_nomes_arquivos, 'http://d7projetosp2010.fflch.usp.br/system/files/', '')

write.csv(df,"output.csv",row.names = F, na = "")
