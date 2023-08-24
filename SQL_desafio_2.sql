-- criando banco de dados para bicicletaria

-- tabela cliente
CREATE TABLE Cliente (
  ID INT PRIMARY KEY,
  Nome VARCHAR(100),
  Endereco VARCHAR(200),
  Telefone CHAR(12)
);

-- tabela produto
CREATE TABLE produto (
  ID INT PRIMARY KEY,
  Modelo VARCHAR(100)
);

-- tabela serviço
CREATE TABLE Servico (
  ID INT PRIMARY KEY,
  Nome VARCHAR(100),
  Preco DECIMAL(10, 2)
);

-- tabela ordem de serviço
CREATE TABLE OrdemServico (
  ID INT PRIMARY KEY,
  Cliente_ID INT,
  produto_ID INT,
  Data DATE,
  Total DECIMAL(10, 2),
  FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID),
  FOREIGN KEY (produto_ID) REFERENCES produto(ID)
);


-- Inserção de dados

INSERT INTO Cliente (ID, Nome, Endereco, Telefone) VALUES
(1, 'Laura', 'Rua um, 234', '011999876543'),
(2, 'Maria', 'Rua dois, 345', '011999876521');

INSERT INTO produto (ID, Modelo) VALUES
(1, 'caiçara'),
(2, 'cano reto');

INSERT INTO Servico (ID, Nome, Preco) VALUES
(1, 'Troca de pneu', 20.00),
(2, 'Troca do freio', 15.00);

INSERT INTO OrdemServico (ID, Cliente_ID, produto_ID, Data, Total) VALUES
(1, 1, 1, '2023-08-24', 20.00),
(2, 2, 2, '2023-08-24', 15.00);


-- Consultas SQL

SELECT * FROM Cliente;

SELECT * FROM OrdemServico WHERE Cliente_ID = 1;

SELECT c.Nome, SUM(os.Total) AS TotalGasto
FROM Cliente c
JOIN OrdemServico os ON c.ID = os.Cliente_ID
GROUP BY c.Nome;

SELECT os.ID, s.Nome AS ServicoRealizado
FROM OrdemServico os
JOIN Servico s ON os.Servico_ID = s.ID;

SELECT c.Nome
FROM Cliente c
JOIN OrdemServico os ON c.ID = os.Cliente_ID
WHERE os.Total > 50.00;