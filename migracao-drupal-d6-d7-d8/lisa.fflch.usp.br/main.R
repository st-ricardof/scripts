# lisa.fflch.usp.br descritoes
rm(list=ls())
library(stringr)
library(rapport)

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
  #if(codigo == '' | is.na(codigo)) return('')
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

############# corrgi tid vídeos
df_videos = read.csv("./arruma_tid_descritores_videos.csv", stringsAsFactors = F)
df_videos <- data.frame(lapply(df_videos, trimws), stringsAsFactors = F)

# Varrer a tabela

for(i in 1:nrow(df_videos)) {
  for(coluna in 4:26){
    if(! is.na(df_videos[i,coluna])) {
      if( df_videos[i,coluna] != '') {
        codigo_antigo = df_videos[i,coluna]
        codigo_novo = df[df$SGA_DESCRITOR==codigo_antigo,]$tid
        if( length(codigo_novo)!=0 ){
          df_videos[i,coluna] = codigo_novo
        }
      }
    }
  }
}

write.csv(df_videos,"df_videos.csv",row.names = F, na = "")



############# corrgi tid imagens
df_imagens = read.csv("./arruma_tid_descritores_imagens.csv", stringsAsFactors = F)
df_imagens <- data.frame(lapply(df_imagens, trimws), stringsAsFactors = F)

# Varrer a tabela

for(i in 1:nrow(df_imagens)) {
  for(coluna in 5:28){
    if(! is.na(df_imagens[i,coluna])) {
      if( df_imagens[i,coluna] != '') {
        codigo_antigo = df_imagens[i,coluna]
        codigo_novo = df[df$SGA_DESCRITOR==codigo_antigo,]$tid
        if( length(codigo_novo)!=0 ){
          df_imagens[i,coluna] = codigo_novo
        }
      }
    }
  }
}

write.csv(df_imagens,"df_imagens.csv",row.names = F, na = "")

