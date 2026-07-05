--
-- PostgreSQL database dump
--

\restrict TYSVEVYamO4K9l54GlXhNpA6d4SApCobcBOyvgrP7SGIQggNTC2cWrYyxJR1Mt6

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-05 12:16:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 17341)
-- Name: cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cursos (
    id_curso integer NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo character varying(20) NOT NULL,
    creditos integer NOT NULL,
    semestre integer NOT NULL,
    id_docente integer,
    CONSTRAINT cursos_creditos_check CHECK ((creditos > 0)),
    CONSTRAINT cursos_semestre_check CHECK ((semestre > 0))
);


ALTER TABLE public.cursos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17340)
-- Name: cursos_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cursos ALTER COLUMN id_curso ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cursos_id_curso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 17326)
-- Name: docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docentes (
    id_docente integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    correo_institucional character varying(150) NOT NULL,
    departamento_academico character varying(100) NOT NULL,
    anios_experiencia integer NOT NULL,
    CONSTRAINT docentes_anios_experiencia_check CHECK ((anios_experiencia >= 0)),
    CONSTRAINT docentes_correo_institucional_check CHECK (((correo_institucional)::text ~~ '%@%.%'::text))
);


ALTER TABLE public.docentes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17325)
-- Name: docentes_id_docente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.docentes ALTER COLUMN id_docente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.docentes_id_docente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 17307)
-- Name: estudiantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiantes (
    id_estudiante integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    correo_electronico character varying(150) NOT NULL,
    genero character varying(20),
    identificacion character varying(20) NOT NULL,
    carrera character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    fecha_ingreso date NOT NULL,
    estado_academico character varying(20) DEFAULT 'Activo'::character varying,
    CONSTRAINT estudiantes_correo_electronico_check CHECK (((correo_electronico)::text ~~ '%@%.%'::text)),
    CONSTRAINT estudiantes_estado_academico_check CHECK (((estado_academico)::text = ANY ((ARRAY['Activo'::character varying, 'Suspendido'::character varying])::text[]))),
    CONSTRAINT estudiantes_genero_check CHECK (((genero)::text = ANY ((ARRAY['Masculino'::character varying, 'Femenino'::character varying, 'Otro'::character varying, 'Prefiero no decir'::character varying])::text[])))
);


ALTER TABLE public.estudiantes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17306)
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.estudiantes ALTER COLUMN id_estudiante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.estudiantes_id_estudiante_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 17361)
-- Name: inscripciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripciones (
    id_inscripcion integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_curso integer NOT NULL,
    fecha_inscripcion date NOT NULL,
    calificacion_final double precision,
    CONSTRAINT inscripciones_calificacion_final_check CHECK (((calificacion_final >= (0)::double precision) AND (calificacion_final <= (5)::double precision)))
);


ALTER TABLE public.inscripciones OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17360)
-- Name: inscripciones_id_inscripcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inscripciones ALTER COLUMN id_inscripcion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inscripciones_id_inscripcion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 17385)
-- Name: vista_historial_academico; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_historial_academico AS
 SELECT e.nombre_completo AS nombre_estudiante,
    c.nombre AS nombre_curso,
    d.nombre_completo AS nombre_docente,
    c.semestre,
    i.calificacion_final
   FROM (((public.estudiantes e
     LEFT JOIN public.inscripciones i ON ((e.id_estudiante = i.id_estudiante)))
     LEFT JOIN public.cursos c ON ((i.id_curso = c.id_curso)))
     LEFT JOIN public.docentes d ON ((c.id_docente = d.id_docente)));


ALTER VIEW public.vista_historial_academico OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 17341)
-- Dependencies: 224
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cursos (id_curso, nombre, codigo, creditos, semestre, id_docente) FROM stdin;
1	Bases de Datos	SIS301	4	3	1
2	Programación Web	SIS405	3	4	1
3	Gestión Financiera	ADM210	3	2	2
4	Investigación de Operaciones	IND350	4	5	\N
\.


--
-- TOC entry 4955 (class 0 OID 17326)
-- Dependencies: 222
-- Data for Name: docentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.docentes (id_docente, nombre_completo, correo_institucional, departamento_academico, anios_experiencia) FROM stdin;
1	Carlos Alberto Méndez	carlos.mendez@universidad.edu.co	Ingeniería de Sistemas	8
2	Laura Patricia Ortiz	laura.ortiz@universidad.edu.co	Ciencias Administrativas	3
\.


--
-- TOC entry 4953 (class 0 OID 17307)
-- Dependencies: 220
-- Data for Name: estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiantes (id_estudiante, nombre_completo, correo_electronico, genero, identificacion, carrera, fecha_nacimiento, fecha_ingreso, estado_academico) FROM stdin;
1	Mariana López Torres	mariana.lopez@correo.edu.co	Femenino	1001234567	Ingeniería de Sistemas	2002-03-15	2021-01-20	Activo
2	Juan David Ramírez	juan.ramirez@correo.edu.co	Masculino	1002345678	Ingeniería Industrial	2001-07-22	2020-08-10	Activo
3	Camila Andrea Pérez	camila.perez@correo.edu.co	Femenino	1003456789	Ingeniería de Sistemas	2003-01-10	2022-01-18	Activo
4	Santiago Gómez Ruiz	santiago.gomez@correo.edu.co	Masculino	1004567890	Administración de Empresas	2000-11-05	2019-08-12	Activo
5	Valentina Torres Silva	valentina.torres@correo.edu.co	Femenino	1005678901	Contaduría Pública	2002-09-30	2021-08-15	Activo
\.


--
-- TOC entry 4959 (class 0 OID 17361)
-- Dependencies: 226
-- Data for Name: inscripciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscripciones (id_inscripcion, id_estudiante, id_curso, fecha_inscripcion, calificacion_final) FROM stdin;
1	1	1	2024-01-25	4.5
2	1	2	2024-01-25	3.8
3	2	3	2024-01-26	4
5	3	1	2024-01-27	4.7
6	4	3	2024-01-27	3.2
7	4	4	2024-01-28	4.1
4	2	4	2024-01-26	3.9
8	5	2	2024-01-28	4.3
\.


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 223
-- Name: cursos_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cursos_id_curso_seq', 4, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 221
-- Name: docentes_id_docente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.docentes_id_docente_seq', 3, true);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 219
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estudiantes_id_estudiante_seq', 5, true);


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 225
-- Name: inscripciones_id_inscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscripciones_id_inscripcion_seq', 8, true);


--
-- TOC entry 4794 (class 2606 OID 17354)
-- Name: cursos cursos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_codigo_key UNIQUE (codigo);


--
-- TOC entry 4796 (class 2606 OID 17352)
-- Name: cursos cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (id_curso);


--
-- TOC entry 4790 (class 2606 OID 17339)
-- Name: docentes docentes_correo_institucional_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT docentes_correo_institucional_key UNIQUE (correo_institucional);


--
-- TOC entry 4792 (class 2606 OID 17337)
-- Name: docentes docentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT docentes_pkey PRIMARY KEY (id_docente);


--
-- TOC entry 4784 (class 2606 OID 17322)
-- Name: estudiantes estudiantes_correo_electronico_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_correo_electronico_key UNIQUE (correo_electronico);


--
-- TOC entry 4786 (class 2606 OID 17324)
-- Name: estudiantes estudiantes_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_identificacion_key UNIQUE (identificacion);


--
-- TOC entry 4788 (class 2606 OID 17320)
-- Name: estudiantes estudiantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_pkey PRIMARY KEY (id_estudiante);


--
-- TOC entry 4798 (class 2606 OID 17372)
-- Name: inscripciones inscripciones_id_estudiante_id_curso_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_id_estudiante_id_curso_key UNIQUE (id_estudiante, id_curso);


--
-- TOC entry 4800 (class 2606 OID 17370)
-- Name: inscripciones inscripciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id_inscripcion);


--
-- TOC entry 4801 (class 2606 OID 17355)
-- Name: cursos cursos_id_docente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_id_docente_fkey FOREIGN KEY (id_docente) REFERENCES public.docentes(id_docente) ON DELETE SET NULL;


--
-- TOC entry 4802 (class 2606 OID 17378)
-- Name: inscripciones inscripciones_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.cursos(id_curso) ON DELETE CASCADE;


--
-- TOC entry 4803 (class 2606 OID 17373)
-- Name: inscripciones inscripciones_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES public.estudiantes(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE vista_historial_academico; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.vista_historial_academico TO revisor_academico;


-- Completed on 2026-07-05 12:16:24

--
-- PostgreSQL database dump complete
--

\unrestrict TYSVEVYamO4K9l54GlXhNpA6d4SApCobcBOyvgrP7SGIQggNTC2cWrYyxJR1Mt6

