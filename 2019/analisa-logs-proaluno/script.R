data <- read.csv("~/Downloads/SEG.csv", row.names = NULL, stringsAsFactors= FALSE)

Encoding(data[,6]) <- "UTF-8"

dates<-c()
accounts<-c()
address<-c()

for(i in seq(1:nrow(data))) {

  if(!grepl("PAFCS",data[i,6])) next
  
  col6array = strsplit(data[i,6], split='\n')[[1]]
  
  if(grepl("Nome da conta:",data[i,6])){
    accountsArray = col6array[grep("Nome da conta:",col6array)]
    accounts_string = paste(accountsArray, sep = " ", collapse = " - ")

    accounts_string = sub("Nome da conta:","", accounts_string)
    accounts_string = sub("@PAFFLCH.FFLCH.USP.BR","", accounts_string)

    accounts = append(accounts,accounts_string)
    dates = append(dates,data[i,2])
  } else {
    accounts = append(accounts,"-")
    dates = append(dates,data[i,2])
  }
  
  if(grepl("Endereço do cliente",data[i,6])){
    addressArray = col6array[grep("Endereço do cliente",col6array)]
    addressString = paste(addressArray, sep = " ", collapse = " - ")

    addressString = gsub("Endereço do cliente:","",addressString)
    addressString = gsub("::ffff:","",addressString)
    
    address = append(address,addressString)
  } else {
    address = append(address,"-")
  }
}

output <- data.frame(dates,accounts,address)
output <- output[ which(output[,2]!='-' & output[,3]!='-'), ]

# Exclude PAFCS-
output <- output[ !grepl("PAFCS-",output[,2]), ]
output<-as.data.frame(sapply(output,trimws))

# Pessoas que mais fizeram login:
summary(output$accounts)

output[ which(output[,2]=='pa-teste'), ]

write.csv(file = "~/output.csv",output)
