setwd("~/remota/repos/fflch/caph-fflch-usp-br/scripts/")

# - catálogo49  - sistema no Microsoft em Acess - Verdinho
catalogo49 <- read.csv('data/TabelaCatalogo49.csv')
unique(catalogo49$suporte)

# - GeralBDtese - sistema no Microsoft em Acess - Amarelinho 
amarelinho <- read.csv('data/TabelaGeralBdtese.csv')
unique(amarelinho$suporte)

microfilmes = subset(catalogo49,suporte=='Microfilmes')                  

## Explorando amarelinho ##

# Quantidade total de entrada no suporte:
nrow(subset(amarelinho,suporte %in% 'Microfilmes'))

# A quantidade de microfichas nos dois banco de dados são a mesma.
# aparentemente são os mesmo registros.

# Preparar dados para importação no Drupal
colunas = c('especificação', 
            'nreferencia', 
            'numero', 
            'região',
            'local',
            'data',
            'rolonum',
            'Bobina',
            'País',
            'Sistema',
            'titulo', 
            'quantidade', 
            'Sistema')

microfilmes$País # separar países
microfilmes$Sistema # separar
microfichas = microfichas[,colunas]
write.csv(microfilmes,file='outputs/microfilmes.csv')

