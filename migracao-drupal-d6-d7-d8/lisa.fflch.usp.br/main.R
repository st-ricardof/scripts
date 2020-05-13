# lisa.fflch.usp.br descritoes
rm(list=ls())
library(stringr)

setwd("~/repos/scripts/migracao-drupal-d6-d7-d8/lisa.fflch.usp.br/")

# trim nas colunas:
df = read.csv("./input_descritores.csv", stringsAsFactors = F)
df <- data.frame(lapply(df, trimws), stringsAsFactors = F)

df[,'corrigido'] = ''
df[,'parent'] = NA

for(i in 1:nrow(df)) {
  if(df[i,]$Codi_Descritor != "" & !is.na(df[i,]$Codi_Descritor)) {
    vetor = str_split(df[i,]$Codi_Descritor, "\\.")[[1]]
    vetor = as.integer(vetor)
    corrigido = paste(vetor,collapse=".")
    df[i,]$corrigido = corrigido
  }
}

#df[df$corrigido==107,]

procuraPai <- function(codigo) 
{
  if(codigo == '' | is.na(codigo)) return('')
  # pego quantos elementos tem no código: 001.2.1 será 3
  v = str_split(codigo, "\\.")[[1]]
  n = length(v)
  # se estamos na raiz, ou seja, n = 1, retornamos vazio
  if(n<=1) return('')
  # se estamos no segundo, ou seja, n = 2, o pai é o primeiro
  v = v[1:(length(v)-1)]
  pai = paste(v,collapse=".")

  tid = subset(df,df$corrigido==pai)$tid
  if(length(tid) == 0) return('')
  return(tid)
}

for(i in 1:nrow(df)) {
  df[i,]$parent = procuraPai(df[i,]$corrigido)
}

write.csv(df,"output_descritores.csv",row.names = F, na = "")
