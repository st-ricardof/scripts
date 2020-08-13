setwd("~/repos/scripts/tratamento-de-dados/caph.fflch.usp.br/")

teses <- read.csv('data/teses.csv')

# ano
anos = sort(as.character(unique(teses$ano)))
anos
remover_anos = c(anos[1:9],anos[85:86]) 
remover_anos
teses$ano[teses$ano %in% remover_anos] = NA

# grau
# write.csv(unique(teses$grau),"outputs/grau.csv",row.names=F)
map_grau = read.csv("data/mapeamento_grau.csv")
teses$grau = map_grau[match(teses$grau,map_grau$antigo),2]
write.table(paste(unique(map_grau$novo),unique(map_grau$novo),sep="|")[2:4],
            file="outputs/grau.txt",
            row.names=F,
            col.names=F,
            quote=F)

# autor: remove aspas
teses$autor = gsub('"','',teses$autor)

# Mapeamento dos departamentos
departamentos = sort(as.character(unique(teses$departamento)))
#write.csv(departamentos,"outputs/departamentos.csv",row.names=F)
mapeamento = read.csv("data/departamentos_teses_mapeamento_thiago.csv")
mapeamento[mapeamento==''] = NA

## A coluna departamento será desmembrada em 3: departamento_fflch, unidade_usp e instituicao_externa

# As que tem departamento, são da FFLCH.
fflch = 'Faculdade de Filosofia, Letras e Ciências Humanas'
mapeamento[!is.na(mapeamento$departamento_ffch),3] = fflch

# departamento_fflch: substuição dos nomes mapeados
departamento_fflch = mapeamento[match(teses$departamento,mapeamento$departamento),2]
teses = cbind(teses,departamento_fflch=departamento_fflch)

# unidade_usp: substuição dos nomes mapeados
unidade_usp = mapeamento[match(teses$departamento,mapeamento$departamento),3]
teses = cbind(teses,unidade_usp=unidade_usp)

# instituicao_externa: substuição dos nomes mapeados
instituicao_externa = mapeamento[match(teses$departamento,mapeamento$departamento),4]
teses = cbind(teses,instituicao_externa=instituicao_externa) 

# area/programa
areas = as.character(unique(teses$area))
areas = as.data.frame(areas)
#write.csv(areas,"outputs/areas.csv",row.names=F)

# Mapeamento programa
mapeamento_programa = read.csv('data/programas_teses_mapeamento.csv')
programa = mapeamento_programa[match(teses$area,mapeamento_programa$nome_antigo),2]
teses = cbind(teses,programa=programa) 

# volumes
teses$volumes = as.character(teses$volumes)
teses[ !(teses$volumes=='1' | teses$volumes=='2' | teses$volumes=='3' | teses$volumes=='4'),10] = ''
unique(teses$volumes)

# Exporta departamentos FFLCH
write.table(paste(unique(teses$departamento_fflch),unique(teses$departamento_fflch),sep="|"),
            file="outputs/departamentos.txt",
            row.names=F,
            col.names=F,
            quote=F)

# Unidades USP
write.table(paste(unique(teses$unidade_usp),unique(teses$unidade_usp),sep="|"),
            file="outputs/unidades_usp.txt",
            row.names=F,
            col.names=F,
            quote=F)


# exportar tabelas de apoio programa:
programas = unique(teses$programa)
programas = as.data.frame(programas)  
write.csv(programas[-1,],
          file="outputs/programas.csv",
          row.names = F)

# exportar tabelas de apoio instituição externa:
instituicao_externa = unique(teses$instituicao_externa)
instituicao_externa = as.data.frame(instituicao_externa)
write.csv(instituicao_externa[-1,],
          file="outputs/instituicao_externa.csv",
          row.names = F)


# Salva csv para ser importado no site
teses[is.na(teses)] = ''
write.csv(teses,file='outputs/teses.csv',row.names=F)
