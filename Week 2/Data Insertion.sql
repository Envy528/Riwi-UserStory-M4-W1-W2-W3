/*
                 TASK 2
*/

-- Inserción de datos

-- Estudiantes
INSERT INTO estudiantes (nombre_completo, correo_electronico, genero, identificacion, carrera, fecha_nacimiento, fecha_ingreso) 
VALUES
    ('Mariana López Torres', 'mariana.lopez@correo.edu.co', 'Femenino', '1001234567', 'Ingeniería de Sistemas', '2002-03-15', '2021-01-20'),
    ('Juan David Ramírez', 'juan.ramirez@correo.edu.co', 'Masculino', '1002345678', 'Ingeniería Industrial', '2001-07-22', '2020-08-10'),
    ('Camila Andrea Pérez', 'camila.perez@correo.edu.co', 'Femenino', '1003456789', 'Ingeniería de Sistemas', '2003-01-10', '2022-01-18'),
    ('Santiago Gómez Ruiz', 'santiago.gomez@correo.edu.co', 'Masculino', '1004567890', 'Administración de Empresas', '2000-11-05', '2019-08-12'),
    ('Valentina Torres Silva', 'valentina.torres@correo.edu.co', 'Femenino', '1005678901', 'Contaduría Pública', '2002-09-30', '2021-08-15');

-- Docentes
INSERT INTO docentes (nombre_completo, correo_institucional, departamento_academico, anios_experiencia) 
VALUES
    ('Carlos Alberto Méndez', 'carlos.mendez@universidad.edu.co', 'Ingeniería de Sistemas', 8),
    ('Laura Patricia Ortiz', 'laura.ortiz@universidad.edu.co', 'Ciencias Administrativas', 3),
    ('Ricardo Andrés Fajardo', 'ricardo.fajardo@universidad.edu.co', 'Ingeniería Industrial', 12);

-- Cursos
INSERT INTO cursos (nombre, codigo, creditos, semestre, id_docente) 
VALUES
    ('Bases de Datos', 'SIS301', 4, 3, 1),
    ('Programación Web', 'SIS405', 3, 4, 1),
    ('Gestión Financiera', 'ADM210', 3, 2, 2),
    ('Investigación de Operaciones', 'IND350', 4, 5, 3);

-- Inscripciones
INSERT INTO inscripciones (id_estudiante, id_curso, fecha_inscripcion, calificacion_final) 
VALUES
	(1, 1, '2024-01-25', 4.5),
	(1, 2, '2024-01-25', 3.8),
    (2, 3, '2024-01-26', 4.0),
    (2, 4, '2024-01-26', NULL),
    (3, 1, '2024-01-27', 4.7),
    (4, 3, '2024-01-27', 3.2),
    (4, 4, '2024-01-28', 4.1),
    (5, 2, '2024-01-28', NULL);