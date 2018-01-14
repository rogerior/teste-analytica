# Tempo gasto = 4 horas

# Definindo local dos arquivos
setwd("C:/Users/Rogério/Documents/Analytica")

# Carregando pacotes
require(jsonlite)
library(dplyr)
library(tidyr)

# Lendo o JSON com os dados, a opção "flatten" é para que a função percorra recursivamente os itens do JSON
dados_json <- fromJSON("sample.txt", flatten = TRUE)

# Criando ID para cada venda, isso é necessário para depois de normalizar os dados, identificarmos quais linhas são de uma mesma venda
dados_json <- mutate(dados_json, id = rownames(dados_json))

# Normalizando a coluna dos itens da venda, estava em list e será transformado em uma linha pra cada item
normalizado <- unnest(dados_json, dets)

# Salvando os dados normalizados em CSV
write.csv2(normalizado, "dados.csv", row.names = FALSE)


####################################################
# Inicio da execução da regra de associação Apriori#
####################################################

# Inicio da preparação dos dados para o algoritmo

#
normalizado$prod.xProd <- as.factor(normalizado$prod.xProd)

# Agrupando itens de cada mesa em uma linha
library(plyr)
itens <- ddply(normalizado, c("id"), function(normalizado)paste(normalizado$prod.xProd,collapse = ","))

# Removendo o id, pois ele não será necessário na execução do Apriori
itens$id <- NULL

# Renomeando coluna de itens
colnames(itens) <- c("itens_pedido")

# Salvando CSV dos itens dos pedidos
write.csv(itens, 'itens_pedido.csv', row.names = TRUE, quote = FALSE)

# Fim da preparação dos dados


# Inicio da execução do algortimo Apriori

# carregando Pacote
library(arules)

# Lendo o CSV com os dados preparados
dados_apriori = read.transactions(file="itens_pedido.csv", rm.duplicates= FALSE, format="basket",sep=",",cols=1);

# Rodando apriori
basket_rules <- apriori(dados_apriori,parameter = list(minlen=2,sup = 0.001, conf = 0.1, target="rules"))

# Olhando as 20 primeiras regras geradas
inspect(basket_rules[0:20])

# Ordenando pelo "lift"
inspect(sort(basket_rules, by ='lift', decreasing = T)[0:20])

# Carregando pacote e gerando plot interativo das 20 regras geradas ordenadas pelo "lift"
library(arulesViz)
plot((sort(basket_rules, by ='lift', decreasing = T)[0:20]),method="graph",engine = 'interactive',shading=NA)


