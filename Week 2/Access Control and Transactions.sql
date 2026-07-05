/* 
			TASK 6
*/

-- Otorga permisos de solo lectura a un rol revisor_academico sobre la vista (GRANT SELECT).

-- Creación del rol 
CREATE ROLE revisor_academico WITH LOGIN PASSWORD 'admin123';

-- Otorgamiento de permisos
GRANT SELECT ON vista_historial_academico TO revisor_academico;


-- RRevoca permisos de modificación de datos en inscripciones para ese rol (REVOKE).
REVOKE INSERT, UPDATE, DELETE ON inscripciones FROM revisor_academico;


-- Simula actualización de calificaciones usando BEGIN, SAVEPOINT, ROLLBACK y COMMIT.
BEGIN;
	UPDATE inscripciones
	SET calificacion_final = 3.9
	WHERE id_inscripcion = 4;

	SAVEPOINT primer_update; -- Punto de guardado

	UPDATE inscripciones
	SET calificacion_final = 0 -- Nota equivocada
	WHERE id_inscripcion = 8;

	ROLLBACK TO primer_update; -- Se deshacen cambios hasta el punto de guardado

	UPDATE inscripciones
	SET calificacion_final = 4.3 -- Se coloca la nota correcta
	WHERE id_inscripcion = 8;

COMMIT;

SELECT * FROM inscripciones