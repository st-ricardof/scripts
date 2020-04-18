setwd("~/remota/repos/caph-fflch-usp-br/scripts/")

# As informações do banco de dados de fotografia estão espalhadas em 2 sitemas: 
# - catálogo49  - sistema no Microsoft em Acess - Verdinho
# - GeralBDtese - sistema no Microsoft em Acess - Amarelinho 

catalogo49 <- read.csv('data/TabelaCatalogo49.csv')
amarelinho <- read.csv('data/TabelaGeralBdtese.csv')

## Explorando catalogo49 ##

# Suportes existentes
unique(catalogo49$suporte)

# Agregação dos seguintes suportes relacionados a fotografia:
suportes <- c('Fotografias',
              'Papel Fotográfico',
              'Negativo em Vidro',
              'Negativo Fotográfico',
              'Fotografia em Vidro',
              'Diapositivo (Slides)')

Microfichas

Diafilmes
Fitas de Rolo
Fitas Cassete
Vídeo Comercial
Filme 16mm
Diapositivo (Slides)
Microfilmes

Negativo em Vidro
Disquete
Negativo Fotográfico
Fotografia em Vidro

View(subset(catalogo49,suporte=='Microfichas'))

Vídeo Institucional           Papel                Fotografias          
Projeto Memória                Papel Fotográfico                    
 CD-Rom                video institucional  Vídeo Instiutcional  DVD                 
 Vídeo Terceiros      Hemeroteca                                 

# Quantidade total de entradas nos suportes de fotografia:
nrow(subset(catalogo49,suporte %in% suportes))

# Visualização das entradas nos 5 suportes:
View(subset(catalogo49,suporte==suportes[1])) # 211 registros
View(subset(catalogo49,suporte==suportes[2])) # 16 registro
View(subset(catalogo49,suporte==suportes[3])) # 1  registro
View(subset(catalogo49,suporte==suportes[4])) # 75 registros
View(subset(catalogo49,suporte==suportes[5])) # 1  registro
View(subset(catalogo49,suporte==suportes[6])) # 1  registro

# Verificar o que são os campos e se vamos mantê-los: 
#  nreferencia, quantidade, produção, numero, 

# Mapeamentos dos campos necessário para fotografia: 
colnames(catalogo49)
# fundo/Coleção = especificação ?
# descrição         especificação ?
# título       = é o mesmo título?
# tombo 
# série
# suporte - 5 ou 4?
# dimensão = sistema e o caso de negativos?
# cor - sistema e imagen se contradizem. 
# datas           - ok sem padrão
# local           - ok
# localização
# palavra chave
# inscrições ou marcas 
# forma de ingresso
# Notas
# status
# arquivo digital 

#######################################
# Explorando amarelinho:



# Suportes existentes
unique(amarelinho$suporte)

# Quantidade total de entradas nos suportes de fotografia:
nrow(subset(amarelinho,suporte %in% suportes))

# Visualização das entradas nos 5 suportes:
View(subset(amarelinho,suporte==suportes[1])) # 209 registros
View(subset(amarelinho,suporte==suportes[2])) # 16  registros
View(subset(amarelinho,suporte==suportes[3])) # 1   registro
View(subset(amarelinho,suporte==suportes[4])) # 68  registros
View(subset(amarelinho,suporte==suportes[5])) # 1  registro
