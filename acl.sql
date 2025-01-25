CREATE OR REPLACE PACKAGE pkg_acl IS
    PROCEDURE criar_acl(
        p_nome IN VARCHAR2,
        p_descricao IN VARCHAR2
    );
    
    PROCEDURE adicionar_privilegio(
        p_acl IN VARCHAR2,
        p_usuario IN VARCHAR2,
        p_privilegio IN VARCHAR2
    );
END;
/
