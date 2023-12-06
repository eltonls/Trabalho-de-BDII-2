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