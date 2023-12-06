# Importação do Banco de Dados
Foi feito a importação do banco de dados utilizando-se da ferramenta/programa Microsoft SQL Server. Segue um passo a passo de como fazê-lo:
1. Com o MSSQL Server aberto, clique em banco de dados com o botão direito;
2. Em seguida, clique em Restaurar Banco de Dados;
3. Marque a caixa que diz "Dispositivo" e clique nos três pontinhos para escolher seu arquivo.
Assim foi feita a recuperação do banco de dados em questão que foi entregue aos alunos.

# Modelagem Lógica do Banco de Dados
Após a normalização do banco de dados, foi feito a seguinte modelagem lógica dos dados presentes. O Script que apresenta a normalização feita no banco está disponível junto ao repositório. 
![[Modelagem Lógica do Trabalho de BDII.png]]
# Análise Exploratória dos Dados
```Python
# Importando bibliotecas  
import pandas as pd  
import matplotlib.pyplot as plt  
import seaborn as sns  
from sqlalchemy import create_engine  
  
server_name = 'DESKTOP-QNGLT5G'  
database_name = 'Financeiro'  
  
# Configuração da string de conexão SQLAlchemy com autenticação do Windows  
conn_str = f'mssql+pyodbc://{server_name}/{database_name}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server'  
  
# Criar uma instância do SQLAlchemy Engine  
conexao_sql = create_engine(conn_str)  
  
# Carregando dados do SQL Server para um DataFrame Pandas  
# Substitua 'sua_tabela' com o nome da tabela que você deseja analisar  
consulta_sql = "SELECT * FROM tb_execucao_financeira"  
df = pd.read_sql(consulta_sql, conexao_sql)  
  
# 1. Entendimento da Base de Dados  
print("Informações Gerais:")  
print(df.info())  
  
print("\nVisualização Inicial:")  
print(df.head())  
  
# 2. Tratamento de Dados Nulos  
# Contagem de valores nulos por coluna  
print("\nContagem de Valores Nulos por Coluna:")  
print(df.isnull().sum())  
  
# Gráfico de barras para visualizar os valores nulos por coluna  
df.isnull().sum().plot(kind='bar', figsize=(10, 6))  
plt.title('Contagem de Valores Nulos por Coluna')  
plt.xlabel('Coluna')  
plt.ylabel('Contagem de Nulos')  
plt.show()  
  
# 3. Estatísticas Descritivas  
print("\nResumo Estatístico:")  
print(df.describe())  
  
# Gráfico de dispersão para investigar relação entre duas variáveis (ex: 'vlr_empenho' e 'valor_pago')  
plt.scatter(df['vlr_empenho'], df['valor_pago'])  
plt.title('Relação entre Valor de Empenho e Valor Pago')  
plt.xlabel('Valor de Empenho')  
plt.ylabel('Valor Pago')  
plt.show()
```

O código acima foi utilizado para fazer a análise exploratória dos dados estabelecidos e os seguintes resultados foram vistos:

## Informações Gerais[](http://localhost:8888/lab#Informações-Gerais)

O conjunto de dados é representado por uma estrutura de DataFrame da biblioteca Pandas e possui as seguintes características:

```
Número de Entradas (Linhas): 2,025,116
Número de Colunas: 37
```

## Colunas do Dataframe[](http://localhost:8888/lab#Colunas-do-Dataframe)

```
id: Identificador único do registro (int64)
num_ano: Ano do registro (int64)
cod_ne: Código NE (object)
codigo_orgao: Código do órgão (object)
dsc_orgao: Descrição do órgão (object)
cod_credor: Código do credor (object)
dsc_nome_credor: Nome do credor (object)
cod_fonte: Código da fonte (object)
dsc_fonte: Descrição da fonte (object)
cod_funcao: Código da função (object)
dsc_funcao: Descrição da função (object)
cod_item: Código do item (object)
dsc_item: Descrição do item (object)
cod_item_elemento: Código do elemento do item (object)
dsc_item_elemento: Descrição do elemento do item (object)
cod_item_categoria: Código da categoria do item (object)
dsc_item_categoria: Descrição da categoria do item (object)
cod_item_grupo: Código do grupo do item (object)
dsc_item_grupo: Descrição do grupo do item (object)
dsc_modalidade_licitacao: Descrição da modalidade de licitação (object)
cod_item_modalidade: Código da modalidade do item (int64)
dsc_item_modalidade: Descrição da modalidade do item (object)
cod_programa: Código do programa (object)
dsc_programa: Descrição do programa (object)
cod_subfuncao: Código da subfunção (object)
dsc_subfuncao: Descrição da subfunção (object)
num_sic: Número SIC (object)
cod_np: Código NP (object)
vlr_empenho: Valor do empenho (float64)
vlr_liquidado: Valor liquidado (object)
valor_pago: Valor pago (float64)
vlr_resto_pagar: Valor do resto a pagar (float64)
dth_empenho: Data e hora do empenho (datetime64[ns])
dth_pagamento: Data e hora do pagamento (datetime64[ns])
dth_liquidacao: Data e hora da liquidação (object)
dth_processamento: Data e hora do processamento (datetime64[ns])
num_ano_np: Ano NP (float64)
```

<class 'pandas.core.frame.DataFrame'> RangeIndex: 2025116 entries, 0 to 2025115 Data columns (total 37 columns):

## Column Dtype[](http://localhost:8888/lab#Column--------------------Dtype)

---

0 id int64  
1 num_ano int64  
2 cod_ne object  
3 codigo_orgao object  
4 dsc_orgao object  
5 cod_credor object  
6 dsc_nome_credor object  
7 cod_fonte object  
8 dsc_fonte object  
9 cod_funcao object  
10 dsc_funcao object  
11 cod_item object  
12 dsc_item object  
13 cod_item_elemento object  
14 dsc_item_elemento object  
15 cod_item_categoria object  
16 dsc_item_categoria object  
17 cod_item_grupo object  
18 dsc_item_grupo object  
19 dsc_modalidade_licitacao object  
20 cod_item_modalidade int64  
21 dsc_item_modalidade object  
22 cod_programa object  
23 dsc_programa object  
24 cod_subfuncao object  
25 dsc_subfuncao object  
26 num_sic object  
27 cod_np object  
28 vlr_empenho float64  
29 vlr_liquidado object  
30 valor_pago float64  
31 vlr_resto_pagar float64  
32 dth_empenho datetime64[ns] 
33 dth_pagamento datetime64[ns] 
34 dth_liquidacao object  
35 dth_processamento datetime64[ns]
36 num_ano_np float64  
dtypes: datetime64[ns](http://localhost:8888/files/3?_xsrf=2%7C9bfefe8e%7Cf23410350b87465dce4d516f985f2c40%7C1701643127), float64(4), int64(3), object(27) memory usage: 571.7+ MB None
## Tipos de Dados[](http://localhost:8888/lab#Tipos-de-Dados)

O DataFrame contém uma variedade de tipos de dados, incluindo inteiros (int64), ponto flutuante (float64), objetos (object) e datas (datetime64[ns]).

## Uso de Memória[](http://localhost:8888/lab#Uso-de-Memória)

O DataFrame utiliza aproximadamente 571.7 MB de memória.

## Visualização Inicial[](http://localhost:8888/lab#Visualização-Inicial)

A visualização inicial apresenta as primeiras 5 entradas do DataFrame, exibindo valores para cada coluna.

```
       id  num_ano    cod_ne  ... dth_liquidacao dth_processamento num_ano_np
```

0 2021552683 2020 00028092 ... None 2022-10-27 2022.0 1 2021510082 2020 00028092 ... None 2022-10-27 2021.0 2 2021552684 2020 00028093 ... None 2022-10-27 2021.0 3 2020784292 2020 00028093 ... None 2022-10-27 2020.0 4 2021552685 2020 00028094 ... None 2022-10-27 2021.0

[5 rows x 37 columns]

## Valores Nulos[](http://localhost:8888/lab#Valores-Nulos)

O resumo dos valores nulos mostra a contagem de valores nulos para cada coluna do DataFrame. Essa análise é útil para identificar lacunas nos dados que podem requerer tratamento.

|Coluna|Número de Nulos|%|
|---|---|:-:|
|dsc_orgao|116|0,05|
|cod_fonte|2775|0,13|
|dsc_fonte|2775|0,13|
|cod_item|287982|14,25|
|dsc_item|287982|14,30|
|cod_item_elemento|1366|0,06|
|dsc_item_elemento|1366|0,06|
|cod_item_grupo|1134605|56|
|dsc_item_grupo|1134605|56|
|dsc_modalidade_licitacao|401656|20|
|num_sic|855132|42,00|
|cod_np|109765|5,42|
|vlr_liquidado|2025116|100|
|valor_pago|109765|5,42|
|dth_pagamento|109765|5,42|
|dth_liquidacao|2025116|100|
|num_ano_np|109765|5,42|
|dtype: int64|||

*As demais colunas não apresentam valores nulos

## Resumo Estatístico[](http://localhost:8888/lab#Resumo-Estatístico)

O resumo estatístico fornece estatísticas descritivas para colunas numéricas, incluindo contagem, média, mínimo, 25º percentil, mediana (50º percentil), 75º percentil e máximo. Isso oferece uma visão geral das tendências centrais e da dispersão dos dados numéricos.

```
             id       num_ano  ...              dth_processamento    num_ano_np
```

count 2.025116e+06 2.025116e+06 ... 2025116 1.915351e+06 mean 1.106000e+09 2.020271e+03 ... 2022-10-14 01:35:21.314926336 2.020324e+03 min 1.000000e+00 2.019000e+03 ... 2022-08-17 00:00:00 2.019000e+03 25% 5.062798e+05 2.019000e+03 ... 2022-08-17 00:00:00 2.019000e+03 50% 2.020498e+09 2.020000e+03 ... 2022-10-27 00:00:00 2.020000e+03 75% 2.021027e+09 2.021000e+03 ... 2022-10-27 00:00:00 2.021000e+03 max 2.021573e+09 2.022000e+03 ... 2022-12-08 00:00:00 2.022000e+03 std 1.005756e+09 1.050275e+00 ... NaN 1.029125e+00

# Limpeza dos Dados
```PYTHON
# Importando bibliotecas
import pandas as pd
from sqlalchemy import create_engine

server_name = 'DESKTOP-QNGLT5G'
database_name = 'Financeiro'

# Configuração da string de conexão SQLAlchemy com autenticação do Windows
conexao_sql = f'mssql+pyodbc://{server_name}/{database_name}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server'

# Carregando dados do SQL Server para um DataFrame Pandas
consulta_sql = "SELECT * FROM tb_execucao_financeira"
df = pd.read_sql(consulta_sql, conexao_sql)

# 1. Tratamento de Dados Nulos
df = df.drop(['dsc_modalidade_licitacao', 'cod_item_grupo', 'dth_liquidacao'], axis=1)
df['dsc_orgao'].fillna('Desconhecido', inplace=True)
df['cod_fonte'].fillna(df['cod_fonte'].mode()[0], inplace=True)

# 2. Remoção de Colunas Desnecessárias
df = df.drop(['vlr_liquidado'], axis=1)

# 3. Conversão de Tipos de Dados
df['vlr_empenho'] = pd.to_numeric(df['vlr_empenho'], errors='coerce')

# 4. Remoção de Duplicatas
df = df.drop_duplicates()

# 5. Tratamento de Datas
df['dth_empenho'] = pd.to_datetime(df['dth_empenho'])
df['dth_pagamento'] = pd.to_datetime(df['dth_pagamento'])
df['dth_processamento'] = pd.to_datetime(df['dth_processamento'])

# Verificando novamente as informações
print(df.info())

# Salvar o DataFrame limpo para uma nova tabela no banco de dados
df.to_sql('tb_transacao_financeira', conexao_sql, index=False, if_exists='replace')

```
No código acima é feito o tratamento de valores nulos, a remoção de duplicatas e colunas desnecessárias. Tudo através do PANDAS e com a criação de uma nova tabela com as limpezas feitas.