-- Normalização do Banco de Dados - Financeiro

USE Financeiro;

SELECT * FROM tb_execucao_financeira;

-- 1. Modificar alguns campos da Tabela Bruta para que fique mais fácil a portabilidade:
ALTER TABLE tb_execucao_financeira
ALTER COLUMN id INT;

-- Convertendo em VARCHAR para depois transformar em INT
ALTER TABLE tb_execucao_financeira
ALTER COLUMN num_ano VARCHAR(5);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN num_ano INT;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN num_ano_np VARCHAR(5);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN num_ano_np INT;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_ne VARCHAR(15);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN num_sic VARCHAR(50);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_np VARCHAR(50);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN vlr_empenho MONEY;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN vlr_liquidado MONEY;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN valor_pago MONEY;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN vlr_resto_pagar MONEY;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN dth_empenho DATETIME;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN dth_pagamento DATETIME;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN dth_processamento DATETIME;

ALTER TABLE tb_execucao_financeira
ALTER COLUMN codigo_orgao VARCHAR(20);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN dsc_orgao VARCHAR(150);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_credor VARCHAR(20);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_fonte VARCHAR(20);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN dsc_fonte VARCHAR(150);


ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_funcao VARCHAR(20);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_item VARCHAR(20);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN dsc_item VARCHAR(150);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_item_elemento VARCHAR(20);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN dsc_item_elemento VARCHAR(150);


ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_item_categoria VARCHAR(20);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_item_modalidade VARCHAR(20);
ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_item_modalidade INT;
ALTER TABLE tb_execucao_financeira
ALTER COLUMN dsc_item_modalidade VARCHAR(150);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_programa VARCHAR(20);

ALTER TABLE tb_execucao_financeira
ALTER COLUMN cod_subfuncao VARCHAR(20);

-- 2. Criando as novas tabelas que irão comportar esses dados
CREATE TABLE tb_orgao (
	codigo_orgao VARCHAR(20) PRIMARY KEY,
	dsc_orgao VARCHAR(150)
);

DECLARE @codigo_orgao VARCHAR(20);
DECLARE @dsc_orgao VARCHAR(150);

DECLARE cursorOrgaos CURSOR FOR
SELECT codigo_orgao, dsc_orgao
FROM tb_execucao_financeira;

OPEN cursorOrgaos;

FETCH NEXT FROM cursorOrgaos INTO @codigo_orgao, @dsc_orgao;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_orgao WHERE codigo_orgao = @codigo_orgao)
    BEGIN
        INSERT INTO tb_orgao(codigo_orgao, dsc_orgao)
        VALUES (@codigo_orgao, @dsc_orgao);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @codigo_orgao;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @codigo_orgao + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorOrgaos INTO @codigo_orgao, @dsc_orgao;
END

CLOSE cursorOrgaos;
DEALLOCATE cursorOrgaos;

SELECT * FROM tb_orgao;

CREATE TABLE tb_credor(
	cod_credor VARCHAR(20),
	dsc_nome_credor VARCHAR(150)
);

DECLARE @cod_credor VARCHAR(20);
DECLARE @dsc_nome_credor VARCHAR(150);

DECLARE cursorCredor CURSOR FOR
SELECT cod_credor, dsc_nome_credor
FROM tb_execucao_financeira;

OPEN cursorCredor;

FETCH NEXT FROM cursorCredor INTO @cod_credor, @dsc_nome_credor;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_credor WHERE cod_credor = @cod_credor)
    BEGIN
        INSERT INTO tb_credor(cod_credor, dsc_nome_credor)
        VALUES (@cod_credor, @dsc_nome_credor);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_credor;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_credor + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorCredor INTO @cod_credor, @dsc_nome_credor;
END

CLOSE cursorCredor;
DEALLOCATE cursorCredor;

CREATE TABLE tb_fonte (
	cod_fonte VARCHAR(20) PRIMARY KEY,
	dsc_fonte VARCHAR(150)
);

DECLARE @cod_fonte VARCHAR(20);
DECLARE @dsc_fonte VARCHAR(150);

DECLARE cursorFonte CURSOR FOR
SELECT cod_fonte, dsc_fonte
FROM tb_execucao_financeira;

OPEN cursorFonte;

FETCH NEXT FROM cursorFonte INTO @cod_fonte, @dsc_fonte;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_fonte WHERE cod_fonte = @cod_fonte)
    BEGIN
        INSERT INTO tb_fonte(cod_fonte, dsc_fonte)
        VALUES (@cod_fonte, @dsc_fonte);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_fonte;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_fonte + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorFonte INTO @cod_fonte, @dsc_fonte;
END

CLOSE cursorFonte;
DEALLOCATE cursorFonte;

SELECT * FROM tb_fonte;


CREATE TABLE tb_funcao (
	cod_funcao VARCHAR(20) PRIMARY KEY,
	dsc_funcao VARCHAR(150)
);

DECLARE @cod_funcao VARCHAR(20);
DECLARE @dsc_funcao VARCHAR(150);

DECLARE cursorFuncao CURSOR FOR
SELECT cod_funcao, dsc_funcao
FROM tb_execucao_financeira;

OPEN cursorFuncao;

FETCH NEXT FROM cursorFuncao INTO @cod_funcao, @dsc_funcao;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_funcao WHERE cod_funcao = @cod_funcao)
    BEGIN
        INSERT INTO tb_funcao(cod_funcao, dsc_funcao)
        VALUES (@cod_funcao, @dsc_funcao);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_funcao;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_funcao + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorFuncao INTO @cod_funcao, @dsc_funcao;
END

CLOSE cursorFuncao;
DEALLOCATE cursorFuncao;

SELECT * FROM tb_funcao;

CREATE TABLE tb_item(
	cod_item VARCHAR(20) PRIMARY KEY,
	dsc_item VARCHAR(150)
);

DECLARE @cod_item VARCHAR(20);
DECLARE @dsc_item VARCHAR(150);

DECLARE cursorItem CURSOR FOR
SELECT cod_item, dsc_item
FROM tb_execucao_financeira;

OPEN cursorItem;

FETCH NEXT FROM cursorItem INTO @cod_item, @dsc_item;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_item WHERE cod_item = @cod_item)
    BEGIN
        INSERT INTO tb_item(cod_item, dsc_item)
        VALUES (@cod_item, @dsc_item);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_item;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_item + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorItem INTO @cod_item, @dsc_item;
END

CLOSE cursorItem;
DEALLOCATE cursorItem;

CREATE TABLE tb_item_elemento(
	cod_item_elemento VARCHAR(20) PRIMARY KEY,
	dsc_item_elemento VARCHAR(150)
);

DECLARE @cod_item_elemento VARCHAR(20);
DECLARE @dsc_item_elemento VARCHAR(150);

DECLARE cursorItemElem CURSOR FOR
SELECT cod_item_elemento, dsc_item_elemento
FROM tb_execucao_financeira;

OPEN cursorItemElem;

FETCH NEXT FROM cursorItemElem INTO @cod_item_elemento, @dsc_item_elemento;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_item_elemento WHERE cod_item_elemento = @cod_item_elemento)
    BEGIN
        INSERT INTO tb_item_elemento(cod_item_elemento, dsc_item_elemento)
        VALUES (@cod_item_elemento, @dsc_item_elemento);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_item_elemento;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_item_elemento + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorItemElem INTO @cod_item_elemento, @dsc_item_elemento;
END

CLOSE cursorItemElem;
DEALLOCATE cursorItemElem;

CREATE TABLE tb_item_categoria(
	cod_item_categoria VARCHAR(20) PRIMARY KEY,
	dsc_item_categoria VARCHAR(150)
);

CREATE TABLE tb_item_modalidade(
	cod_item_modalidade INT PRIMARY KEY IDENTITY(1,1),
	dsc_item_modalidade VARCHAR(150)
);

ALTER TABLE tb_item_modalidade
ALTER COLUMN cod_item_modalidade 

SET IDENTITY_INSERT tb_item_modalidade ON;

SELECT * FROM tb_item_modalidade;

DECLARE @cod_item_modalidade INT;
DECLARE @dsc_item_modalidade VARCHAR(150);

DECLARE cursorItemMod CURSOR FOR
SELECT cod_item_modalidade, dsc_item_modalidade
FROM tb_execucao_financeira;

OPEN cursorItemMod;

FETCH NEXT FROM cursorItemMod INTO @cod_item_modalidade, @dsc_item_modalidade;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_item_modalidade WHERE cod_item_modalidade = @cod_item_modalidade)
    BEGIN
        INSERT INTO tb_item_modalidade(cod_item_modalidade, dsc_item_modalidade)
        VALUES (@cod_item_modalidade, @dsc_item_modalidade);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + CAST(@cod_item_modalidade as VARCHAR(20));
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + CAST(@cod_item_modalidade AS VARCHAR(20)) + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorItemMod INTO @cod_item_modalidade, @dsc_item_modalidade;
END

CLOSE cursorItemMod;
DEALLOCATE cursorItemMod;


CREATE TABLE tb_programa(
	cod_programa VARCHAR(20) PRIMARY KEY,
	dsc_programa VARCHAR(150)
)

DECLARE @cod_programa VARCHAR(20);
DECLARE @dsc_programa VARCHAR(150);

DECLARE cursorPrograma CURSOR FOR
SELECT cod_programa, dsc_programa
FROM tb_execucao_financeira;

OPEN cursorPrograma;

FETCH NEXT FROM cursorPrograma INTO @cod_programa, @dsc_programa;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_programa WHERE cod_programa = @cod_programa)
    BEGIN
        INSERT INTO tb_programa(cod_programa, dsc_programa)
        VALUES (@cod_programa, @dsc_programa);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_programa;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_programa + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorPrograma INTO @cod_programa, @dsc_programa;
END

CLOSE cursorPrograma;
DEALLOCATE cursorPrograma;

CREATE TABLE tb_subfuncao(
	cod_subfuncao VARCHAR(20) PRIMARY KEY,
	dsc_subfuncao VARCHAR(150)
);

DECLARE @cod_subfuncao VARCHAR(20);
DECLARE @dsc_subfuncao VARCHAR(150);

DECLARE cursorSubfuncao CURSOR FOR
SELECT cod_subfuncao, dsc_subfuncao
FROM tb_execucao_financeira;

OPEN cursorSubfuncao;

FETCH NEXT FROM cursorSubfuncao INTO @cod_subfuncao, @dsc_subfuncao;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM tb_subfuncao WHERE cod_subfuncao = @cod_subfuncao)
    BEGIN
        INSERT INTO tb_subfuncao(cod_subfuncao, dsc_subfuncao)
        VALUES (@cod_subfuncao, @dsc_subfuncao);

        COMMIT;
        PRINT 'Inserção bem-sucedida para ' + @cod_subfuncao;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'A linha já existe na tabela para ' + @cod_subfuncao + '. Nenhuma alteração feita.';
    END

    FETCH NEXT FROM cursorSubfuncao INTO @cod_subfuncao, @dsc_subfuncao;
END

CLOSE cursorSubfuncao;
DEALLOCATE cursorSubfuncao;

CREATE TABLE tb_transacao_financeira (
	id INT PRIMARY KEY IDENTITY(1,1),
	num_ano INT,
	cod_ne VARCHAR(50),
	num_sic VARCHAR(50) NULL,
	cod_np VARCHAR(50) NULL,
	vlr_empenho MONEY,
	vlr_liquidado MONEY NULL,
	valor_pago MONEY NULL,
	vlr_resto_pagar MONEY NULL,
	dth_empenho DATETIME,
	dth_pagamento DATETIME NULL,
	dth_processamento DATETIME,
	num_ano_np INT NULL,
	codigo_orgao VARCHAR(20),
	cod_credor VARCHAR(20),
	cod_fonte VARCHAR(20),
	cod_funcao VARCHAR(20),
	cod_item VARCHAR(20),
	cod_item_elemento VARCHAR(20),
	cod_item_categoria VARCHAR(20),
	cod_item_modalidade INT,
	cod_programa VARCHAR(20),
	cod_subfuncao VARCHAR(20)
);

SET IDENTITY_INSERT tb_item_modalidade OFF;
SET IDENTITY_INSERT tb_transacao_financeira ON;

INSERT INTO tb_transacao_financeira (
	id,
	num_ano,
	cod_ne,
	num_sic,
	cod_np,
	vlr_empenho,
	vlr_liquidado,
	valor_pago,
	vlr_resto_pagar,
	dth_empenho,
	dth_pagamento,
	dth_processamento,
	num_ano_np,
	codigo_orgao,
	cod_credor,
	cod_fonte,
	cod_funcao,
	cod_item,
	cod_item_elemento,
	cod_item_categoria,
	cod_item_modalidade,
	cod_programa,
	cod_subfuncao
) SELECT 
	id,
	num_ano,
	cod_ne,
	num_sic,
	cod_np,
	vlr_empenho,
	vlr_liquidado,
	valor_pago,
	vlr_resto_pagar,
	dth_empenho,
	dth_pagamento,
	dth_processamento,
	num_ano_np,
	codigo_orgao,
	cod_credor,
	cod_fonte,
	cod_funcao,
	cod_item,
	cod_item_elemento,
	cod_item_categoria,
	cod_item_modalidade,
	cod_programa,
	cod_subfuncao
	FROM tb_execucao_financeira;
