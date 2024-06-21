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
    score integer
);


ALTER TABLE petsitters.useranswer OWNER TO postgres;

--
-- Name: usertestresult; Type: TABLE; Schema: petsitters; Owner: postgres
--

CREATE TABLE petsitters.usertestresult (
    resultid integer NOT NULL,
    userid integer NOT NULL,
    temperament character varying(255) NOT NULL,
    extraversion_result character varying(255) NOT NULL,
    neuroticism_result character varying(255) NOT NULL,
    lie_result character varying(255) NOT NULL
);


ALTER TABLE petsitters.usertestresult OWNER TO postgres;

--
-- Name: usertestresult_resultid_seq; Type: SEQUENCE; Schema: petsitters; Owner: postgres
--

CREATE SEQUENCE petsitters.usertestresult_resultid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE petsitters.usertestresult_resultid_seq OWNER TO postgres;

--
-- Name: usertestresult_resultid_seq; Type: SEQUENCE OWNED BY; Schema: petsitters; Owner: postgres
--

ALTER SEQUENCE petsitters.usertestresult_resultid_seq OWNED BY petsitters.usertestresult.resultid;


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
-- Name: usertestresult resultid; Type: DEFAULT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.usertestresult ALTER COLUMN resultid SET DEFAULT nextval('petsitters.usertestresult_resultid_seq'::regclass);


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
1	1	была ли ранее собака на передержке?	t
2	1	есть у собаки страхи, тревожность или агрессия?	t
3	1	грызет ли собака вещи дома, разрушает ли имущество когда остается одна?	t
4	1	есть ли какие-то проблемы со здоровьем и аллергии?	t
5	1	привита ли собака в соответствии с возрастом?	t
1	2	познакомиться с владельцем и спросить подробно про собаку	t
2	2	подготовить квартиру, убрать все ценные вещи повыше, а обувь в шкаф, спрятать все провода	t
3	2	купить побольше еды, позвать гостей и устроить вечеринку	f
4	2	прибраться перед приездом собаки	t
1	3	выйти на улицу и познакомить собак на нейтральной территории, все собаки на поводке	t
2	3	в квартире, все собаки без поводков	f
3	3	на улице, собаки могут быть без поводков	f
1	4	собака со сложным характером, боится людей и недоверчива	t
2	4	раннее во время передержки между ситтером и собакой были разногласия	t
3	4	собака с агрессией и трудным характером	t
4	4	владелец убедится, что собака будет жить в комфорте, в чистоте, помещение соответствует описанию, лично познакомиться с догситтером и появится больше доверия к вам	t
1	5	без поводков в свободном выгуле	f
2	5	подводим собак всегда на расслабленных поводках	t
3	5	не имеет значения, натягивает собака поводок или нет	f
4	5	нужно крепко держать собаку за поводок и подтягивать ее вверх чтобы она не рвалась	f
1	6	убрать все ценные вещи повыше, убрать провода, убрать бытовую химию в шкафы	t
2	6	убрать еду повыше и мусорное ведро спрятать в шкафе	t
3	6	позвать гостей, устроить вечернику в честь нового гостя	f
4	6	помыть квартиру с дезинфицирующими средствами, проветрить и убрать все опасные предметы	t
1	7	радостно кричать, наклоняться сверху чтобы погладить, пытаться сразу обнимать собаку	f
2	7	активно гладить собаку по голове, интенсивно ее массировать и громко говорить	f
3	7	спокойно поприветствовать собаку, присесть на ее уровень боком к ней и протянуть к ней руку ладонью вверх, дать собаке понюхать свою руку	t
4	7	не пытаться гладить сразу собаку, не претендовать на ее личные границы и дать собаке время самой проявить к вам интерес	t
1	8	вести себя спокойно, все движения медленные и уверенные	t
2	8	взять в руку лакомство, присесть к собаке боком и на вытянутой руке протянуть лакомство, не глядя ей в глаза	t
3	8	не пытаться ее гладить, не смотреть пристально в глаза, не нависать над собакой, встать к собаке боком или спиной	t
4	8	начнет много говорить с собакой, пытаться ее гладить и успокаивать	f
1	9	лизательный коврик	t
2	9	флисовый канатик	t
3	9	нюхательный коврик или мяч	t
4	9	конг и другие игрушки из мягкой резины	t
1	10	заранее попросить владельца подготовить долгоиграющие лакомства (бычий корень, уши, нос, трахея, рубец)	t
2	10	если владелец привез антистресс игрушки, то подготовить Конг и лизательный коврик с паштетом	t
3	10	вывести на длительную прогулку около 1 часа в тихий и спокойный двор, поиграть с собакой, взять с собой лакомства и воду	t
4	10	создать спокойную и комфортную атмосферу дома, без шума и громкой музыки, не давать дополнительной нагрузки для нервной системы	t
1	11	начать ругать и кричать на собаку за лай	f
2	11	закрыть ее в комнате и уйти по делам	f
3	11	помочь ей отвлечься, дать ей лизательный коврик с паштетом или Конг или долгоиграющее лакомство - если они есть	t
4	11	можно предложить поиграть в паттерн игры и переключить внимание на лакомство и контакт с вами	t
5	11	вывести на длительную прогулку в тихое место, взять игрушки, лакомство и воду	t
1	12	заранее узнать делает ли так собака у владельца в дома, если да то как владелец себя ведет?	t
2	12	наругать ее за это и отпугнуть бросив какой-то предмет	f
3	12	шлепнуть тапком или газетой	f
4	12	переключить внимание на взаимодействие с вами, не ругать и не кричать на собаку, такое поведение говорит о тревоге и нервном напряжении, поэтому лучше вывести на улицу и спокойно подольше погулять	t
5	12	написать владельцу и решить с владельцем как лучше поступить, возможно временно ограничить проход к дивану или в какую-то комнату, но при этом заняться состоянием собаки через паттерн игры и совместные прогулки, сделать массаж расслабляющий дома для собаки чтобы ее успокоить	t
1	13	для щенка нужно больше внимания и времени	t
2	13	щенок может погрызть мебель, испортить вещи	t
3	13	сделать лужи и кучки мимо пеленки или там где ему захочется	t
4	13	нужно чаще кормить и чаще гулять, больше уделять времени	t
5	13	щенка не оставить одного надолго, чаще всего нужно быть с ним дома	t
1	14	2-3 раза в день	t
2	14	раз в неделю	f
3	14	1-2 раза в день с описанием того как прошел день у собаки, как она себя чувствует, хорошо ли ест, ходит в туалет	t
4	14	узнать у владельца как часто он хочет получать фото и видео своей собаки	t
1	15	позвонить в PETSITTER и владельцу, при первых признаках заболевания	t
2	15	не давать никаких лекарств самостоятельно без обсуждения с владельцем и осмотра ветеринарного врача	t
3	15	отвезти на прием к ветеринарному врачу у которого наблюдается собака или в ближайшую ветеринарную клинику	t
4	15	записывать в блокнот симптомы которые вы заметили и как часто они проявлялись	t
1	16	быстро и уверенно взять руками и открыть пасть держа за верхнюю челюсть одной рукой и другой рукой достать предмет из пасти, после этого выбросить предмет в мусорку	t
2	16	накричать на собаку и наругать	f
3	16	забрать из пасти опасный предмет и наругать собаку и шлепнуть поводком	f
1	17	быстро и уверенно взять руками и открыть пасть держа за верхнюю челюсть одной рукой и другой рукой достать предмет из пасти, после этого выбросить предмет в мусорку	t
2	17	накричать на собаку и наругать	f
3	17	забрать из пасти опасный предмет и наругать собаку и шлепнуть поводком	f
1	18	можно только на закрытой площадке для собак	t
2	18	узнать у владельца разрешает ли он так делать и только на закрытой площадке для собак	t
3	18	да можно, поиграют и все, никуда не денется	f
4	18	нельзя, собака на передержке должна выгуливаться только на поводке, даже если владелец просит об обратном, все равно нет, исключения закрытые площадки для собак	t
1	19	побегу за ней, чтобы поймать	f
2	19	буду кричать «ко мне» и стоять на месте	f
3	19	буду спокоен, присяду на корточки и добрым голосом буду заманивать к себе показывая в руке лакомство, шурша пакетиком, делая вид что все в порядке, смотри у меня для тебя есть угощение или поманю игрушкой или палкой чтобы она прибежала ко мне поиграть	t
4	19	буду кричать и просить окружающих поймать собаку	f
1	20	отсматривать собак на наличие повреждений, царапин и ссадин, а также на наличие клещей	t
2	20	мыть лапы и вытирать их насухо	t
3	20	кормить собаку	t
4	20	высылать фото и видео владельцу	t
1	21	можно	f
2	21	нельзя	t
3	21	нужно узнать у владельца разрешает ли он	f
5	20	string	t
\.


--
-- Data for Name: gamequestion; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.gamequestion (questionid, questiontext, chapter) FROM stdin;
1	Что нужно узнать у владельца перед передержкой?	one
2	Что нужно сделать до передержки?	two
3	Как правильно знакомить собак на передержке?	three
4	При каких условиях владелец может попросить заранее познакомиться с ситтером?	one
5	Как правильно знакомить собак?	one
6	Как подготовить квартиру к передержке?	two
7	Как правильно знакомиться с собакой?	three
8	Как должен себя вести ситтер если собака на первой встрече проявляет к нему агрессию или боится его?	three
9	Какие антистресс игрушки желательно чтобы владелец собаки положил с вещами для питомца?	four
10	Как помочь собаке адаптироваться на новом месте и снизить стресс от разлуки с хозяином?	six
11	Что делать если собака воет, скулит и лает после того как ушел хозяин?	six
12	Что делать если собака начала метить углы мебели, шкафы в вашем доме?	six
13	В чем отличие передержки щенка от передержки взрослой собаки?	five
14	Сколько раз в день нужно высылать фото и видео отчет о состоянии собаки?	eleven
15	Если собака стала себя хуже чувствовать, пропал аппетит, появилась рвота или кашель и симптомы простуды, что нужно делать?	ten
16	Что должен сделать догситтер если собака на прогулке схватила что-то с земли и попытается съесть?	ten
17	Что должен сделать догситтер, если собака на прогулке схватила что-то с земли и попытается съесть?	seven
18	Во время прогулки с собакой, можно ли отпускать ее с поводка поиграть и побегать с другими собаками?	seven
19	Если собака сорвалась с поводка и убегает, ваши действия:	ten
20	Что важно делать после каждой прогулки?	seven
21	Можно ли брать на кровать маленького щенка или миниатюрную собаку?	five
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters."user" (userid, fullname, phone, email, profession, currentgamequestionid) FROM stdin;
3	Филипп К	789456123	user@example.com	string	0
5	string	string	user54@example.com	string	0
4	string	string	user123@example.com	string	4
1	Иванов Иван Иванович	+79231234567	ivanov@example.com	Dog	5
\.


--
-- Data for Name: useranswer; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.useranswer (userid, questionid, score) FROM stdin;
1	5	0
\.


--
-- Data for Name: usertestresult; Type: TABLE DATA; Schema: petsitters; Owner: postgres
--

COPY petsitters.usertestresult (resultid, userid, temperament, extraversion_result, neuroticism_result, lie_result) FROM stdin;
1	1	холерик	яркий экстраверт	очень высокий уровень нейротизма	Ответы в норме
\.


--
-- Name: gameanswer_answerid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.gameanswer_answerid_seq', 1, false);


--
-- Name: gamequestion_questionid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.gamequestion_questionid_seq', 21, true);


--
-- Name: user_userid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.user_userid_seq', 5, true);


--
-- Name: usertestresult_resultid_seq; Type: SEQUENCE SET; Schema: petsitters; Owner: postgres
--

SELECT pg_catalog.setval('petsitters.usertestresult_resultid_seq', 1, true);


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
-- Name: usertestresult usertestresult_pkey; Type: CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.usertestresult
    ADD CONSTRAINT usertestresult_pkey PRIMARY KEY (resultid);


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
-- Name: usertestresult usertestresult_userid_fkey; Type: FK CONSTRAINT; Schema: petsitters; Owner: postgres
--

ALTER TABLE ONLY petsitters.usertestresult
    ADD CONSTRAINT usertestresult_userid_fkey FOREIGN KEY (userid) REFERENCES petsitters."user"(userid);


--
-- PostgreSQL database dump complete
--

