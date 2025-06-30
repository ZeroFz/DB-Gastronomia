BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "categorias" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "egresos_materia_prima" (
	"id"	INTEGER,
	"producto_id"	INTEGER NOT NULL,
	"cantidad"	REAL NOT NULL,
	"fecha"	DATE NOT NULL DEFAULT CURRENT_DATE,
	"motivo"	TEXT CHECK("motivo" IN ('venta', 'desperdicio', 'vencimiento', 'rotura')),
	"receta_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("producto_id") REFERENCES "productos"("id"),
	FOREIGN KEY("receta_id") REFERENCES "recetas"("id")
);
CREATE TABLE IF NOT EXISTS "ingredientes_receta" (
	"id"	INTEGER,
	"receta_id"	INTEGER NOT NULL,
	"producto_id"	INTEGER NOT NULL,
	"cantidad"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	UNIQUE("receta_id","producto_id"),
	FOREIGN KEY("producto_id") REFERENCES "productos"("id"),
	FOREIGN KEY("receta_id") REFERENCES "recetas"("id")
);
CREATE TABLE IF NOT EXISTS "ingresos_materia_prima" (
	"id"	INTEGER,
	"producto_id"	INTEGER NOT NULL,
	"cantidad"	REAL NOT NULL,
	"fecha"	DATE NOT NULL DEFAULT CURRENT_DATE,
	"proveedor"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("producto_id") REFERENCES "productos"("id")
);
CREATE TABLE IF NOT EXISTS "productos" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"cantidad"	REAL NOT NULL DEFAULT 0,
	"subcategoria_id"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("subcategoria_id") REFERENCES "subcategorias"("id")
);
CREATE TABLE IF NOT EXISTS "recetas" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL UNIQUE,
	"descripcion"	TEXT,
	"porciones"	INTEGER DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "subcategorias" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"categoria_id"	INTEGER NOT NULL,
	"minimo_stock"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("categoria_id") REFERENCES "categorias"("id")
);
CREATE TABLE IF NOT EXISTS "tipos_utensilios" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "utensilios" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"cantidad"	INTEGER NOT NULL DEFAULT 1,
	"fecha_compra"	DATE,
	"tipo_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("tipo_id") REFERENCES "tipos_utensilios"("id")
);
CREATE TABLE IF NOT EXISTS "vencimientos_productos" (
	"id"	INTEGER,
	"producto_id"	INTEGER NOT NULL,
	"fecha_vencimiento"	DATE NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("producto_id") REFERENCES "productos"("id")
);
COMMIT;
