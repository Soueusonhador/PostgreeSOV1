--  Criação da função para inserir cliente
CREATE OR REPLACE FUNCTION inserir_cliente(
    p_client_name VARCHAR(255),
    p_email VARCHAR(255),
    p_phone_number VARCHAR(20),
    p_document VARCHAR(11),
    p_address_street VARCHAR(255),
    p_address_number VARCHAR(20),
    p_address_complement VARCHAR(255),
    p_address_city VARCHAR(255),
    p_address_state VARCHAR(255),
    p_address_zipcode VARCHAR(20),
    p_date_of_birth DATE,
    p_sales_id INT
)
RETURNS VOID AS $$
BEGIN
   INSERT INTO clients (
        client_name,
        email,
        phone_number,
        document,
        address_street,
        address_number,
        address_complement,
        address_city,
        address_state,
        address_zipcode,
        date_of_birth,
        sales_id
    )
    VALUES (
        p_client_name,
        p_email,
        p_phone_number,
        p_document,
        p_address_street,
        p_address_number,
        p_address_complement,
        p_address_city,
        p_address_state,
        p_address_zipcode,
        p_date_of_birth,
        p_sales_id
    );
END;
$$ LANGUAGE plpgsql;


-- Inserir clientes pela funcao
SELECT inserir_cliente(
    'João3',
    'joao@email.com',
    '123456789',
    '12312312312',
    'Rua A',
    '123',
    NULL,
    'Cidade',
    'Estado',
    '12345678',
    '1990-01-01',
    NULL
);

-- criar funcao bloquear 
CREATE OR REPLACE FUNCTION bloquear_atualizacao_data_registro()
RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'UPDATE' AND NEW.registration_date <> OLD.registration_date THEN
        NEW.registration_date := OLD.registration_date;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- criar trigger que ocorre automatico ao rodar UPDATE
CREATE TRIGGER trigger_bloquear_atualizacao_data
BEFORE UPDATE ON clients
FOR EACH ROW
EXECUTE FUNCTION bloquear_atualizacao_data_registro();


-- teste da trigger
update clients SET 
client_name = 'regnier atual' where client_name like 'regnier';
