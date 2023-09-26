DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_ListarAutores();

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_LivrosPorCategoria('Romance');

DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM Livro
    JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_ContarLivrosPorCategoria('Ciência', @total);
SELECT @total;

DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros BOOLEAN)
BEGIN
    DECLARE total INT;
    CALL sp_ContarLivrosPorCategoria(categoriaNome, total);
    SET possuiLivros = (total > 0);
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_VerificarLivrosCategoria('Ficção Científica', @possuiLivros);
SELECT @possuiLivros;

DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
    SELECT Titulo
    FROM Livro
    WHERE Ano_Publicacao <= ano;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_LivrosAteAno(2010);

DELIMITER //
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE titulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Livro.Titulo
        FROM Livro
        JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoriaNome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO titulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT titulo;
    END LOOP;
    
    CLOSE cur;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_TitulosPorCategoria('História');

DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(IN titulo VARCHAR(255), IN editoraID INT, IN ano INT, IN paginas INT, IN categoriaID INT, OUT mensagem VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR 1062  -- Código de erro para chave duplicada (índice único)
    BEGIN
        SET mensagem = 'Erro: Título de livro já existe.';
    END;

    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (titulo, editoraID, ano, paginas, categoriaID);
    
    SET mensagem = 'Livro adicionado com sucesso.';
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_AdicionarLivro('O Universo Desconhecido', 1, 2019, 320, 3, @mensagem);
SELECT @mensagem;

DELIMITER //
CREATE PROCEDURE sp_AutorMaisAntigo(OUT nomeAutorMaisAntigo VARCHAR(255))
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome)
    INTO nomeAutorMaisAntigo
    FROM Autor
    ORDER BY Data_Nascimento
    LIMIT 1;
END//
DELIMITER ;

-- Para testar a stored procedure:
CALL sp_AutorMaisAntigo(@nomeAutorMaisAntigo);
SELECT @nomeAutorMaisAntigo;
