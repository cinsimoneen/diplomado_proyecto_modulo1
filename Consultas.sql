-- 1.) Estructura de la base de datos

-- Tabla categorias
DESCRIBE categorias;
-- Tabla estados
DESCRIBE estados;
-- Tabla productos
DESCRIBE productos;
-- Tabla tipospago
DESCRIBE tipospago;
-- Tabla ventas
DESCRIBE ventas;

-- Seleccionar datos de la tabla venta
-- seleccionar todo con joins
-- seleccionar totales  vendidos por categorias
-- vercuales son los mas vendidos  

-- 2.) Seleccion de datos de las tablas
SELECT * FROM categorias;
SELECT * FROM estados;
SELECT * FROM productos;
SELECT * FROM tipospago;
SELECT * FROM ventas;

-- 3.) Selección de registros de ventas en general ordenados por orden descendente (de la última venta a la primera)
SELECT id_ventas,orden,fecha_venta,cantidad_ordenada,precio,descuento,vta.total 
FROM ventas
ORDER BY orden desc;

-- 4.) Selección de los datos con su respectivos catálogos usando las llaves foraneas
SELECT vta.id_ventas,vta.orden,vta.fecha_venta,vta.cantidad_ordenada,vta.precio,vta.descuento,vta.total,
est.desc_estados AS estado,tp.desc_tipospago AS tipospago, pr.desc_productos AS producto,cat.desc_categorias AS categoria
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias);

-- 5.) Filtrado de registros por categoría con orden ascendente
SELECT vta.id_ventas,vta.orden,vta.fecha_venta,vta.cantidad_ordenada,vta.precio,vta.descuento,vta.total,
est.desc_estados AS estado,tp.desc_tipospago AS tipospago, pr.desc_productos AS producto,cat.desc_categorias AS categoria
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE cat.desc_categorias='Beauty & Grooming'
ORDER BY categoria; 

-- 6.-) Filtrado de registros de octubre del 2016 ordenado por fecha descendente (de la última a la primera)
SELECT vta.id_ventas,vta.orden,vta.fecha_venta,vta.cantidad_ordenada,vta.precio,vta.descuento,vta.total,
est.desc_estados AS estado,tp.desc_tipospago AS tipospago, pr.desc_productos AS producto,cat.desc_categorias AS categoria
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE vta.fecha_venta BETWEEN '10/01/2016' AND '10/31/2016'
ORDER BY vta.fecha_venta desc; 

-- 7.-)  Filtrado de registros cancelados en el año 2016 ordenado por fecha descendente (de la última a la primera)
SELECT vta.id_ventas,vta.orden,vta.fecha_venta,vta.cantidad_ordenada,vta.precio,vta.descuento,vta.total,
est.desc_estados AS estado,tp.desc_tipospago AS tipospago, pr.desc_productos AS producto,cat.desc_categorias AS categoria
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE est.desc_estados='canceled'
AND vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016'
ORDER BY vta.fecha_venta; 

-- 8.) Total de registros cancelados en el año 2016 
SELECT COUNT(*)
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
WHERE est.desc_estados='canceled'
AND vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016';

-- 9.) Primeras 10 categorias con totales de ventas mayores en el año 2016 ordenado de la mas a la menos vendida
SELECT cat.desc_categorias, SUM(vta.total) AS total_vendido 
FROM ventas AS vta 
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
WHERE vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016'
AND est.desc_estados='complete'
GROUP BY cat.id_categorias
ORDER BY total_vendido desc
LIMIT 10;

-- 10.) Primeros 10 productos con más ventas en el año 2016 ordenado del mas al menos vendido
SELECT pr.desc_productos, count(vta.cantidad_ordenada) AS cantidad_vendida
FROM ventas AS vta 
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
WHERE vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016'
AND est.desc_estados='complete'
GROUP BY pr.id_productos
ORDER BY cantidad_vendida desc
LIMIT 10;

-- 11.)  Productos mas vendidos por categoria con y ordenado por totales de venta de mayor a menor
SELECT cat.desc_categorias, pr.desc_productos, count(vta.cantidad_ordenada) AS cantidad_vendida ,sum(vta.total) AS total_vendido
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE est.desc_estados='complete'
AND vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016'
GROUP BY cat.id_categorias,pr.id_productos
ORDER BY total_vendido desc;

-- 12.)  Productos mas vendidos por categoria con ventas mayores a los $300,000 y cantidad vendida mayor a 20
SELECT cat.desc_categorias, pr.desc_productos, count(vta.cantidad_ordenada) AS cantidad_vendida ,sum(vta.total) AS total_vendido
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE est.desc_estados='complete'
AND vta.fecha_venta BETWEEN '01/01/2016' AND '12/31/2016'
GROUP BY cat.id_categorias,pr.id_productos
HAVING total_vendido>300000 AND cantidad_vendida>20
ORDER BY total_vendido desc;

-- 13.) Seleccionar los productos con mayores promedios de ventas
SELECT desc_productos AS productos,
  (SELECT AVG(vta.total) 
   FROM ventas vta WHERE vta.id_productos=pr.id_productos) AS promedio_vtas
FROM productos pr
ORDER BY promedio_vtas desc
LIMIT 10;

-- 14.) Ventas por categorias 
SELECT categoria, cantidad,total
FROM(SELECT cat.desc_categorias AS categoria, COUNT(*) AS cantidad, SUM(total) AS total 
	 FROM ventas AS vta 
	  LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
      LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
      GROUP BY cat.id_categorias)AS totalesxcategoria
ORDER BY cantidad desc 
LIMIT 10;     

-- 15.-) Selecciona las ventas de los productos que contienen 'Apple'    
SELECT pr.desc_productos AS producto,cat.desc_categorias AS categoria,
 vta.cantidad_ordenada,vta.precio,vta.total
FROM ventas AS vta 
LEFT JOIN estados AS est ON (vta.id_estados=est.id_estados)
LEFT JOIN tipospago AS tp ON (vta.id_tipospago=tp.id_tipospago)
LEFT JOIN productos AS pr ON (vta.id_productos=pr.id_productos)
LEFT JOIN categorias AS cat ON (pr.id_categorias=cat.id_categorias)
WHERE  pr.desc_productos IN (SELECT desc_productos 
                             FROM productos
							 WHERE desc_productos like 'Apple%'
                             AND cat.desc_categorias <> 'Mobiles & Tablets')
                            
