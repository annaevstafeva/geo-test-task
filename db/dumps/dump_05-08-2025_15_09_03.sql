--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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

--
-- Name: geo_test_task_development; Type: DATABASE; Schema: -; Owner: geo_test_task
--

CREATE DATABASE geo_test_task_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE geo_test_task_development OWNER TO geo_test_task;

\connect geo_test_task_development

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: geo_test_task
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO geo_test_task;

--
-- Name: places; Type: TABLE; Schema: public; Owner: geo_test_task
--

CREATE TABLE public.places (
    id bigint NOT NULL,
    city_name character varying,
    country_name character varying,
    latitude double precision,
    longitude double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.places OWNER TO geo_test_task;

--
-- Name: places_id_seq; Type: SEQUENCE; Schema: public; Owner: geo_test_task
--

CREATE SEQUENCE public.places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.places_id_seq OWNER TO geo_test_task;

--
-- Name: places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geo_test_task
--

ALTER SEQUENCE public.places_id_seq OWNED BY public.places.id;


--
-- Name: saved_distances; Type: TABLE; Schema: public; Owner: geo_test_task
--

CREATE TABLE public.saved_distances (
    id bigint NOT NULL,
    distance double precision,
    flight_distance json,
    car_distance double precision,
    from_id bigint,
    to_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.saved_distances OWNER TO geo_test_task;

--
-- Name: saved_distances_id_seq; Type: SEQUENCE; Schema: public; Owner: geo_test_task
--

CREATE SEQUENCE public.saved_distances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.saved_distances_id_seq OWNER TO geo_test_task;

--
-- Name: saved_distances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geo_test_task
--

ALTER SEQUENCE public.saved_distances_id_seq OWNED BY public.saved_distances.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: geo_test_task
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO geo_test_task;

--
-- Name: places id; Type: DEFAULT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.places ALTER COLUMN id SET DEFAULT nextval('public.places_id_seq'::regclass);


--
-- Name: saved_distances id; Type: DEFAULT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.saved_distances ALTER COLUMN id SET DEFAULT nextval('public.saved_distances_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: geo_test_task
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-08-05 11:53:31.435593	2025-08-05 11:53:31.435595
schema_sha1	62ed236e48698cfc9ee90dd2d1bdc2179b4bf9dd	2025-08-05 11:53:31.439466	2025-08-05 11:53:31.439467
\.


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: geo_test_task
--

COPY public.places (id, city_name, country_name, latitude, longitude, created_at, updated_at) FROM stdin;
1	Москва	Россия	55.755864	37.617698	2025-08-05 11:53:40.510855	2025-08-05 11:53:40.510855
2	Санкт-Петербург	Россия	59.938784	30.314997	2025-08-05 11:53:41.458672	2025-08-05 11:53:41.458672
3	Рим	Италия	41.902695	12.496176	2025-08-05 11:53:55.136851	2025-08-05 11:53:55.136851
4	Минск	Беларусь	53.902284	27.561831	2025-08-05 12:07:09.050301	2025-08-05 12:07:09.050301
5	Ростов Великий	Россия	57.18587	39.414526	2025-08-05 12:07:09.982793	2025-08-05 12:07:09.982793
6	Ростов-на-Дону	Россия	47.222109	39.718813	2025-08-05 12:07:19.541444	2025-08-05 12:07:19.541444
7	Берлин	Германия	52.516259	13.377217	2025-08-05 12:07:20.475684	2025-08-05 12:07:20.475684
8	Балтийск	Россия	54.643775	19.894477	2025-08-05 12:07:31.305601	2025-08-05 12:07:31.305601
9	Анадырь	Россия	64.735814	177.518913	2025-08-05 12:07:32.246506	2025-08-05 12:07:32.246506
10	село Уэлен	Россия	66.160151	-169.81762	2025-08-05 12:07:42.60445	2025-08-05 12:07:42.60445
11	Афины	Греция	37.975534	23.734855	2025-08-05 12:07:43.554501	2025-08-05 12:07:43.554501
12	Сочи	Россия	43.585472	39.723098	2025-08-05 12:07:49.465683	2025-08-05 12:07:49.465683
13	Краснодар	Россия	45.03547	38.975313	2025-08-05 12:07:50.39409	2025-08-05 12:07:50.39409
14	Челябинск	Россия	55.159902	61.402554	2025-08-05 12:07:58.490714	2025-08-05 12:07:58.490714
15	Красноярск	Россия	56.010543	92.852581	2025-08-05 12:07:59.464693	2025-08-05 12:07:59.464693
\.


--
-- Data for Name: saved_distances; Type: TABLE DATA; Schema: public; Owner: geo_test_task
--

COPY public.saved_distances (id, distance, flight_distance, car_distance, from_id, to_id, created_at, updated_at) FROM stdin;
1	634.182596160885	{"km":635.1780169679187,"nm":342.9686916673427}	705.6841	1	2	2025-08-05 11:53:41.96932	2025-08-05 11:53:45.72471
3	2375.3754595379414	{"km":2379.1038780900335,"nm":1284.61332510261}	3070.3586	3	1	2025-08-05 11:54:02.799074	2025-08-05 11:54:02.799074
4	2345.802933551291	{"km":2349.4849347026816,"nm":1268.6203751094392}	2970.6321000000003	3	2	2025-08-05 11:57:06.53496	2025-08-05 11:57:06.53496
5	828.7688595383253	{"km":830.0697053388876,"nm":448.2017847402201}	932.6850999999999	4	5	2025-08-05 12:07:10.319266	2025-08-05 12:07:10.319266
6	1964.8316398935915	{"km":1967.9156638143156,"nm":1062.589451303626}	2327.5005	6	7	2025-08-05 12:07:20.685412	2025-08-05 12:07:20.685412
7	6603.894411134743	{"km":6614.259965068405,"nm":3571.4146679635014}	12498.7911	8	9	2025-08-05 12:07:32.445769	2025-08-05 12:07:32.445769
8	8377.374628375252	{"km":8390.523858681916,"nm":4530.52044205287}	4026.4362	10	11	2025-08-05 12:07:43.781304	2025-08-05 12:07:43.781304
9	171.85834424302303	{"km":172.12809521499415,"nm":92.94173607721066}	291.76570000000004	12	13	2025-08-05 12:07:50.586533	2025-08-05 12:07:50.586533
10	1961.6230314309328	{"km":1964.7020190803305,"nm":1060.8542219656213}	2234.3406	14	15	2025-08-05 12:07:59.648933	2025-08-05 12:07:59.648933
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: geo_test_task
--

COPY public.schema_migrations (version) FROM stdin;
20250805114436
20250805114427
\.


--
-- Name: places_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geo_test_task
--

SELECT pg_catalog.setval('public.places_id_seq', 15, true);


--
-- Name: saved_distances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geo_test_task
--

SELECT pg_catalog.setval('public.saved_distances_id_seq', 10, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (id);


--
-- Name: saved_distances saved_distances_pkey; Type: CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.saved_distances
    ADD CONSTRAINT saved_distances_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_saved_distances_on_from_id; Type: INDEX; Schema: public; Owner: geo_test_task
--

CREATE INDEX index_saved_distances_on_from_id ON public.saved_distances USING btree (from_id);


--
-- Name: index_saved_distances_on_to_id; Type: INDEX; Schema: public; Owner: geo_test_task
--

CREATE INDEX index_saved_distances_on_to_id ON public.saved_distances USING btree (to_id);


--
-- Name: saved_distances fk_rails_2376f08a3a; Type: FK CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.saved_distances
    ADD CONSTRAINT fk_rails_2376f08a3a FOREIGN KEY (from_id) REFERENCES public.places(id);


--
-- Name: saved_distances fk_rails_6a1fabcb81; Type: FK CONSTRAINT; Schema: public; Owner: geo_test_task
--

ALTER TABLE ONLY public.saved_distances
    ADD CONSTRAINT fk_rails_6a1fabcb81 FOREIGN KEY (to_id) REFERENCES public.places(id);


--
-- PostgreSQL database dump complete
--

