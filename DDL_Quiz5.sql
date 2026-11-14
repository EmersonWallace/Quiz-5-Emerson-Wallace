DROP DATABASE IF EXISTS MiAutoPuntoCom;
CREATE DATABASE MiAutoPuntoCom CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MiAutoPuntoCom;

CREATE TABLE Vehiculos (
    id_vehiculo INT AUTO_INCREMENT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio SMALLINT NOT NULL,
    color VARCHAR(30) NOT NULL,
    precio DECIMAL(12,2) NOT NULL,
    vin VARCHAR(17) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    estado VARCHAR(10) NOT NULL,
    CONSTRAINT pk_vehiculos PRIMARY KEY (id_vehiculo),
    CONSTRAINT uq_vehiculos_vin UNIQUE (vin),
    CONSTRAINT chk_vehiculos_anio CHECK (anio >= 1900),
    CONSTRAINT chk_vehiculos_precio CHECK (precio > 0),
    CONSTRAINT chk_vehiculos_estado CHECK (estado IN ('Nuevo', 'Usado'))
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT uq_clientes_cedula UNIQUE (cedula),
    CONSTRAINT uq_clientes_email UNIQUE (email)
);

CREATE TABLE Vendedores (
    id_vendedor INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_contratacion DATE NOT NULL,
    comision_porcentual DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_vendedores PRIMARY KEY (id_vendedor),
    CONSTRAINT uq_vendedores_cedula UNIQUE (cedula),
    CONSTRAINT chk_vendedores_comision CHECK (comision_porcentual BETWEEN 0 AND 20),
    CONSTRAINT chk_vendedores_edad CHECK (fecha_contratacion >= DATE_ADD(fecha_nacimiento, INTERVAL 21 YEAR))
);

CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_venta DATE NOT NULL,
    precio_final DECIMAL(12,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,
    CONSTRAINT pk_ventas PRIMARY KEY (id_venta),
    CONSTRAINT uq_ventas_vehiculo UNIQUE (id_vehiculo),
    CONSTRAINT chk_ventas_precio CHECK (precio_final > 0),
    CONSTRAINT chk_ventas_metodo CHECK (metodo_pago IN ('Efectivo', 'Financiamiento', 'Tarjeta')),
    CONSTRAINT fk_ventas_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos (id_vehiculo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedores (id_vendedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

DELIMITER $$

CREATE TRIGGER trg_vehiculos_anio_insert
BEFORE INSERT ON Vehiculos
FOR EACH ROW
BEGIN
    IF NEW.anio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El anio del vehiculo no puede ser mayor al anio actual';
    END IF;
END$$

CREATE TRIGGER trg_vehiculos_anio_update
BEFORE UPDATE ON Vehiculos
FOR EACH ROW
BEGIN
    IF NEW.anio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El anio del vehiculo no puede ser mayor al anio actual';
    END IF;
END$$

CREATE TRIGGER trg_vendedores_edad_insert
BEFORE INSERT ON Vendedores
FOR EACH ROW
BEGIN
    IF NEW.fecha_nacimiento > DATE_SUB(CURDATE(), INTERVAL 21 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los vendedores no pueden ser menores de 21 anios';
    END IF;
END$$

CREATE TRIGGER trg_vendedores_edad_update
BEFORE UPDATE ON Vendedores
FOR EACH ROW
BEGIN
    IF NEW.fecha_nacimiento > DATE_SUB(CURDATE(), INTERVAL 21 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los vendedores no pueden ser menores de 21 anios';
    END IF;
END$$

DELIMITER ;
