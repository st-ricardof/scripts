rm(list = ls())
setwd("~/repos/drupal-sites/drupal7/caph.fflch.usp.br/scripts/")

urls <- function(x){
  code = paste('find ./caph/ -name "*',x,'*" | grep .pdf',sep='')
  outputs = system(code, intern = T)
  outputs = paste("http://143.107.72.185/",outputs,sep="")
  as.character(paste(outputs,collapse = ","))
}


#urls('1.2.1')
#system('find ./caph/ -name "*1.2.1*" | grep .pdf', intern = T)
#system('find ./caph/ -name "*1.1.8*" | grep .pdf', intern = T)

dados <- read.csv("data/SBP.csv")
dados = cbind(dados,arquivos=NA)

#x = urls(dados[1,2])
#x
#dados[1,35] <-  x
#dados[1,35]  
  
for (i in seq(nrow(dados))){
  caminho = urls(dados[i,2])
  if (caminho != "http://143.107.72.185/") {
    dados[i,35] = caminho
  }
}

## investigando colunas
dados$Fundo = '16616'

# Corrigindo grafia das Técnica *** Múltiplos valores ***
dados$Técnica = gsub("Fotografia analógica","Fotografia Analógica",dados$Técnica)
dados$Técnica = gsub('impressão','Impressão',dados$Técnica)
dados$Técnica = gsub(' Impressão','Impressão',dados$Técnica)
dados$Técnica = gsub('Impressão ','Impressão',dados$Técnica)
dados$Técnica = gsub(' Manuscritura','Manuscritura',dados$Técnica)
dados$Técnica = gsub(' Mimeografia','Mimeografia',dados$Técnica)
unicos = unique(unlist(strsplit(paste(unique(dados$Técnica),collapse = ','),',')))
unicos = paste(unicos,unicos,sep='|')
write.csv(file="/tmp/tmp.csv",unicos,row.names = F,quote = F)

# suporte
dados$Suporte = gsub('papel','Papel',dados$Suporte)
unique(dados$Suporte)
write.csv(file="/tmp/tmp.csv",unique(dados$Suporte))

# Formato
unique(dados$Formato)
write.csv(file="/tmp/tmp.csv",unique(dados$Formato))

# Cromia 
dados$Cromia = gsub('preto e branco','Preto e Branco',dados$Cromia)
dados$Cromia = gsub('Preto e branco','Preto e Branco',dados$Cromia)
unique(dados$Cromia)
write.csv(file="/tmp/tmp.csv",unique(dados$Cromia))

# Idioma *** Múltiplos valores ***
unique(dados$Idioma)
dados$Idioma = gsub(' ','',dados$Idioma)
dados$Idioma = gsub('Fracês','Francês',dados$Idioma)
unicos = unique(unlist(strsplit(paste(unique(dados$Idioma),collapse = ','),',')))
unicos = paste(unicos,unicos,sep='|')
write.csv(file="/tmp/tmp.csv",unicos,row.names = F,quote = F)

# Descritores
dados$Descritores = paste(dados$Descritores,dados$Descritores.1,dados$Descritores.2,dados$Descritores.3,paste="|")

write.csv(file="outputs/SBP.csv",dados,row.names = F)
colnames(dados)


