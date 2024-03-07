--1. Crear una base de datos llamada películas.
CREATE DATABASE peliculas;

--2. Cargar ambos archivos a su tabla correspondiente y aplicar el truncado de estas.
/*
Cargo el archivo peliculas. Modifico el archivo reparto agregandole nombre a las columnas 
para luego agregar una nueva columna id la cual será serial y primary key de la tabla reparto.
 */
ALTER TABLE reparto
ADD COLUMN id serial PRIMARY KEY;

--Procedo a hacer primary key la columna id de la tabla peliculas
ALTER TABLE public.peliculas
ADD CONSTRAINT peliculas_pk PRIMARY KEY (id);

/*Procedo a crear una foreign key sobre la columna id_pelicula de la tabla reparto con referencia a la primary key de la tabla peliculas
 */
ALTER TABLE reparto
ADD CONSTRAINT reparto_fk FOREIGN KEY (id_pelicula) REFERENCES peliculas (id) ON DELETE CASCADE;

--3. Obtener el ID de la película “Titanic”.
SELECT
    id,
    "Pelicula"
FROM
    peliculas p
WHERE
    "Pelicula" = 'Titanic';

--4. Listar a todos los actores que aparecen en la película "Titanic".
SELECT
    r.nombre_actor
FROM
    peliculas p
    INNER JOIN reparto r ON p.id = r.id_pelicula
WHERE
    p."Pelicula" = 'Titanic';

--5. Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT
    COUNT(p."Pelicula")
FROM
    peliculas p
    INNER JOIN reparto r ON p.id = r.id_pelicula
WHERE
    LOWER(r.nombre_actor) = 'harrison ford';

/*
6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de
manera ascendente.
 */
SELECT
    p."Pelicula"
FROM
    peliculas p
WHERE
    "Año estreno" BETWEEN 1990 AND 1999
ORDER BY
    p."Pelicula" ASC;

/*
7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
nombrado para la consulta como “longitud_titulo”.
 */
SELECT
    p."Pelicula",
    LENGTH(p."Pelicula") AS longitud_titulo
FROM
    peliculas p;

--8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
SELECT
    p."Pelicula",
    LENGTH(p."Pelicula") AS longitud_titulo
FROM
    peliculas p
WHERE
    LENGTH(p."Pelicula") = (
        SELECT
            MAX(
                LENGTH(p."Pelicula")
            )
        FROM
            peliculas p
    );