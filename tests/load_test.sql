-- Script para testes de carga no banco de dados
-- Este script simula múltiplos usuários acessando o sistema simultaneamente

-- Tabela para armazenar resultados dos testes de carga
CREATE TABLE resultados_carga (
    id_teste NUMBER PRIMARY KEY,
    tipo_teste VARCHAR2(50),
    usuarios_simulados NUMBER,
    tempo_total NUMBER,
    tempo_medio_resposta NUMBER,
    operacoes_sucesso NUMBER,
    operacoes_falha NUMBER,
    data_teste TIMESTAMP
);

-- Sequence para os testes
CREATE SEQUENCE seq_teste_carga START WITH 1;

-- Procedure principal de teste de carga
CREATE OR REPLACE PROCEDURE executar_teste_carga(
    p_num_usuarios IN NUMBER DEFAULT 100,  -- Número de usuários simultâneos
    p_duracao IN NUMBER DEFAULT 60        -- Duração do teste em segundos
) IS
    -- Variáveis para controle
    v_inicio TIMESTAMP;
    v_fim TIMESTAMP;
    v_tempo_total NUMBER;
    v_operacoes_ok NUMBER := 0;
    v_operacoes_falha NUMBER := 0;
    v_tempo_resposta NUMBER := 0;
    
    -- Array para simular múltiplos usuários
    TYPE t_usuarios IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_usuarios t_usuarios;
    
BEGIN
    -- Marca início do teste
    v_inicio := SYSTIMESTAMP;
    
    -- Loop principal - simula múltiplos usuários
    FOR i IN 1..p_num_usuarios LOOP
        -- Simula operações típicas de usuário
        BEGIN
            -- Operação 1: Consulta de cliente
            FOR r IN (
                SELECT * FROM Clientes 
                WHERE id_cliente = ROUND(DBMS_RANDOM.VALUE(1, 10000))
            ) LOOP
                v_operacoes_ok := v_operacoes_ok + 1;
            END LOOP;
            
            -- Operação 2: Análise de pedidos
            FOR r IN (
                SELECT c.nome, COUNT(p.id_pedido) total_pedidos
                FROM Clientes c
                JOIN Pedidos p ON c.id_cliente = p.id_cliente
                WHERE c.id_cliente = ROUND(DBMS_RANDOM.VALUE(1, 10000))
                GROUP BY c.nome
            ) LOOP
                v_operacoes_ok := v_operacoes_ok + 1;
            END LOOP;
            
            -- Operação 3: Inserção de pedido
            INSERT INTO Pedidos (
                id_pedido,
                id_cliente,
                valor_total,
                data_pedido
            ) VALUES (
                seq_pedido.NEXTVAL,
                ROUND(DBMS_RANDOM.VALUE(1, 10000)),
                ROUND(DBMS_RANDOM.VALUE(100, 1000), 2),
                SYSDATE
            );
            v_operacoes_ok := v_operacoes_ok + 1;
            
            -- Commit a cada 10 operações
            IF MOD(v_operacoes_ok, 10) = 0 THEN
                COMMIT;
            END IF;
            
        EXCEPTION
            WHEN OTHERS THEN
                v_operacoes_falha := v_operacoes_falha + 1;
                ROLLBACK;
        END;
    END LOOP;
    
    -- Marca fim do teste
    v_fim := SYSTIMESTAMP;
    v_tempo_total := EXTRACT(SECOND FROM (v_fim - v_inicio));
    
    -- Registra resultados
    INSERT INTO resultados_carga VALUES (
        seq_teste_carga.NEXTVAL,
        'SIMULACAO_USUARIOS',
        p_num_usuarios,
        v_tempo_total,
        v_tempo_total / NULLIF(v_operacoes_ok, 0),
        v_operacoes_ok,
        v_operacoes_falha,
        SYSTIMESTAMP
    );
    
    COMMIT;
    
    -- Exibe resultados
    DBMS_OUTPUT.PUT_LINE('Resultado do Teste de Carga:');
    DBMS_OUTPUT.PUT_LINE('Usuários simulados: ' || p_num_usuarios);
    DBMS_OUTPUT.PUT_LINE('Tempo total: ' || ROUND(v_tempo_total, 2) || ' segundos');
    DBMS_OUTPUT.PUT_LINE('Operações com sucesso: ' || v_operacoes_ok);
    DBMS_OUTPUT.PUT_LINE('Operações com falha: ' || v_operacoes_falha);
    DBMS_OUTPUT.PUT_LINE('Tempo médio por operação: ' || 
                        ROUND(v_tempo_total / NULLIF(v_operacoes_ok, 0), 4) || ' segundos');
END;
/

-- Executa teste com 100 usuários por 60 segundos
EXEC executar_teste_carga(100, 60);
