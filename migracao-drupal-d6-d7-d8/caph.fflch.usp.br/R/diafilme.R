setwd("~/remota/repos/fflch/drupal-sites/drupal7/caph.fflch.usp.br/scripts/")

# - catálogo49  - sistema no Microsoft em Acess - Verdinho
catalogo49 <- read.csv('data/TabelaCatalogo49.csv')
unique(catalogo49$suporte)

# - GeralBDtese - sistema no Microsoft em Acess - Amarelinho 
amarelinho <- read.csv('data/TabelaGeralBdtese.csv')
unique(amarelinho$suporte)

diafilmes = subset(catalogo49,suporte=='Diafilmes')                      

## Explorando amarelinho ##

# Quantidade total de entrada no suporte:
nrow(subset(amarelinho,suporte %in% 'Diafilmes'))

# A quantidade de microfichas nos dois banco de dados são a mesma.
# aparentemente são os mesmo registros.

# Preparar dados para importação no Drupal
colunas = c('especificação', 'nreferencia', 'titulo')
diafilmes = diafilmes[,colunas]
write.csv(diafilmes,file='outputs/diafilmes.csv')

