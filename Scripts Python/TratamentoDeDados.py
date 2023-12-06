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
