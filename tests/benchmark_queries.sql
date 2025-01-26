-- Script para testes de benchmark de queries
-- Este script mede o desempenho das consultas principais do sistema

-- Tabela para armazenar resultados dos testes
CREATE TABLE resultados_benchmark (
    id_teste NUMBER PRIMARY KEY,
    nome_teste VARCHAR2(100),
    descricao VARCHAR2(200),
    tempo_antes NUMBER,      -- Tempo em segundos antes da otimização
    tempo_depois NUMBER,     -- Tempo em segundos depois da otimização
    melhoria_percentual NUMBER,
    data_teste TIMESTAMP,
    observacoes VARCHAR2(500)
);

-- Sequence para IDs dos testes
CREATE SEQUENCE seq_teste START WITH 1;

-- Procedure principal de benchmark
CREATE OR REPLACE PROCEDURE executar_benchmark IS
    -- Variáveis para medição de tempo
    v_inicio TIMESTAMP;
    v_fim TIMESTAMP;
    v_tempo_antes NUMBER;
    v_tempo_depois NUMBER;
    v_id_teste NUMBER;
    
BEGIN
    -- Teste 1: Busca de clientes por nome
    v_id_teste := seq_teste.NEXTVAL;
    
    -- Mede tempo antes da otimização
    v_inicio := SYSTIMESTAMP;
    FOR i IN 1..100 LOOP
        FOR r IN (
            SELECT id_cliente, nome, email 
            FROM Clientes 
            WHERE nome LIKE '%Silva%'
        ) LOOP
            NULL;
        END LOOP;
    END LOOP;
    v_fim := SYSTIMESTAMP;
    v_tempo_antes := EXTRACT(SECOND FROM (v_fim - v_inicio));
    
    -- Cria índice para otimização
    BEGIN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_cliente_nome ON Clientes(nome)';
        EXECUTE IMMEDIATE 'ANALYZE INDEX idx_cliente_nome COMPUTE STATISTICS';
    EXCEPTION 
        WHEN OTHERS THEN NULL; -- Ignora se índice já existe
    END;
    
    -- Mede tempo depois da otimização
    v_inicio := SYSTIMESTAMP;
    FOR i IN 1..100 LOOP
        FOR r IN (
            SELECT /*+ INDEX(Clientes idx_cliente_nome) */ 
            id_cliente, nome, email 
            FROM Clientes 
            WHERE nome LIKE '%Silva%'
        ) LOOP
            NULL;
        END LOOP;
    END LOOP;
    v_fim := SYSTIMESTAMP;
    v_tempo_depois := EXTRACT(SECOND FROM (v_fim - v_inicio));
    
    -- Registra resultados
    INSERT INTO resultados_benchmark VALUES (
        v_id_teste,
        'Busca por Nome',
        'Teste de performance na busca de clientes por nome',
        v_tempo_antes,
        v_tempo_depois,
        ROUND(((v_tempo_antes - v_tempo_depois)/v_tempo_antes) * 100, 2),
        SYSTIMESTAMP,
        'Otimização através de índice idx_cliente_nome'
    );
    
    -- Teste 2: Análise de pedidos por cliente
    v_id_teste := seq_teste.NEXTVAL;
    
    -- Mede tempo antes da otimização
    v_inicio := SYSTIMESTAMP;
    FOR i IN 1..50 LOOP
        FOR r IN (
            SELECT c.nome, COUNT(p.id_pedido) total_pedidos, 
                   SUM(p.valor_total) valor_total
            FROM Clientes c
            LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
            GROUP BY c.nome
            HAVING COUNT(p.id_pedido) > 2
        ) LOOP
            NULL;
        END LOOP;
    END LOOP;
    v_fim := SYSTIMESTAMP;
    v_tempo_antes := EXTRACT(SECOND FROM (v_fim - v_inicio));
    
    -- Cria índices para otimização
    BEGIN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_pedido_cliente ON Pedidos(id_cliente)';
        EXECUTE IMMEDIATE 'ANALYZE INDEX idx_pedido_cliente COMPUTE STATISTICS';
    EXCEPTION 
        WHEN OTHERS THEN NULL;
    END;
    
    -- Mede tempo depois da otimização
    v_inicio := SYSTIMESTAMP;
    FOR i IN 1..50 LOOP
        FOR r IN (
            SELECT /*+ USE_NL(c p) INDEX(p idx_pedido_cliente) */
            c.nome, COUNT(p.id_pedido) total_pedidos, 
            SUM(p.valor_total) valor_total
            FROM Clientes c
            LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
            GROUP BY c.nome
            HAVING COUNT(p.id_pedido) > 2
        ) LOOP
            NULL;
        END LOOP;
    END LOOP;
    v_fim := SYSTIMESTAMP;
    v_tempo_depois := EXTRACT(SECOND FROM (v_fim - v_inicio));
    
    -- Registra resultados
    INSERT INTO resultados_benchmark VALUES (
        v_id_teste,
        'Análise de Pedidos',
        'Análise de pedidos por cliente com agregações',
        v_tempo_antes,
        v_tempo_depois,
        ROUND(((v_tempo_antes - v_tempo_depois)/v_tempo_antes) * 100, 2),
        SYSTIMESTAMP,
        'Otimização através de índice idx_pedido_cliente e hint de nested loop'
    );
    
    COMMIT;
    
    -- Exibe resultados
    FOR r IN (
        SELECT nome_teste, 
               ROUND(tempo_antes, 2) tempo_antes_seg,
               ROUND(tempo_depois, 2) tempo_depois_seg,
               melhoria_percentual
        FROM resultados_benchmark
        ORDER BY id_teste
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Teste: ' || r.nome_teste);
        DBMS_OUTPUT.PUT_LINE('Tempo antes: ' || r.tempo_antes_seg || ' seg');
        DBMS_OUTPUT.PUT_LINE('Tempo depois: ' || r.tempo_depois_seg || ' seg');
        DBMS_OUTPUT.PUT_LINE('Melhoria: ' || r.melhoria_percentual || '%');
        DBMS_OUTPUT.PUT_LINE('---');
    END LOOP;
END;
/

-- Executa os testes de benchmark
EXEC executar_benchmark;
