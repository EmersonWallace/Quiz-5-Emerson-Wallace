USE MiAutoPuntoCom;

INSERT INTO Vehiculos (marca, modelo, anio, color, precio, vin, tipo, estado) VALUES
('Toyota', 'Corolla', 2024, 'Blanco', 24500.00, '1HGCM82633A004352', 'Sedan', 'Nuevo'),
('Toyota', 'RAV4', 2023, 'Gris', 32000.00, '2T3WFREV5LW123456', 'SUV', 'Usado'),
('Honda', 'Civic', 2022, 'Negro', 21000.00, '19XFC2F59NE000123', 'Sedan', 'Usado'),
('Honda', 'CR-V', 2025, 'Rojo', 35500.00, '7FARW2H50SE012345', 'SUV', 'Nuevo'),
('Ford', 'Ranger', 2024, 'Azul', 41000.00, '1FTER4EH5LLA12345', 'Camioneta', 'Nuevo'),
('Ford', 'Escape', 2021, 'Plata', 19500.00, '1FMCU9GD5MUA54321', 'SUV', 'Usado'),
('Nissan', 'Sentra', 2023, 'Blanco', 18900.00, '3N1AB8CV5PY123456', 'Sedan', 'Usado'),
('Hyundai', 'Tucson', 2025, 'Verde', 33800.00, 'KM8J33AL5SU123456', 'SUV', 'Nuevo'),
('Chevrolet', 'Silverado', 2022, 'Negro', 38700.00, '1GCUYDED5NZ123456', 'Camioneta', 'Usado'),
('Toyota', 'Hilux', 2025, 'Gris', 43500.00, 'MR0KB3CD500123456', 'Camioneta', 'Nuevo');

INSERT INTO Clientes (nombre, apellido, cedula, telefono, email, direccion) VALUES
('Carlos', 'Rodriguez', '1-1234-0567', '8888-1111', 'carlos.rodriguez@correo.com', 'Cartago, Centro, 200m sur de la basilica'),
('Maria', 'Fernandez', '2-0456-0789', '8888-2222', 'maria.fernandez@correo.com', 'San Jose, Escazu, Calle Los Laureles'),
('Jose', 'Vargas', '3-0321-0654', '8888-3333', 'jose.vargas@correo.com', 'Cartago, Paraiso, Barrio La Pastora'),
('Ana', 'Mora', '1-0987-0321', '8888-4444', 'ana.mora@correo.com', 'Heredia, Centro, Avenida 4'),
('Luis', 'Jimenez', '4-0123-0456', '8888-5555', 'luis.jimenez@correo.com', 'Alajuela, Grecia, Barrio San Jose'),
('Sofia', 'Castro', '1-1456-0987', '8888-6666', 'sofia.castro@correo.com', 'San Jose, Curridabat, Residencial Las Flores');

INSERT INTO Vendedores (nombre, apellido, cedula, fecha_nacimiento, fecha_contratacion, comision_porcentual) VALUES
('Andres', 'Solano', '1-0800-0100', '1990-03-15', '2018-02-01', 5.00),
('Laura', 'Quesada', '3-0450-0200', '1988-07-22', '2019-06-10', 7.50),
('Diego', 'Araya', '1-1100-0300', '1995-11-05', '2021-01-15', 4.00),
('Valeria', 'Campos', '2-0700-0400', '1998-09-30', '2023-08-20', 6.00);

INSERT INTO Ventas (id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_final, metodo_pago) VALUES
(1, 1, 1, '2026-08-12', 24000.00, 'Efectivo'),
(2, 2, 2, '2026-09-03', 31500.00, 'Financiamiento'),
(3, 3, 1, '2026-09-20', 20500.00, 'Tarjeta'),
(4, 4, 3, '2026-10-02', 35000.00, 'Financiamiento'),
(5, 5, 2, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 40200.00, 'Financiamiento'),
(6, 6, 4, DATE_SUB(CURDATE(), INTERVAL 12 DAY), 19000.00, 'Efectivo'),
(7, 1, 2, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 18500.00, 'Tarjeta'),
(8, 2, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 33000.00, 'Financiamiento');
