ALTER TABLE Clientes ADD CONSTRAINT chk_email 
CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

ALTER TABLE Pedidos ADD CONSTRAINT fk_cliente 
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente);

ALTER TABLE Clientes ADD CONSTRAINT uq_email 
UNIQUE (email);
