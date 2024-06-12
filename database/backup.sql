--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: petsitters; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA petsitters;


ALTER SCHEMA petsitters OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE petsitters.alembic_version OWNER TO postgres;

--
-- Name: gameanswer; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters.gameanswer (
    answerid integer NOT NULL,
    questionid integer NOT NULL,
    answertext character varying,
    is_correct boolean
);


ALTER TABLE petsitters.gameanswer OWNER TO postgres;

--
-- Name: gameanswer_answerid_seq; Type: SEQUENCE; Schema: petsitters; Owner: postgres
--

CREATE SEQUENCE petsitters.gameanswer_answerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE petsitters.gameanswer_answerid_seq OWNER TO postgres;

--
-- Name: gameanswer_answerid_seq; Type: SEQUENCE OWNED BY; Schema: petsitters; Owner: postgres
--

ALTER SEQUENCE petsitters.gameanswer_answerid_seq OWNED BY petsitters.gameanswer.answerid;


--
-- Name: gamequestion; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters.gamequestion (
    questionid integer NOT NULL,
    questiontext character varying,
    chapter character varying NOT NULL
);


ALTER TABLE petsitters.gamequestion OWNER TO postgres;

--
-- Name: gamequestion_questionid_seq; Type: SEQUENCE; Schema: petsitters; Owner: postgres
--

CREATE SEQUENCE petsitters.gamequestion_questionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE petsitters.gamequestion_questionid_seq OWNER TO postgres;

--
-- Name: gamequestion_questionid_seq; Type: SEQUENCE OWNED BY; Schema: petsitters; Owner: postgres
--

ALTER SEQUENCE petsitters.gamequestion_questionid_seq OWNED BY petsitters.gamequestion.questionid;


--
-- Name: user; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters."user" (
    userid integer NOT NULL,
    fullname character varying,
    phone character varying,
    email character varying,
    profession character varying,
    currentgamequestionid integer
);


ALTER TABLE petsitters."user" OWNER TO postgres;

--
-- Name: user_userid_seq; Type: SEQUENCE; Schema: petsitters; Owner: postgres
--

CREATE SEQUENCE petsitters.user_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE petsitters.user_userid_seq OWNER TO postgres;

--
-- Name: user_userid_seq; Type: SEQUENCE OWNED BY; Schema: petsitters; Owner: postgres
--

ALTER SEQUENCE petsitters.user_userid_seq OWNED BY petsitters."user".userid;


--
-- Name: useranswer; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters.useranswer (
    userid integer NOT NULL,
    questionid integer NOT NULL,
    answertext character varying,
    score integer
);


ALTER TABLE petsitters.useranswer OWNER TO postgres;

--
-- Name: gameanswer answerid; Type: DEFAULT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gameanswer ALTER COLUMN answerid SET DEFAULT nextval('petsitters.gameanswer_answerid_seq'::regclass);


--
-- Name: gamequestion questionid; Type: DEFAULT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gamequestion ALTER COLUMN questionid SET DEFAULT nextval('petsitters.gamequestion_questionid_seq'::regclass);


--
-- Name: user userid; Type: DEFAULT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters."user" ALTER COLUMN userid SET DEFAULT nextval('petsitters.user_userid_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.alembic_version (version_num) FROM stdin;
4b0640fafad9
\.


--
-- Data for Name: gameanswer; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.gameanswer (answerid, questionid, answertext, is_correct) FROM stdin;
\.


--
-- Data for Name: gamequestion; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.gamequestion (questionid, questiontext, chapter) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters."user" (userid, fullname, phone, email, profession, currentgamequestionid) FROM stdin;
1	Иванов Иван Иванович	+79231234567	ivanov@example.com	Dog	0
\.


--
-- Data for Name: useranswer; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.useranswer (userid, questionid, answertext, score) FROM stdin;
\.


--
-- Name: gameanswer_answerid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.gameanswer_answerid_seq', 1, false);


--
-- Name: gamequestion_questionid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.gamequestion_questionid_seq', 36, true);


--
-- Name: user_userid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.user_userid_seq', 2, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: gameanswer gameanswer_pkey; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gameanswer
    ADD CONSTRAINT gameanswer_pkey PRIMARY KEY (answerid, questionid);


--
-- Name: gamequestion gamequestion_pkey; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gamequestion
    ADD CONSTRAINT gamequestion_pkey PRIMARY KEY (questionid);


--
-- Name: gameanswer unique_answer_question; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gameanswer
    ADD CONSTRAINT unique_answer_question UNIQUE (answerid, questionid);


--
-- Name: useranswer unique_user_question; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT unique_user_question PRIMARY KEY (userid, questionid);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (userid);


--
-- Name: ix_petsitters_gameanswer_answerid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gameanswer_answerid ON petsitters.gameanswer USING btree (answerid);


--
-- Name: ix_petsitters_gameanswer_answertext; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gameanswer_answertext ON petsitters.gameanswer USING btree (answertext);


--
-- Name: ix_petsitters_gameanswer_is_correct; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gameanswer_is_correct ON petsitters.gameanswer USING btree (is_correct);


--
-- Name: ix_petsitters_gameanswer_questionid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gameanswer_questionid ON petsitters.gameanswer USING btree (questionid);


--
-- Name: ix_petsitters_gamequestion_questionid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gamequestion_questionid ON petsitters.gamequestion USING btree (questionid);


--
-- Name: ix_petsitters_gamequestion_questiontext; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_gamequestion_questiontext ON petsitters.gamequestion USING btree (questiontext);


--
-- Name: ix_petsitters_user_currentgamequestionid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_user_currentgamequestionid ON petsitters."user" USING btree (currentgamequestionid);


--
-- Name: ix_petsitters_user_email; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE UNIQUE INDEX ix_petsitters_user_email ON petsitters."user" USING btree (email);


--
-- Name: ix_petsitters_user_fullname; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_user_fullname ON petsitters."user" USING btree (fullname);


--
-- Name: ix_petsitters_user_phone; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_user_phone ON petsitters."user" USING btree (phone);


--
-- Name: ix_petsitters_user_profession; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_user_profession ON petsitters."user" USING btree (profession);


--
-- Name: ix_petsitters_user_userid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_user_userid ON petsitters."user" USING btree (userid);


--
-- Name: ix_petsitters_useranswer_answertext; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_useranswer_answertext ON petsitters.useranswer USING btree (answertext);


--
-- Name: ix_petsitters_useranswer_questionid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_useranswer_questionid ON petsitters.useranswer USING btree (questionid);


--
-- Name: ix_petsitters_useranswer_score; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_useranswer_score ON petsitters.useranswer USING btree (score);


--
-- Name: ix_petsitters_useranswer_userid; Type: INDEX; Schema: petsitters; Owner: postgres
--

CREATE INDEX ix_petsitters_useranswer_userid ON petsitters.useranswer USING btree (userid);


--
-- Name: gameanswer gameanswer_questionid_fkey; Type: FK CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.gameanswer
    ADD CONSTRAINT gameanswer_questionid_fkey FOREIGN KEY (questionid) REFERENCES petsitters.gamequestion(questionid);


--
-- Name: useranswer useranswer_questionid_fkey; Type: FK CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT useranswer_questionid_fkey FOREIGN KEY (questionid) REFERENCES petsitters.gamequestion(questionid);


--
-- Name: useranswer useranswer_userid_fkey; Type: FK CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT useranswer_userid_fkey FOREIGN KEY (userid) REFERENCES petsitters."user"(userid);


--
-- PostgreSQL database dump complete
--

