# rodar em python3

import csv

# Le arquivo dados do arquivo em linhas
servidores = []

with open('../servidores.csv','r') as linhas:
    linhascsv = csv.reader(linhas)
    for linha in linhascsv:
        servidores.append(linha)

# colunas: hostname,prod,serviço,porta_ssh,local,ip_rede1,ip_rede2,ip_rede3,ip_rede4

# Encontrando todas redes
def ler_redes(servidores):
    ip_rede1 = [item[5] for item in servidores if item[5]]
    ip_rede2 = [item[6] for item in servidores if item[6]]
    ip_rede3 = [item[7] for item in servidores if item[7]]
    ip_rede4 = [item[8] for item in servidores if item[8]]

    ip_rede = ip_rede1[1:] + ip_rede2[1:] + ip_rede3[1:] + ip_rede4[1:]

    redes = [item.split('_')[1] + '_' + item.split('_')[2]  for item in ip_rede]
    return list(set(redes))

redes = ler_redes(servidores)
print(ler_redes(servidores))

file = open('fflch.diag','w') 
file.write('nwdiag {')      
file.write('\n')      

for rede in redes:
    network = 'network ' + rede.split('_')[1] +' { ' + '\n' + 'address = ' + '"' + rede.split('_')[0]  + '"' + ';' + '\n';
    file.write(network) 
    for host in servidores:
        if host[5].split('_')[1] == rede.split('_')[0]:
            servidor = '"' + host[0] + ' \\n ' + host[2] + '"' + ' [address =' + '"' + host[5].split('_')[0] + '"' + '];' + '\n';
            file.write(servidor)
        elif host[6]:
            if host[6].split('_')[1] == rede.split('_')[0]:
                servidor = '"' + host[0] + ' \\n ' + host[2] + '"' + ' [address =' + '"' + host[6].split('_')[0] + '"' + '];' + '\n';
                file.write(servidor)
        elif host[7]:
            if host[7].split('_')[1] == rede.split('_')[0]:
                servidor = '"' + host[0] + ' \\n ' + host[2] + '"' + ' [address =' + '"' + host[7].split('_')[0] + '"' + '];' + '\n';
                file.write(servidor)
        elif host[8]:
            if host[8].split('_')[1] == rede.split('_')[0]:
                servidor = '"' + host[0] + ' \\n ' + host[2] + '"' + ' [address =' + '"' + host[8].split('_')[0] + '"' + '];' + '\n';
                file.write(servidor)
    file.write('}')      

file.write('}')      
file.close() 

#nwdiag {
#  network rede8-vlan20 {
#      address = "143.107.8.0/24";
#      'alpha \n (firewall)' [address = "143.107.8.10"];
#  }


## lista contendo faltas de QUATRO HORAS depois da data fixada
#    elif vetor_data[i + 1] - vetor_data[i] == uma_hora*5:
#        falta04.append(vetor_data[i])
#
## lista contendo mais que CINCO HORAS faltando depois da data fixada
#    elif vetor_data[i + 1] - vetor_data[i] > uma_hora*5:
#        falta_mais_q_5.append(vetor_data[i])
#
#file = open('falt01.txt','w')
#for i in range (0,len(falta01)):
#    file.write(str(falta01[i]) + ',')
#file.close()
#
#file = open('falt02.txt','w')
#for i in range (0,len(falta02)):
#    file.write(str(falta02[i]) + ',')
#file.close()
