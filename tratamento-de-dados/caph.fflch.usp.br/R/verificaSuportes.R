setwd("~/remota/repos/fflch/drupal-sites/drupal7/caph.fflch.usp.br/scripts/")

# - catálogo49  - sistema no Microsoft em Acess - Verdinho
catalogo49 <- read.csv('data/TabelaCatalogo49.csv')
write.csv(file='a.csv',unique(catalogo49$suporte))

# - GeralBDtese - sistema no Microsoft em Acess - Amarelinho 
amarelinho <- read.csv('data/TabelaGeralBdtese.csv')
unique(amarelinho$suporte)

# Verifica se há algum suporte diferente nos dois
setdiff(unique(catalogo49$suporte),unique(amarelinho$suporte))
setdiff(unique(amarelinho$suporte),unique(catalogo49$suporte)) # vamos ignorar: diapositivo e slides

# Conferir sempre nas duas bases: catalogo49 e amarelinho

# 1) Diafilmes - ok
nrow(subset(amarelinho,suporte %in% 'Diafilmes'))
diafilmes = subset(catalogo49,suporte=='Diafilmes')
colunas = c('especificação', 'nreferencia', 'titulo')
diafilmes = diafilmes[,colunas]
write.csv(diafilmes,file='outputs/diafilmes.csv')

# 2) Microfichas - ok
nrow(subset(amarelinho,suporte %in% 'Microfichas'))
microfichas = subset(catalogo49,suporte=='Microfichas') 
colunas = c('especificação', 'nreferencia', 'numero', 'titulo', 'quantidade', 'Sistema')
microfichas = microfichas[,colunas]
write.csv(microfichas,file='outputs/microfichas.csv')
unique(microfichas$Sistema)

# 3) Agrupamento: Fotografias, Papel Fotográfico, Negativo em Vidro, Negativo Fotográfico, Fotografia em Vidro e Diapositivo (Slides)
suportes <- c('Fotografias','Papel Fotográfico','Negativo em Vidro','Negativo Fotográfico','Fotografia em Vidro','Diapositivo (Slides)')

# 4) Agrupamento: video institucional, Vídeo Instiutcional, DVD, Vídeo Terceiros, Vídeo Institucional, Vídeo Comercial
nrow(subset(catalogo49,suporte %in% 'DVD'))
DVD = subset(catalogo49,suporte=='DVD') 

# 5) Filme 16mm
colunas = c('especificação','nreferencia','titulo', 'tempo','rolonum','suporte','Sistema','Imagem','produção')

# 6) Microfilmes
microfilmes = subset(catalogo49,suporte=='Microfilmes')                  
nrow(subset(amarelinho,suporte %in% 'Microfilmes'))
colunas = c('especificação','nreferencia','numero','região','local','data','rolonum','Bobina','País','Sistema','titulo','quantidade','Sistema')
microfilmes$País # separar países
microfilmes$Sistema # separar
microfilmes = microfilmes[,colunas]
write.csv(microfilmes,file='outputs/microfilmes.csv')

# 7) Papel



# 8) Projeto Memória

# 9) Disquete

# 10) CD-Rom

                 

# 11) Hemeroteca
nrow(subset(amarelinho,suporte %in% 'Hemeroteca'))
hemeroteca = subset(catalogo49,suporte=='Hemeroteca')                      
colunas = c('especificação','nreferencia','numero','local','data','titulo','quantidade','País')

# 12) Fitas de Rolo

# 13) Fitas Cassete
nrow(subset(catalogo49,suporte %in% 'Fitas Cassete'))
FitasCassete = subset(catalogo49,suporte=='Fitas Cassete')  
 
# 14) sem categoria


