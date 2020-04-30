# ea.fflch.usp.br
rm(list=ls())
library(stringr)
library(splitstackshape)
setwd("~/repos/scripts/migracao-drupal-d6-d7-d8/ea.fflch.usp.br/")

# Agenda de Defesas (Identificador: agenda_de_defesas)
df = read.csv("./exportverbetes.csv", stringsAsFactors = F)
nrow(df)
# trim nas colunas:
df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

# Não achei uma forma de migrar o campo:
# referências feitas no verbete
df = df[,-10]

df['field_autoria|format']='full_html'
colnames(df)[names(df) == "field_autoria"] = 'field_autoria|value'

df['field_bibliografia|format']='full_html'
colnames(df)[names(df) == "field_bibliografia"] = 'field_bibliografia|value'

df['field_verbete|format']='full_html'
colnames(df)[names(df) == "field_verbete"] = 'field_verbete|value'

# field_incial_do_verbete,field_palavras_chave,field_referencias_verbete

df = cSplit(df, "field_palavras_chave")

#df = cSplit(df, "field_referencias_verbete")

write.csv(df,"output_verbetes2.csv",row.names = F, na = "")
