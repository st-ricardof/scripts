# filosofia.fflch.usp.br
rm(list=ls())
library(stringr)
setwd("~/repos/scripts/migracao-drupal-d6-d7-d8/filosofia.flch.usp.br/")

######################
# Agenda de Defesas (Identificador: agenda_de_defesas)
df = read.csv("./inputs/agenda_de_defesas.csv", stringsAsFactors = F)
nrow(df)
# trim nas colunas:
df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

# Campos que precisa de tratamento:

# field_corpo_agenda_defesas: único campo com full_html
df['field_corpo_agenda_defesas|format']='full_html'
colnames(df)[names(df) == "field_corpo_agenda_defesas"] = 'field_corpo_agenda_defesas|value'

# field_data: transformar em: "2020-03-31T13:00:00"
## primeiro convertemos para data field_data para POSIXlt
# lista dos formats: https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html
df$field_data = strptime(df$field_data, "%d/%m/%Y - %H:%M")

# somar 3 horas
df$field_data = df$field_data + 3*60*60

# converte para string no formato "2020-03-31T13:00:00"
df$field_data = str_replace(as.character(df$field_data), ' ', 'T')

write.csv(df,"outputs/agenda_de_defesas.csv",row.names = F)

#########################
# Aviso (Identificador: aviso)
df = read.csv("./inputs/avisos.csv", stringsAsFactors = F)
nrow(df)

# trim nas colunas:
df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

# Campos que precisa de tratamento:

# field_corpo: único campo com full_html
df['field_corpo|format']='full_html'
colnames(df)[names(df) == "field_corpo"] = 'field_corpo|value'

df$field_data_expira_home = strptime(df$field_data_expira_home, "%d/%m/%Y")
df$field_data_expira_home = as.character(df$field_data_expira_home)

write.csv(df,"outputs/avisos.csv",row.names = F)

#################################
# Informes (Identificador: pagina_inicial)
df = read.csv("./inputs/informes.csv", stringsAsFactors = F)
nrow(df)
# trim nas colunas:

df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

# Campos que precisa de tratamento:

df['body|format']='full_html'
colnames(df)[names(df) == "body"] = 'body|value'

write.csv(df,"outputs/informes.csv",row.names = F)

###########################
# Agenda de Eventos (Identificador: eventos)
df = read.csv("./inputs/agenda_de_eventos.csv", stringsAsFactors = F)
nrow(df)

# trim nas colunas:
df <- data.frame(lapply(df, trimws), stringsAsFactors = FALSE)

# Campos que precisam de tratamento:

# field_informacoes_essenciais: full_html
df['field_informacoes_essenciais|format']='full_html'
colnames(df)[names(df) == "field_informacoes_essenciais"] = 'field_informacoes_essenciais|value'

# field_outras_informacoes_evento: full_html
df['field_outras_informacoes_evento|format']='full_html'
colnames(df)[names(df) == "field_outras_informacoes_evento"] = 'field_outras_informacoes_evento|value'

# field_data_do_evento e field_data_do_evento_fim: intervalo de datas
df$field_data_do_evento = strptime(df$field_data_do_evento, "%d/%m/%Y - %H:%M")+3*60*60
df$field_data_do_evento_fim = strptime(df$field_data_do_evento_fim, "%d/%m/%Y - %H:%M")+3*60*60

# converte para string no formato "2020-03-31T13:00:00"
df$field_data_do_evento = str_replace(as.character(df$field_data_do_evento), ' ', 'T')
df$field_data_do_evento_fim = str_replace(as.character(df$field_data_do_evento_fim), ' ', 'T')

colnames(df)[names(df) == "field_data_do_evento"] = 'field_data_do_evento|value'
colnames(df)[names(df) == "field_data_do_evento_fim"] = 'field_data_do_evento|end_value'

# field_data_eventos_externos e field_data_eventos_externos_fim (não tem hora)
df$field_data_eventos_externos = strptime(df$field_data_eventos_externos, "%d/%m/%Y")+3*60*60
df$field_data_eventos_externos_fim = strptime(df$field_data_eventos_externos_fim, "%d/%m/%Y")+3*60*60

df$field_data_eventos_externos = str_replace(as.character(df$field_data_eventos_externos), ' ', 'T')
df$field_data_eventos_externos_fim = str_replace(as.character(df$field_data_eventos_externos_fim), ' ', 'T')

colnames(df)[names(df) == "field_data_eventos_externos"] = 'field_data_eventos_externos|value'
colnames(df)[names(df) == "field_data_eventos_externos_fim"] = 'field_data_eventos_externos|end_value'

#write.csv(df[,c(1,2,3,4,5,6,7,8)],
#          "outputs/agenda_de_eventos.csv",row.names = F)

write.csv(df,"outputs/agenda_de_eventos.csv",row.names = F)

#############


# Bolsas Pós-graduação (Identificador: bolsas) - sem títulos
# Docentes (Identificador: professores) - sem títulos
# Editais e Oportunidades (Identificador: editais_e_oportunidades)
# Grade horária e ementas (Identificador: grade_horaria)

# Processos seletivos de Pós-graduação (Identificador: processo_seletivo_de_p_s_gradua_)
# Publicações (Identificador: lan_amentos)
# Página (Identificador: page)
#   No tipo de conteúdo página é usado o módulo field_jquery_tabs
#   Portanto os campos relacionado as tabs não foram migrados
#   Migrar anexos
# Pós-doutorado (Identificador: posdoutorado)
# Teses e dissertações defendidas (Identificador: teses_e_dissertacoes_defendidas)
# Vídeos (Identificador: video)



# Módulos pós-migração
# https://www.drupal.org/project/auto_entitylabel



