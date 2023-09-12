SELECT titulo FROM livros;

SELECT nome
FROM autores
WHERE nascimento < '1900-01-01';

SELECT titulo 
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

SELECT nome
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto;

SELECT autores.nome AS autor, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;

SELECT curso, COUNT(aluno_id) AS total_alunos
FROM matriculas
GROUP BY curso;

SELECT produto, AVG(receita) AS receita_media
FROM vendas
GROUP BY produto;

SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto
HAVING SUM(receita) > 10000.00;

SELECT autores.nome AS autor, COUNT(livros.id) AS quantidades_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
HAVING COUNT(livros.id) >= 2;

SELECT livros.titulo AS livro,
autores.nome AS autor
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id;

SELECT alunos.nome AS aluno,
matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

SELECT autores.nome AS autor, livros.titulo
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id;

SELECT matriculas.curso, alunos.nome AS aluno
FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id;

SELECT alunos.nome AS aluno, matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

SELECT autores.nome AS autor, COUNT(livros.id) AS quantidade_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY quantidade_de_livros DESC
LIMIT 1;

SELECT produto, SUM(receita) AS total_da_receita
FROM vendas
GROUP BY produto
ORDER BY total_da_receita ASC
LIMIT 1;

SELECT autores.nome AS autor, 
COUNT(livros.id) AS quantidade_de_livros,
COUNT(livros.id) * 20 AS total_da_receita
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;
