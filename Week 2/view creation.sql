/*
            TASK 5
*/

-- Creación de vista
CREATE VIEW vista_historial_academico AS
SELECT
e.nombre_completo AS nombre_estudiante,
c.nombre AS nombre_curso,
d.nombre_completo AS nombre_docente,
c.semestre AS semestre,
i.calificacion_final AS calificacion_final
FROM estudiantes e
LEFT JOIN inscripciones i
ON e.id_estudiante = i.id_estudiante
LEFT JOIN cursos c
ON i.id_curso = c.id_curso
LEFT JOIN docentes d
ON c.id_docente = d.id_docente;

-- Mostrar la vista
SELECT * FROM vista_historial_academico;