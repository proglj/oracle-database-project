CREATE OR REPLACE PACKAGE pkg_encryption IS
    -- Chaves e procedimentos de criptografia
    FUNCTION encrypt_data(p_data IN VARCHAR2) RETURN RAW;
    FUNCTION decrypt_data(p_encrypted IN RAW) RETURN VARCHAR2;
    
    -- Gerenciamento de wallet
    PROCEDURE rotate_keys;
END;
/
