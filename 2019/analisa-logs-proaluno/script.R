data <- read.csv("~/Downloads/log1.csv", row.names = NULL, stringsAsFactors= FALSE)

dates<-c()
accounts<-c()
address<-c()
tipo<-c()

for(i in seq(1:nrow(data))) {

  if(!grepl("PAFCS",data[i,6])) next
  
  col6array = strsplit(data[i,6], split='\n')[[1]]
  
  if(grepl("Nome da conta:",data[i,6])){
    accountsArray = col6array[grep("Nome da conta:",col6array)]
    accounts_string = paste(accountsArray, sep = " ", collapse = " - ")
    accounts = append(accounts,accounts_string)
    dates = append(dates,data[i,2])
    tipo = append(tipo,data[i,5])
  } else {
    accounts = append(accounts,"-")
    dates = append(dates,data[i,2])
    tipo = append(tipo,data[i,5])
  }
  
  if(grepl("Endereço do cliente",data[i,6])){
    addressArray = col6array[grep("Endereço do cliente",col6array)]
    addressString = paste(addressArray, sep = " ", collapse = " - ")
    address = append(address,addressString)
  } else {
    address = append(address,"-")
  }
}

output <- data.frame(dates,tipo,accounts,address)

output <- output[ which(output[,3]!='-' & output[,4]!='-'), ]

# Exclude PAFCS-

output <- output[ !grepl("PAFCS-",output[,3]), ]

write.csv(file = "~/output.csv",output)
