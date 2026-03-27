-- Посмотреть все активные подключения
SELECT 
    session_id,
    login_name,
    status,
    host_name,
    program_name,
    login_time,
    last_request_start_time,
    last_request_end_time
FROM sys.dm_exec_sessions
WHERE login_name = 'sa'  -- или ваш логин
ORDER BY login_time DESC;