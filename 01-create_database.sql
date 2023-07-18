CREATE DATABASE "dbsovdev"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;




\c petshop;


CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    document VARCHAR(11) NOT NULL UNIQUE,        
    address_street VARCHAR(255) NOT NULL,
    address_number VARCHAR(20) NOT NULL,
    address_complement VARCHAR(255),
    address_city VARCHAR(255) NOT NULL,
    address_state VARCHAR(255) NOT NULL,
    address_zipcode VARCHAR(20) NOT NULL,    
    date_of_birth DATE NOT NULL,    
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sales_id INT);


CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    sale_value DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    sale_status VARCHAR(50) NOT NULL,   
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

ALTER TABLE clients
ADD CONSTRAINT fk_sales
    FOREIGN KEY (sales_id)
    REFERENCES sales (id);

ALTER TABLE sales
ADD CONSTRAINT fk_clientes
    FOREIGN KEY (client_id)
    REFERENCES clients (id);

    

CREATE USER backend WITH PASSWORD 'B4cK';
GRANT ALL PRIVILEGES ON DATABASE dbsovdev TO backend; 
