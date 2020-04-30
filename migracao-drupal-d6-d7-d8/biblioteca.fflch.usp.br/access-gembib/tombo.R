
setwd("~/repos/gembib/MIGRACAO/")

material = read.csv("./TbMaterial.csv")
sugestao = read.csv("TbSugestao.csv")
tipo_material = read.csv("tbTipodeMaterial.csv")
verba = read.csv("tbVerba.csv")
usuarios = read.csv("tblUsuários.csv")
subcat = read.csv("tbTipodeMaterialSubcategoria.csv")

data = material

# substituir usuários
data = merge(data, usuarios, by.x="IdUsuario", by.y="IdUsuario", all.x=TRUE)

# sugestão
data = merge(data, sugestao, by.x="IdSugestao", by.y="id_sugestao",all.x=TRUE)

# substituir o tipo de material
data = merge(data, tipo_material, by.x="IdTipodeMaterial", by.y="idTipodeMaterial",all.x=TRUE)

# substituir tipo de verba
data = merge(data, verba, by.x="idTipodeVerba", by.y="idTipodeVerba", all.x=TRUE)

# substituir subcategoria
data = merge(data, subcat, by.x="tbTipodeMaterialSubcategoria", by.y="idTipodeMaterialSubcategoria", all.x=TRUE)

# corrigindo coluna departamento
data$Departamento = as.character(data$Departamento)
for(i in 1:nrow(data)) {
  data$Departamento[i] = strsplit(data$Departamento[i], "Departamento de ")[[1]][2]
}

# corrigindo coluna moeda
data$Moeda = as.character(data$Moeda)
for(i in 1:nrow(data)) {
  if(startsWith(data$Moeda[i],"R")){
    data$Moeda[i] = "REAL"
  } else {
    data$Moeda[i] = "DÓLAR"
  }
}

# corrigindo data_sugestao
data$Data.do.Pedido = as.character(data$Data.do.Pedido)
for(i in 1:nrow(data)) {
  temp <- as.Date(data$Data.do.Pedido[i], format = "%d/%m/%Y")
  data$Data.do.Pedido[i] = format(temp, "%Y-%m-%d 00:00:00");
}

# Corrigindo status
data$Status = as.character(data$Status)
for(i in 1:nrow(data)) {
  if(is.na(data$Status[i]) || data$Status[i] == "") data$Status[i] = "Tombado" 
}

# Remove FAPLIVROS VI
data$Status = as.character(data$Status)
for(i in 1:nrow(data)) {
  if(data$Status[i] == "FAPLIVROS VI") data$Status[i] = "Tombado" 
}

final = data.frame(
  "sugerido_por" = data$Usuario, 
  "insercao_por" = data$Usuario,
  "tipo_material" = data$Tipo_de_material,
  "subcategoria" = data$Subcategoria,
  "capes" = data$numero_capes,
  "verba" = data$NomedaVerba,
  "tombo" = data$Tombo,
  "tombo_antigo" = data$Tombo.Antigo,
  "cod_impressao" = data$código.de.impressão,
  "processo" = data$Processo,
  "fornecedor" = data$Fornecedor,
  "nota_fiscal" = data$Nota.Fiscal,
  "tipo_aquisicao"= data$tipo.de.aquisição,
  "moeda" = data$Moeda,
  "preco" = data$Preço,
  "autor" = data$Autor,
  "titulo" = data$Título,
  "edicao" = data$Edição,
  "volume" = data$Volume,
  "parte" = data$Parte,
  "fasciculo" = data$fascículo,
  "local" = data$Local,
  "editora" = data$Editora,
  "ano" = data$ano,
  "colecao" = data$Coleção,
  "isbn"  = data$ISBN,
  "escala" = data$Escala,
  "link" = data$Link,
  "dpto" = data$Departamento,
  "pedido_por" = data$Pedido.por,
  "finalidade" = data$Finalidade,
  "procedencia" = data$Procedência,
  "data_sugestao" = data$Data.do.Pedido,
  "created_at" = data$Data.do.Pedido,
  "updated_at" = data$Data.do.Pedido,
  "prioridade" = data$Prioridade,
  "status" = data$Status,
  "observacao" = data$Observação
)

write.csv(final, "~/itens.csv", row.names = FALSE, na="")


#### sugestões que não foram processadas
nao_processadas_ids = setdiff(sugestao$id_sugestao, material$IdSugestao )
nao_processada = sugestao[sugestao$id_sugestao %in% nao_processadas_ids,]

# substituir usuários
nao_processada = merge(nao_processada, usuarios, by.x="IdUsuario", by.y="IdUsuario", all.x=TRUE)

# corrigindo coluna moeda
nao_processada$MoedaSugestao = as.character(nao_processada$MoedaSugestao)
for(i in 1:nrow(nao_processada)) {
  if(startsWith(nao_processada$MoedaSugestao[i],"R")){
    nao_processada$MoedaSugestao[i] = "REAL"
  } else {
    nao_processada$MoedaSugestao[i] = "DÓLAR"
  }
}

# corrigindo data_sugestao
nao_processada$Data.do.Pedido = as.character(nao_processada$Data.do.Pedido)
for(i in 1:nrow(nao_processada)) {
  temp <- as.Date(nao_processada$Data.do.Pedido[i], format = "%d/%m/%Y")
  nao_processada$Data.do.Pedido[i] = format(temp, "%Y-%m-%d 00:00:00");
}

# corrigindo coluna departamento
nao_processada$Departamento = as.character(nao_processada$Departamento)
for(i in 1:nrow(nao_processada)) {
  nao_processada$Departamento[i] = strsplit(nao_processada$Departamento[i], "Departamento de ")[[1]][2]
}

# Corrigindo status
nao_processada$Status = as.character(nao_processada$Status)
for(i in 1:nrow(nao_processada)) {
  if(is.na(nao_processada$Status[i]) || nao_processada$Status[i] == "") nao_processada$Status[i] = "Sugestão" 
}

# Remove FAPLIVROS VI
nao_processada$Status = as.character(nao_processada$Status)
for(i in 1:nrow(nao_processada)) {
  if(nao_processada$Status[i] == "FAPLIVROS VI") nao_processada$Status[i] = "Esgotado" 
}
data = nao_processada

final = data.frame(
  "sugerido_por" = data$Usuario,
  "moeda" = data$MoedaSugestao,
  "preco" = data$PreçoSugestao,
  "autor" = data$Autor,
  "titulo" = data$Título,
  "edicao" = data$Edição,
  "volume" = data$Volume,
  "parte" = data$Parte,
  "fasciculo" = data$fascículo,
  "local" = data$Local,
  "editora" = data$Editora,
  "ano" = data$ano,
  "colecao" = data$Coleção,
  "isbn"  = data$ISBN,
  "escala" = data$Escala,
  "link" = data$Link,
  "dpto" = data$Departamento,
  "pedido_por" = data$Pedido.por,
  "finalidade" = data$Finalidade,
  "procedencia" = data$Procedência,
  "data_sugestao" = data$Data.do.Pedido,
  "created_at" = data$Data.do.Pedido,
  "updated_at" = data$Data.do.Pedido,
  "prioridade" = data$Prioridade,
  "status" = data$Status,
  "observacao" = data$Observação
)

write.csv(final, "~/sugestao.csv", row.names = FALSE, na="")


