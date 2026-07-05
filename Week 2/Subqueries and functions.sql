/*
           TASK 4
*/

-- Estudiantes cuya calificación promedio sea > promedio general (AVG() + subconsulta).
SELECT 
e.nombre_completo AS estudiante,
AVG(i.calificacion_final) AS promedio_calificacion
FROM estudiantes e
JOIN inscripciones i
ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING AVG(i.calificacion_final) > (
	SELECT AVG(calificacion_final)
	FROM inscripciones
);

-- Nombres de carreras con estudiantes inscritos en cursos del semestre ≥ 2 (IN o EXISTS).
SELECT carrera,
COUNT(*) AS cantidad_estudiantes -- Para mostrar cuantos estudiantes cumplen con la condición del semestre
FROM estudiantes
WHERE id_estudiante IN (
	SELECT id_estudiante
	FROM inscripciones
	WHERE id_curso IN (
		SELECT id_curso
		FROM cursos
		WHERE semestre >= 2
	)
)
GROUP BY carrera;

-- Usar ROUND, SUM, MAX, MIN, COUNT para obtener indicadores.
SELECT 
c.nombre AS curso,
COUNT(i.id_inscripcion) AS cantidad_estudiantes,
MAX(i.calificacion_final) AS calificacion_maxima,
MIN(i.calificacion_final) AS calificacion_minima,
SUM(i.calificacion_final) AS suma_calificaciones,
ROUND(AVG(i.calificacion_final)) AS promedio_calificacion
FROM cursos c
JOIN inscripciones i
ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre;
