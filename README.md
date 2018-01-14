# Teste Analytica
### Rogério Rodrigues e Wanderson Marques

#### Problema

A partir de conjunto de dados de notas fiscais eletrônicas de um
restaurante, fazer estimativa de vendas futuras.

#### Missão

1. Fazer parsing dos dados e formatá-los para uso (ex: csv, dataframe)
2. Identificar padrão através de visualização dos dados que possa ajudar a estimar quanto um possivelmente cliente irá gastar.
3. Fazer previsão de vendas para a semana seguinte aos dados.

#### Etapas realizadas para atender o objetivo
1. Carregar o dataset (csv) como um Pandas DataFrame. Os dados foram normalizados a partir do arquivo JSON no R
2. Explorar os dados
3. Limpar e tranformar os dados
    1. Eliminar os atributos cujo valores são os mesmos para todos os registros
    2. Renomear colunas
    3. Converter o atributo dataHoraEmissao para DateTime
    4. Criar tabela de pedidos, selecionando atributos úteis e removendo duplicatas
    5. Criar tabela de itens dos pedidos
    6. Gerar atributos derivados de dataHoraEmissao
    7. Converter atributo mesa (infComplementar) para inteiro
    8. Traduzir dias da semana para português
    9. Visualizar os dataframes
    10. Ver pairplot
    11. Ver Outliers
    12. Remover Outliers
4. Visualização de informações relevantes
5. Avaliar desempenho das técnicas de Machine Learning
6. Aplicar técnica com melhor desempenho
