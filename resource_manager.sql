CREATE TABLE recursos_sistema (
    id NUMBER PRIMARY KEY,
    recurso VARCHAR2(50),
    limite NUMBER,
    uso_atual NUMBER,
    ultima_medicao TIMESTAMP
);

CREATE OR REPLACE PACKAGE pkg_recursos IS
    PROCEDURE monitorar_recursos;
    PROCEDURE ajustar_limites;
    PROCEDURE alertar_sobrecarga;
END pkg_recursos;
/
