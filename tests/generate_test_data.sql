-- Script para geração de dados de teste
-- Este script cria dados simulados para testar a performance do banco

-- Primeira parte: Procedure principal para geração de dados
CREATE OR REPLACE PROCEDURE gerar_dados_teste IS
    -- Variáveis para controle
    v_email VARCHAR2(100);
    v_nome VARCHAR2(100);
BEGIN
    -- Limpa dados existentes para evitar duplicações
    EXECUTE IMMEDIATE 'TRUNCATE TABLE Clientes';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE Pedidos';
    
    -- Gera 10.000 clientes com dados realistas
    FOR i IN 1..10000 LOOP
        -- Gera nome simulado
        v_nome := 'Cliente ' || 
                  CASE MOD(i, 5) 
                    WHEN 0 THEN 'Silva'
                    WHEN 1 THEN 'Santos'
                    WHEN 2 THEN 'Oliveira'
                    WHEN 3 THEN 'Souza'
                    ELSE 'Pereira'
                  END || ' ' || i;
                  
        -- Gera email baseado no nome
        v_email := 'cliente.' || i || '@email.com';
        
        -- Insere cliente
        INSERT INTO Clientes (
            id_cliente,
            nome,
            email,
            data_cadastro
        ) VALUES (
            i,
            v_nome,
            v_email,
            SYSDATE - ROUND(DBMS_RANDOM.VALUE(0, 365)) -- Data aleatória último ano
        );
        
        -- Gera entre 1 e 5 pedidos para cada cliente
        FOR j IN 1..ROUND(DBMS_RANDOM.VALUE(1, 5)) LOOP
            INSERT INTO Pedidos (
                id_pedido,
                id_cliente,
                valor_total,
                data_pedido
            ) VALUES (
                (i * 10) + j,  -- Gera ID único para pedido
                i,
                ROUND(DBMS_RANDOM.VALUE(100, 1000), 2),  -- Valor entre 100 e 1000
                SYSDATE - ROUND(DBMS_RANDOM.VALUE(0, 180))  -- Data últimos 6 meses
            );
        END LOOP;
        
        -- Commit a cada 1000 registros para não sobrecarregar
        IF MOD(i, 1000) = 0 THEN
            COMMIT;
        END LOOP;
    END LOOP;
    
    -- Commit final
    COMMIT;
    
    -- Atualiza estatísticas para otimização
    DBMS_STATS.GATHER_TABLE_STATS('', 'CLIENTES');
    DBMS_STATS.GATHER_TABLE_STATS('', 'PEDIDOS');
    
    -- Log de conclusão
    DBMS_OUTPUT.PUT_LINE('Geração de dados concluída:');
    DBMS_OUTPUT.PUT_LINE('- Clientes gerados: 10.000');
    DBMS_OUTPUT.PUT_LINE('- Pedidos gerados: ~30.000');
END;
/

-- Executa a geração dos dados
EXEC gerar_dados_teste;
