/*
          TASK 1
*/

-- Crear Base de datos
CREATE DATABASE gestion_academica_universidad
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Crear tablas

-- Tabla de estudiantes
CREATE TABLE estudiantes(
	id_estudiante INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nombre_completo VARCHAR(100) NOT NULL,
	correo_electronico VARCHAR(150) UNIQUE NOT NULL CHECK (correo_electronico LIKE '%@%.%'),
	genero VARCHAR(20) CHECK (genero IN ('Masculino', 'Femenino', 'Otro', 'Prefiero no decir')),
	identificacion VARCHAR(20) UNIQUE NOT NULL,
	carrera VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_ingreso DATE NOT NULL
);

-- Tabla de docentes
CREATE TABLE docentes(
	id_docente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nombre_completo VARCHAR(100) NOT NULL,
	correo_institucional VARCHAR(150) UNIQUE NOT NULL CHECK (correo_institucional LIKE '%@%.%'),
	departamento_academico VARCHAR(100) NOT NULL,
	anios_experiencia INT NOT NULL CHECK (anios_experiencia >= 0)
);

-- Tabla de cursos
CREATE TABLE cursos(
	id_curso INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	codigo VARCHAR(20) NOT NULL UNIQUE,
	creditos INT NOT NULL CHECK (creditos > 0),
	semestre INT NOT NULL CHECK (semestre > 0),
	id_docente INT,
	FOREIGN KEY (id_docente) REFERENCES docentes(id_docente) ON DELETE SET NULL
);

-- Tabla inscripciones
CREATE TABLE inscripciones(
	id_inscripcion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_estudiante INT NOT NULL,
	id_curso INT NOT NULL,
	fecha_inscripcion DATE NOT NULL,
	calificacion_final FLOAT CHECK (calificacion_final >= 0 AND calificacion_final <= 5),
	FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante) ON DELETE CASCADE,
	FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE CASCADE,
	UNIQUE (id_estudiante, id_curso)
);