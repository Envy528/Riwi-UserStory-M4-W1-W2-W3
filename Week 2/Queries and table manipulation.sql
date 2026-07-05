/*
             TASK 3
*/

-- Consultas

-- Listar todos los estudiantes con sus inscripciones y cursos (JOIN).
SELECT
e.nombre_completo AS estudiante,
i.fecha_inscripcion AS fecha_inscripcion,
c.nombre AS curso
FROM estudiantes e
LEFT JOIN inscripciones i
ON e.id_estudiante = i.id_estudiante
LEFT JOIN cursos c
ON i.id_curso = c.id_curso;

-- Listar cursos dictados por docentes con > 5 años de experiencia.
SELECT
c.nombre AS curso,
d.nombre_completo AS docente
FROM cursos c
JOIN docentes d
ON c.id_docente = d.id_docente
WHERE d.anios_experiencia > 5;

-- Obtener promedio de calificaciones por curso (GROUP BY + AVG).
SELECT
c.nombre AS curso,
AVG(i.calificacion_final) AS promedio_calificacion
FROM cursos c
JOIN inscripciones i
ON i.id_curso = c.id_curso
GROUP BY c.id_curso, c.nombre;

--Mostrar estudiantes inscritos en más de un curso (HAVING COUNT(*) > 1).
SELECT
e.nombre_completo AS estudiante,
COUNT(*) AS cantidad_cursos
FROM estudiantes e
JOIN inscripciones i
ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING COUNT(*) > 1;


-- manipulación de tablas

-- ALTER TABLE: agregar columna estado_academico a estudiantes.
ALTER TABLE estudiantes
ADD COLUMN estado_academico VARCHAR(20) 
CHECK (estado_academico IN ('Activo', 'Suspendido')) DEFAULT 'Activo';

-- Eliminar un docente y observar el efecto en cursos (revisar ON DELETE en la FK).
SELECT * FROM cursos;
SELECT * FROM docentes;

DELETE FROM docentes
WHERE id_docente = 3;

SELECT * FROM cursos;

-- Consultar cursos con más de 2 estudiantes inscritos (GROUP BY + COUNT + HAVING).
SELECT
c.nombre AS curso,
COUNT(*) AS cantidad_estudiantes
FROM cursos c
JOIN inscripciones i
ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre
HAVING COUNT(*) > 2; -- No hay estudiantes con más de 2 cursos, si se modifica a >= 2 se mostraran varios
					 -- mostrando que la consulta funciona, solo que para > 2 no devuelve nada