DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_ListarAutores();

