CREATE DATABASE IF NOT EXISTS gestion_gastronomia;

USE gestion_gastronomia;

CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    estatus TINYINT DEFAULT 1,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS subcategorias (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    categoria_id INT NOT NULL,
    estatus TINYINT DEFAULT 1,
    umbral_stock INT DEFAULT 5,
    PRIMARY KEY(id),
    FOREIGN KEY(categoria_id) REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    categoria_id INT NOT NULL,
    subcategoria_id INT NOT NULL,
    estatus TINYINT DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY(categoria_id) REFERENCES categorias(id),
    FOREIGN KEY(subcategoria_id) REFERENCES subcategorias(id)
);

CREATE TABLE IF NOT EXISTS recetas (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    porciones INT DEFAULT 1,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS ingredientes_receta (
    id INT AUTO_INCREMENT,
    receta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(receta_id, producto_id),
    FOREIGN KEY(producto_id) REFERENCES productos(id),
    FOREIGN KEY(receta_id) REFERENCES recetas(id)
);

CREATE TABLE IF NOT EXISTS ingresos_materia_prima (
    id INT AUTO_INCREMENT,
    producto_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    proveedor VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS lotes (
    id INT AUTO_INCREMENT,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    numero_lote VARCHAR(255) NOT NULL,
    fecha_ingreso DATE DEFAULT CURRENT_DATE,
    estatus TINYINT DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY(producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS egresos_materia_prima (
    id INT AUTO_INCREMENT,
    producto_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    motivo ENUM('venta', 'desperdicio', 'vencimiento', 'rotura'),
    receta_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(producto_id) REFERENCES productos(id),
    FOREIGN KEY(receta_id) REFERENCES recetas(id)
);

CREATE TABLE IF NOT EXISTS tipos_utensilios (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS utensilios (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    fecha_compra DATE,
    tipo_id INT,
    estatus TINYINT DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY(tipo_id) REFERENCES tipos_utensilios(id)
);
