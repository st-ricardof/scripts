data <- read.csv("~/Downloads/log1.csv", row.names = NULL,nrows=100000, stringsAsFactors= FALSE)

dates<-c()
accounts<-c()
address<-c()

for(i in seq(1:nrow(data))) {

  if(!grepl("PAFCS",data[i,6])) next
  
  col6array = strsplit(data[i,6], split='\n')[[1]]
  
  if(grepl("Nome da Conta:",data[i,6])){
    accountsArray = col6array[grep("Nome da Conta:",col6array)]
    accounts_string = paste(accountsArray, sep = " ", collapse = " - ")
    accounts = append(accounts,accounts_string)
    dates = append(dates,data[i,2])
  } else {
    accounts = append(accounts," - ")
    dates = append(dates,data[i,2])
  }
  
  if(grepl("Endereço da Rede",data[i,6])){
    addressArray = col6array[grep("Endereço da Rede",col6array)]
    addressString = paste(addressArray, sep = " ", collapse = " - ")
    address = append(address,addressString)
  } else {
    address = append(address," - ")
  }

}

output <- data.frame(dates,accounts,address)

#output <- output[ which(output[,2]!=NULL & output[,3]!=NULL), ]

write.csv(file = "~/output.csv",output)
