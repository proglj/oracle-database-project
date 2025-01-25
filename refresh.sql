CREATE OR REPLACE PROCEDURE refresh_materializadas IS
BEGIN
    FOR r IN (SELECT mview_name FROM user_mviews) LOOP
        EXECUTE IMMEDIATE 'BEGIN DBMS_MVIEW.REFRESH(''' || r.mview_name || ''', ''C''); END;';
    END LOOP;
    
    INSERT INTO log_refresh (data_refresh, status) 
    VALUES (SYSDATE, 'CONCLUIDO');
    COMMIT;
END;
/
