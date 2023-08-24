-- criação do banco de dados para o cenário de E-commerce 
Create database if not exists ecommerce;
use ecommerce;

-- tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(255),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;

-- tabela produto

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(255) not null,
        classification_kids bool default false,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        size varchar(10)  -- size = dimensão do produto
);

alter table product auto_increment=1;

-- tabela pagamento
create table payments(
	idPayment int,
    idClient int,
    typePayment enum('Boleto', 'cartão', 'Dois cartões'),
    limitAvaliable float,
    primary key (idPayment, idClient)
);

-- tabela pedido

create table orders(
	idorders int auto_increment primary key,
    idClient int,
    status enum('Processando', 'cancelado', 'confirmado') default 'Processando',
    description varchar(255),
    freightage float default 10,
    paymentCash bool default false,
    idPayment int,
    constraint fk_orders_client foreign key(idClient) references clients(idClient)
    
);

alter table orders auto_increment=1;

-- tabela relacionamento pedido/pagemento

CREATE TABLE orders_payments (
  idorders INT NOT NULL,
  idPayment INT NOT NULL,
  idClient INT NOT NULL,
  PRIMARY KEY (idorders, idPayment, idClient),
  CONSTRAINT fk_orders_payments FOREIGN KEY(idorders) REFERENCES orders(idorders),
  CONSTRAINT fk_orders_payments_payment FOREIGN KEY(idPayment , idClient) REFERENCES payments (idPayment, idClient)
);

-- tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;


-- tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

-- tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;


-- tabela produto/vendedor

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- tabela produto/pedido

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idorders)

);

-- tabela localização/estoque

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- tabela relacionamento produto/fornecedor

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

-- inserindo dados

-- tabela clientes        
INSERT INTO clients (Fname, Minit, LName, CPF, Address) VALUES
    ('Aline', 'Q', 'Gobbi', '12345678909', 'Rua dois, 123'),
    ('Ana', 'C', 'Silva', '09876543212','Rua tres, 456'),
    ('Luana', 'G', 'Santos', '65432123456','Rua quatro, 789');
   
-- tabela produto
INSERT INTO product (Pname, classification_kids, category, avaliação, size) VALUES
    ('Celular XG', false, 'Eletrônico', 5.0, 'Grande'),
    ('Vestido', false, 'Vestimenta', 6.0, 'P'),
    ('Boneca', true, 'Brinquedos', 5.0, NULL);

-- Tabela pagamentos
INSERT INTO payments (idPayment, idClient, typePayment, limitAvaliable) VALUES
    (1, 1, 'Boleto', 1000.00),
    (2, 1, 'cartão', 2000.00),
    (3, 2, 'Dois cartões', 3000.00);

-- tabele pedido
INSERT INTO orders (idClient, status, description, freightage, paymentCash, idPayment) VALUES
    (1, 'confirmado', 'Pedido de celular', 10.50, false, 2),
    (1, 'Processando', 'Pedido de vestimenta', 11.00, true, 1),
    (2, 'cancelado', 'Pedido de brinquedo', 12.00, false, 3);

-- tabela relacionamento pedido/pagamento
INSERT INTO orders_payments (idorders, idPayment, idClient) VALUES
    (1, 2, 1),
    (2, 1, 1),
    (3, 3, 2);

-- tabela estoque
INSERT INTO productStorage (idProdStorage, storageLocation, quantity) VALUES
    (1, 'galpão A', 10),
    (2, 'galpão B', 20),
    (3, 'galpão C', 30);

-- tabela fornecedor
INSERT INTO Supplier (idSupplier, socialName, CNPJ, contact) VALUES
    (1, 'Fornecedor Eletrônicos', '123456789098765', '11234567898'),
    (2, 'Fornecedor Vestimentas', '098765432123456', '11323456789'),
    (3, 'Fornecedor Brinquedos', '456789098765432', '11987654345');  

-- tabela vendedor
INSERT INTO seller (idSeller, socialName, AbstName, CNPJ, CPF, location, contact) VALUES
    (1, 'vendedor A', 'vendedor jr', '789012345678901', '567890123', 'Av. A, 123', '11987654323'),
    (2, 'vendedor B', 'vendedor pl', '789012345678902', '567890125', 'Av. B, 456', '11987654389'),
    (3, 'vendedor C', 'vendedor sn', '789012345678903', '567890127', 'Av. C, 789', '11987654334');

-- tabela produto/vendedor
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
    (1, 1, 05),
    (1, 2, 05),
    (1, 3, 05);

-- tabela produto/pedido
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
    (1, 1, 2, 'Disponível'),
    (2, 1, 1, 'Disponível'),
    (3, 2, 3, 'Disponível');

-- tabela localização/estoque
INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
    (1, 1, 'galpão A'),
    (2, 2, 'galpão B'),
    (3, 3, 'galpão C');

-- tabela relacionamento produto/fornecedor
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
    (1, 1, 200),
    (1, 2, 200),
    (2, 3, 200);
    
-- realizando cláusulas 

SELECT * FROM clients;

SELECT * FROM orders WHERE idClient = 2;

SELECT count(*) FROM clients;
select distinct concat(Fname,' ',Minit,' ',LName) as Client from clients;

SELECT * FROM product ORDER BY avaliação DESC;

SELECT Supplier.socialName, COUNT(*) AS produtos_com_pouco_estoque
FROM Supplier
JOIN productStorage ON Supplier.idSupplier = productStorage.idSupplier
WHERE productStorage.quantity < 20
GROUP BY Supplier.socialName
HAVING produtos_com_pouco_estoque > 0;

SELECT product.Pname AS nome_produto, Supplier.socialName AS nome_fornecedor
FROM product
JOIN productStorage ON product.Pname = productStorage.Pname
JOIN Supplier ON productStorage.idSupplier = Supplier.idSupplier;