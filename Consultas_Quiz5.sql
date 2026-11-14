USE MiAutoPuntoCom;

SELECT v.id_vehiculo, v.marca, v.modelo, v.anio, v.color, v.precio, v.tipo, v.estado
FROM Vehiculos v
LEFT JOIN Ventas s ON s.id_vehiculo = v.id_vehiculo
WHERE s.id_venta IS NULL
ORDER BY v.precio DESC;

SELECT d.id_vendedor, CONCAT(d.nombre, ' ', d.apellido) AS vendedor, COUNT(s.id_venta) AS cantidad_ventas
FROM Vendedores d
LEFT JOIN Ventas s ON s.id_vendedor = d.id_vendedor
GROUP BY d.id_vendedor, d.nombre, d.apellido
ORDER BY cantidad_ventas DESC;

SELECT d.id_vendedor, CONCAT(d.nombre, ' ', d.apellido) AS vendedor, COALESCE(SUM(s.precio_final), 0) AS ingreso_total
FROM Vendedores d
LEFT JOIN Ventas s ON s.id_vendedor = d.id_vendedor
GROUP BY d.id_vendedor, d.nombre, d.apellido
ORDER BY ingreso_total DESC;

SELECT c.id_cliente, CONCAT(c.nombre, ' ', c.apellido) AS cliente, c.cedula, c.telefono, c.email, s.precio_final AS compra_mas_costosa
FROM Ventas s
JOIN Clientes c ON c.id_cliente = s.id_cliente
WHERE s.precio_final = (SELECT MAX(precio_final) FROM Ventas);

SELECT s.id_venta, s.fecha_venta, v.marca, v.modelo, v.vin, s.precio_final,
       CONCAT(c.nombre, ' ', c.apellido) AS cliente, c.cedula, c.telefono, c.email
FROM Ventas s
JOIN Vehiculos v ON v.id_vehiculo = s.id_vehiculo
JOIN Clientes c ON c.id_cliente = s.id_cliente
WHERE s.fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
  AND s.fecha_venta <= CURDATE()
ORDER BY s.fecha_venta DESC;

SELECT d.id_vendedor, CONCAT(d.nombre, ' ', d.apellido) AS vendedor, d.comision_porcentual,
       COALESCE(SUM(s.precio_final), 0) AS total_vendido,
       COALESCE(SUM(s.precio_final * d.comision_porcentual / 100), 0) AS comision_ganada
FROM Vendedores d
LEFT JOIN Ventas s ON s.id_vendedor = d.id_vendedor
GROUP BY d.id_vendedor, d.nombre, d.apellido, d.comision_porcentual
ORDER BY comision_ganada DESC;

SELECT v.tipo, ROUND(AVG(s.precio_final), 2) AS promedio_precio_vendido, COUNT(*) AS cantidad_vendida
FROM Ventas s
JOIN Vehiculos v ON v.id_vehiculo = s.id_vehiculo
GROUP BY v.tipo
ORDER BY promedio_precio_vendido DESC;

SELECT v.marca, COUNT(*) AS veces_vendida
FROM Ventas s
JOIN Vehiculos v ON v.id_vehiculo = s.id_vehiculo
GROUP BY v.marca
HAVING COUNT(*) = (
    SELECT MAX(conteo)
    FROM (
        SELECT COUNT(*) AS conteo
        FROM Ventas s2
        JOIN Vehiculos v2 ON v2.id_vehiculo = s2.id_vehiculo
        GROUP BY v2.marca
    ) AS t
);
