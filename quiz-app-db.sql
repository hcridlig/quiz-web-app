--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: hugo.cridlig
--

CREATE TABLE public.categories (
    idcat integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    image character varying(255)
);


ALTER TABLE public.categories OWNER TO "hugo.cridlig";

--
-- Name: categories_idcat_seq; Type: SEQUENCE; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE public.categories ALTER COLUMN idcat ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categories_idcat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: hugo.cridlig
--

CREATE TABLE public.games (
    idgame integer NOT NULL,
    start_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    end_time timestamp without time zone,
    idcat integer NOT NULL,
    roomid character(4) NOT NULL
);


ALTER TABLE public.games OWNER TO "hugo.cridlig";

--
-- Name: games_idgame_seq; Type: SEQUENCE; Schema: public; Owner: hugo.cridlig
--

CREATE SEQUENCE public.games_idgame_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.games_idgame_seq OWNER TO "hugo.cridlig";

--
-- Name: games_idgame_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugo.cridlig
--

ALTER SEQUENCE public.games_idgame_seq OWNED BY public.games.idgame;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: hugo.cridlig
--

CREATE TABLE public.questions (
    idquest integer NOT NULL,
    question character varying(300) NOT NULL,
    "optionA" character varying(145) NOT NULL,
    "optionB" character varying(118) NOT NULL,
    "optionC" character varying(147),
    "optionD" character varying(140),
    correct_answer character varying(147) NOT NULL,
    idcat integer NOT NULL
);


ALTER TABLE public.questions OWNER TO "hugo.cridlig";

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: hugo.cridlig
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO "hugo.cridlig";

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugo.cridlig
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.idquest;


--
-- Name: results; Type: TABLE; Schema: public; Owner: hugo.cridlig
--

CREATE TABLE public.results (
    idresult integer NOT NULL,
    idgame integer NOT NULL,
    iduser integer NOT NULL,
    score integer NOT NULL
);


ALTER TABLE public.results OWNER TO "hugo.cridlig";

--
-- Name: results_idresult_seq; Type: SEQUENCE; Schema: public; Owner: hugo.cridlig
--

CREATE SEQUENCE public.results_idresult_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.results_idresult_seq OWNER TO "hugo.cridlig";

--
-- Name: results_idresult_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugo.cridlig
--

ALTER SEQUENCE public.results_idresult_seq OWNED BY public.results.idresult;


--
-- Name: users; Type: TABLE; Schema: public; Owner: hugo.cridlig
--

CREATE TABLE public.users (
    iduser integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    role boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO "hugo.cridlig";

--
-- Name: users_iduser_seq; Type: SEQUENCE; Schema: public; Owner: hugo.cridlig
--

CREATE SEQUENCE public.users_iduser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_iduser_seq OWNER TO "hugo.cridlig";

--
-- Name: users_iduser_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugo.cridlig
--

ALTER SEQUENCE public.users_iduser_seq OWNED BY public.users.iduser;


--
-- Name: games idgame; Type: DEFAULT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.games ALTER COLUMN idgame SET DEFAULT nextval('public.games_idgame_seq'::regclass);


--
-- Name: questions idquest; Type: DEFAULT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.questions ALTER COLUMN idquest SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: results idresult; Type: DEFAULT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.results ALTER COLUMN idresult SET DEFAULT nextval('public.results_idresult_seq'::regclass);


--
-- Name: users iduser; Type: DEFAULT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.users ALTER COLUMN iduser SET DEFAULT nextval('public.users_iduser_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: hugo.cridlig
--

COPY public.categories (idcat, title, description, image) FROM stdin;
2	Histoire	Questions sur l'histoire du monde	/images/Histoire.jpeg
7	Musique	Questions sur la musique et les artistes	/images/Musique.jpeg
3	Géographie	Questions sur la géographie et les pays du monde	/images/Géographie.jpeg
6	Cinéma	Questions sur les films et les acteurs	/images/Cinéma.jpeg
8	Culture générale	Questions sur la culture générale	/images/Culturegénérale.jpeg
5	Littérature	Questions sur la littérature et les livres	/images/Littérature.jpeg
4	Sciences	Questions sur les sciences et la technologie	/images/Sciences.png
1	Sports	Questions sur le sport et les athlètes	/images/Sports.webp
9	Animaux	Questions sur les animaux et la faune	/images/Animaux.jpeg
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: hugo.cridlig
--

COPY public.games (idgame, start_time, end_time, idcat, roomid) FROM stdin;
1	2023-03-16 14:00:00	2023-03-16 15:00:00	2	sH6h
2	2024-04-12 14:00:00	2024-04-12 15:00:00	4	8jrg
3	2024-04-26 00:00:00	\N	4	e   
4	2023-03-16 14:00:00	2023-03-16 14:00:00	8	dkom
6	2024-04-25 15:01:04.325	\N	9	zj63
7	2024-04-25 15:03:20.26	\N	9	h0yz
8	2024-04-25 15:04:43.865	2024-04-25 15:04:59.687	9	afcy
9	2024-04-25 15:34:55.183	2024-04-25 15:35:11.933	9	hv3x
10	2024-04-25 15:37:03.76	2024-04-25 15:37:07.536	9	pb3i
11	2024-04-25 15:38:19.426	2024-04-25 15:38:22.668	9	4q74
12	2024-04-25 15:38:36.764	2024-04-25 15:38:39.999	9	bswu
13	2024-04-25 15:51:29.991	2024-04-25 15:51:33.794	9	tswv
14	2024-04-25 15:58:31.991	2024-04-25 15:58:35.572	9	2tfu
15	2024-04-25 16:01:12.392	2024-04-25 16:01:16.006	9	foc9
16	2024-04-25 16:02:20.194	2024-04-25 16:02:23.784	9	ks0s
17	2024-04-25 16:06:20.883	2024-04-25 16:06:24.436	9	sa6q
18	2024-04-25 16:10:22.97	2024-04-25 16:10:26.61	9	l2r7
19	2024-04-25 16:12:31.962	2024-04-25 16:12:35.563	9	qp2v
20	2024-04-25 16:56:00.985	2024-04-25 16:56:04.251	9	zp3z
21	2024-04-25 17:28:02.669	2024-04-25 17:28:05.877	9	oylm
22	2024-04-25 17:28:44.583	2024-04-25 17:28:47.792	9	t56x
23	2024-04-25 21:26:05.517	2024-04-25 21:26:08.814	9	jasw
24	2024-04-25 21:27:19.65	2024-04-25 21:27:22.873	9	g6y4
25	2024-04-25 21:27:57.453	2024-04-25 21:28:28.198	9	wwe8
26	2024-04-25 21:28:10.842	2024-04-25 21:28:41.045	9	5611
27	2024-04-26 10:54:18.342	2024-04-26 10:54:28.815	3	jd95
28	2024-04-26 10:55:34.03	2024-04-26 10:55:44.268	3	ydzv
29	2024-04-26 10:55:48.324	2024-04-26 10:55:58.544	3	9rh6
30	2024-04-26 10:55:59.73	2024-04-26 10:56:29.936	9	3d68
31	2024-04-26 11:00:37.047	2024-04-26 11:01:07.29	3	kjrf
32	2024-04-26 11:04:30.759	2024-04-26 11:05:01.168	2	2rpd
33	2024-04-26 11:23:59.236	2024-04-26 11:24:09.894	9	zh6g
34	2024-04-26 11:24:14.73	2024-04-26 11:24:25.551	9	k4w2
35	2024-04-26 11:24:27.273	2024-04-26 11:24:37.697	9	plev
36	2024-04-26 11:24:44.413	2024-04-26 11:25:14.612	3	fejw
37	2024-04-26 11:25:37.195	2024-04-26 11:25:47.439	9	yice
38	2024-04-26 11:26:20.985	2024-04-26 11:26:31.197	9	aocl
39	2024-04-26 11:26:38.104	2024-04-26 11:26:48.317	9	5aui
40	2024-04-26 11:27:56.862	2024-04-26 11:28:07.639	9	nc8v
41	2024-04-26 11:28:40.847	2024-04-26 11:28:51.06	9	cril
42	2024-04-26 11:29:22.764	2024-04-26 11:29:33.071	9	co5x
43	2024-04-26 11:29:56.121	2024-04-26 11:30:06.356	9	72fd
44	2024-04-26 11:30:47.365	2024-04-26 11:30:57.565	9	qun0
45	2024-04-26 11:31:34.534	2024-04-26 11:31:44.805	9	8hso
46	2024-04-26 11:31:47.084	2024-04-26 11:32:17.311	3	009u
47	2024-04-26 11:33:04.907	2024-04-26 11:33:35.142	3	7e9e
48	2024-04-26 11:33:55.829	2024-04-26 11:34:06.08	9	estl
49	2024-04-26 11:34:08.353	2024-04-26 11:34:38.567	3	ekw2
50	2024-04-26 11:38:39.245	2024-04-26 11:39:09.546	2	us2z
51	2024-04-26 11:38:51.804	2024-04-26 11:39:22.015	2	yz69
52	2024-04-26 11:39:04.437	2024-04-26 11:39:34.657	3	cge5
53	2024-04-26 12:08:44.055	2024-04-26 12:09:14.42	3	3nqc
54	2024-04-26 12:08:58.166	2024-04-26 12:09:28.372	3	x2jk
55	2024-04-26 12:09:08.685	2024-04-26 12:09:38.894	2	trfg
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: hugo.cridlig
--

COPY public.questions (idquest, question, "optionA", "optionB", "optionC", "optionD", correct_answer, idcat) FROM stdin;
1510	How many types of bats are there?	900	700	500	200	900	3
2494	In which US state is the active Mount Rainier volcano located?	Michigan	Ohio	Washington	New York	Washington	2
2495	In 1990, this 5000 year old body was found in the Alps. Scientists discovered some tattoos on his leg which indicated that acupuncture was used as far back as the Copper-stone Age.	Big Foot	Sasquatch	Nessie	Oetzi	Oetzi	2
2496	After unsuccessful  talks about oil production and debt repayment, Iraq occupied Kuwait.  In January 1991 the US launched an air attack against military targets in Iraq and Kuwait in this operation.	Matador	BOLERO	Determined Force	Desert Storm	Desert Storm	2
2497	It is the process of producing identical copies of a DNA segment asexually.  In 1996 the first successful one of an animal was made. The animals name was Dolly.  Dolly later died, but Richard Seed announced that he intended try it on humans.	Organ Transplant	Cloning	Bloodless Surgery	Laser Surgery	Cloning	2
2498	This kind of music became largely popular in Europe and America in the 1990s. It is a melodic, free form combination between techno and house, having hypnotic qualities. The first distinctive track of this kind was Age Of Love, released in 1990.	Electro	Trance	Techno	Dance	Trance	2
2499	This womans death was arguably the most shocking one of the decade. She died in 1997 in a car crash while evading paparazzi. The woman was taken to a hospital, but the two-hour efforts of surgeons to save her life were unsuccessful.	Greta Garbo	Nancy Marchand	Madam C. J. Walker	Princess Diana	Princess Diana	2
2500	This union, made up of European countries, was established by the Maastricht Treaty in 1992. Starting as a trade body it is now an economic and political partnership between its members.	American Labor Union	Oxford Union	The European Union	European Trade Union	The European Union	2
2501	Although the first one was sent in 1971, it became widely popular in 1998. Its popularity caused explosive growth of the internet.	The Chat programs	The URL	The E-mail	The Website	The E-mail	2
2502	Impeachment stands for quickly removing dangerously criminal officials from high office. The Impeachment Trial in the Senate for this US President commenced on January 7, 1999.	George Bush	Ronald Reagan	Bill Clinton	Richard Nixon	Bill Clinton	2
2503	On August 17, 1999 this disaster took the lives of 15 000 and injured 23 000 people in western Turkey.	Earthquake	Tsunami	Avalanche	Volcano eruption	Earthquake	2
2504	These became more advanced and more popular in the 1990, with some of the most influential ones being  the Super Nintendo Entertainment System, the Sony Playstation, and the Sega Dreamcast.	Dating sites	Virtual reality systems	Video Game consoles	Computer games	Video Game consoles	2
2505	The Punic Wars were a series of three wars fought between these two powers.	Rome and Athens	Athens and Sparta	Carthage and Athens	Rome and Carthage	Rome and Carthage	2
2506	The 1938 incorporation of Austria in Greater Germany under the Nazi Regime is known as this.	Ansatz	Abwer	Anschluss	Ahnentafel	Anschluss	2
2507	Henry Kissinger held this US post from 1974 to 1977.	President of the Senate	Speaker of the House of Representatives	National Security Advisor	Secretary of State	Secretary of State	2
2508	One of these cities has been Japans capital in the past.	Kyoto	Yokohama	Hiroshima	Osaka	Kyoto	2
2509	Valeria Messalina was the third wife of this Roman emperor.	Caligula	Tiberius	Nero	Claudius	Claudius	2
2510	Philip II of France, Richard I of England and Frederick I led this campaign.	Childrens Crusade	Albigensian Crusade	Fourth Crusade	Third Crusade	Third Crusade	2
2511	Yu the Great was the legendary first Chinese monarch of this dynasty.	Xia Dynasty	Qing (Manchu) Dynasty	Ming Dynasty	Yuan Dynasty	Xia Dynasty	2
2512	This German general was nicknamed The Desert Fox due to the skillful military campaigns he waged in North Africa, during World War II.	Erwin Rommel	Hermann Goring	George Patton	Bernard Montgomery	Erwin Rommel	2
2513	How many landing beaches were there in the 1944 Normandy Invasion, known as Operation Overlord?	Four	Six	Five	Three	Five	2
2514	What was the name of the first jet-powered fighter used in World War II?	P-51	Hurricane	Me-262	MIG-3	Me-262	2
2515	Which member of the Nazi Party was known as Adolph Hitlers first architect of the Third Reich?	Rudolph Hess	Albert Speer	Hermann Goring	Joseph Mengele	Albert Speer	2
2516	The British evacuation from which French port was codenamed Operation Dynamo, in 1940?	Brest	Cherbourg	Dunkirk	Toulon	Dunkirk	2
2517	Which American politician said the following about liberty: They that can give up essential liberty to obtain a little temporary safety deserve neither liberty nor safety.�?	Benjamin Franklin	Thomas Jefferson	Abraham Lincoln	George Washington	Benjamin Franklin	2
2518	Which US President delivered the following words: Ask not what your country can do for you, ask what you can do for your country.?	William J. Clinton	Franklin D. Roosevelt	Abraham Lincoln	John F. Kennedy	John F. Kennedy	2
2519	Which US President said these words: A democracy is nothing more than mob rule, where fifty-one percent of the people may take away the rights of the other forty-nine.?	Abraham Lincoln	Thomas Jefferson	Benjamen Franklin	John F. Kennedy	Thomas Jefferson	2
2520	Which US President made the following statement: America stands for liberty, for the pursuit of happiness and for the unalienable right for life. This right to life cannot be granted or denied by government because it does not come from the government, it comes from the creator of life.?	George W. Bush	Thomas Jefferson	John Adams	George Washington	George W. Bush	2
1811	How many subspecies of the tiger are left nowadays?	8	6	2	3	6	3
1982	What type of mammal is the Culpeo?	Beaver	Wild cat	Wild dog	Fox	Wild dog	3
2010	How many legs do ants have?	10	6	8	4	6	3
2170	Which of these names does not refer to a sloth?	Ritto	Rit	Rikki-Tikki-Tavi	Ridette	Rikki-Tikki-Tavi	3
2338	How many hearts do most octopi have?	2	1	3	0	3	3
1474	Three of these animals hibernate. Which one does not?	Mouse	Sloth	Frog	Snake	Sloth	3
1475	Three of these animals hibernate. Which one does not?	Mouse	Sloth	Frog	Snake	Sloth	3
1476	All of these animals are omnivorous except one.	Fox	Mouse	Opossum	Snail	Snail	3
1477	Three of these Latin names are names of bears. Which is the odd one?	Melursus ursinus	Helarctos malayanus	Ursus minimus	Felis silvestris catus	Felis silvestris catus	3
1478	These are typical Australian animals except one.	Platypus	Dingo	Echidna	Sloth	Sloth	3
1479	Representatives of three of these species produce venom of their own. Which is the odd species?	Lizards	Scorpions	Frogs	Mosquitos	Mosquitos	3
1480	Three of these species shed their skin. Which one does not?	Penguins	Snakes	Insects	Crustaceans	Penguins	3
1481	All of these animals have large ears (relative to their size) except one.	Polar bears	Foxes	Bats	Elephants	Polar bears	3
1482	This percentage of all snakes on Earth are lethal to humans.	10%	20%	15%	25%	15%	3
1483	Snakes are this kind of animals.	Herbivorous	Omnivorous	Carnivorous	Vegetarian	Carnivorous	3
1484	Snakes consume their food by means of this process.	Breathing	Absorption	Swallowing	Chewing	Swallowing	3
1485	Snakes belong to the following category.	Invertebrates	Lizards	Reptiles	Mammals	Reptiles	3
1486	A specialist in snakes is called one of these.	Pisciculturist	Ornithologist	Ophiologist	Herpetologist	Ophiologist	3
1487	One of the following snakes does not belong to the Viperidae family.	Horned adder	Grass snake	Viper	Asp	Grass snake	3
1488	Cobras are venomous snakes of family Elapidae, that generally inhabit regions of these two continents.	South America and Asia	Asia and Africa	Asia and Australia	South America and Australia	Asia and Africa	3
1489	The cobras most recognizable feature is its hood, a flap of skin and muscle behind the head, believed to serve this purpose.	Balance control	Heat collection from sun rays	Camouflage	More threatening appearance	More threatening appearance	3
1490	The Cobra is at the top of the food chain, with only two main predators -- one is man and the other is this animal.	Jackal	Mongoose	Lynx	Eagle	Mongoose	3
1491	This is where the Cobras ribs are situated.	Behind its head	In its chest, around the middle of the body	Cobras have no ribs	In its tale	Behind its head	3
1492	A baby cobra is fully able to defend itself in as little as this many hours after being born.	3	12	48	72	3	3
1493	What type of dog did Richard Nixon receive from a Texan while he was a candidate for Vice President?	German Shepherd	Cocker Spaniel	Golden Retriever	Welsh Corgy	Cocker Spaniel	3
1494	What was the name of Socks companion at the White House during the Clinton Administration?	Buddy	Shoes	Bailey	Buster	Buddy	3
1495	Which of these Presidents had the most pets?	Franklin Delano Roosevelt	Theodore Roosevelt	Bill Clinton	Woodrow Wilson	Theodore Roosevelt	3
1496	What breed is known as the favourite breed of Queen Elizabeth II?	Border Collie	Old English Sheepdog	Welsh Corgi	Australian Cattle Dog	Welsh Corgi	3
1497	What was the name of Fraisers fathers dog on the hit TV show set in Seattle?	Niles	Marty	Eddie	Skip	Eddie	3
1498	Which one of these sea mammals is not in the endangered species lists?	Fin Whale	Pilot whale	Blue Whale	Humpback Whale	Pilot whale	3
1499	This endangered turtle is the biggest of all living turtles, reaching a length of over 2.7 m (8.8 ft) and weight of 900 kg (2,000 lb).	Leatherback Sea Turtle	Kemps Ridley Turtle	Hawksbill Sea Turtle	Mesoamerican River Turtle	Leatherback Sea Turtle	3
1500	Name the rarest and most endangered of all wolves.	Red Wolf	Ethiopian Wolf	Black-backed Wolf	Gray Wolf	Red Wolf	3
1501	This species of great apes with long arms and reddish hair suffer habitat destruction due to logging, mining and forest fires.	Gorilla	Baboons	Orangutan	Chimpanzee	Orangutan	3
1502	What is the natural habitat of the snows leopard, that was hunted down for its beautiful fur, as a result of which its population went down to 1,000 animals in the 1960s?	North America	Central Asia and North America	Central Asia	Europe and North America	Central Asia	3
1503	This freshwater mammal, found only in the Yangtze River, is the most endangered (even possibly extinct) cetacean and one of the most endangered species in the world.	Ganges River Dolphin	Chinese River Dolphin	La Plata Dolphin	Amazon River Dolphin	Chinese River Dolphin	3
1504	This small nocturnal animal, whose natural habitat are the deserts of Northern Africa, is known to jump not only for hunting or protection, but also for pleasure.	Cape Fox	Red Fox	Bengal Fox	Fennec	Fennec	3
1505	Jack jumper ants, yellowish-orange carnivorous ants named after their characteristic jumpy motions, can be found only on which continent?	North America	Australia	Africa	Asia	Australia	3
1506	This small, graceful member of the antelope family is an extraordinary jumper - while leaping, it touches the rocky terrain of its South African habitats only with the tip of its hooves, resembling a dance.	Oribi	Roan Antelope	Scimitar Oryx	Klipspringer	Klipspringer	3
1507	Which of these animals swims the fastest?	Flounder	Shark	Dolphin	Jellyfish	Dolphin	3
1508	Which word refers to the sound peacocks make?	Scream	Squill	Squeak	Squall	Scream	3
1509	Ancient Japanese thought this animal caused earthquakes.	Birds	Spiders	Snakes	Frogs	Spiders	3
1511	This animal can clean its own ears with its 21-inch tongue.	Lizard	Elephant	Lion	Giraffe	Giraffe	3
1512	What is the fastest animal on 6 legs?	Ladybug	Cockroach	Beetle	Ant	Cockroach	3
1513	What is a female sheep called or known as?	ewe	colt	fleece	ram	ewe	3
1514	What is the white tigers scientific name?	Pantha	Panthera tigis	Panthera tiger	Panthera tigris	Panthera tigris	3
1515	Which of the following is not a type of chipmunk?	Bushy-tailed	Long-eared	Eastern	Sonoma	Bushy-tailed	3
1516	Which of these is not an actual breed of horse?	Sioux	Russian Trotter	Belgian	Murgese	Sioux	3
1517	Which of the following is not a breed of dog?	Pom-a-poo	Lakeland terrier	Fox terrier	Ferret terrier	Ferret terrier	3
1518	One of these is not a true breed of cat. Which one?	Pixie-bob	Maine coon	Ragdoll	French Twist	French Twist	3
1519	Which of these is not a type of beetle?	Long-horn beetle	Stag beetle	Flea beetle	Burrowing beetle	Burrowing beetle	3
1520	Which of the following is not a type of spider?	Glass spider	Trapdoor spider	Brown recluse spider	Bird-dropping spider	Glass spider	3
1521	All but one of the following are true types of bears. Which is the odd one?	Moon bear	Brown bear	Black bear	Sun bear	Moon bear	3
1522	Which of these is not an actual breed of sheep?	Scottish black-face	Dakota	Hampshire	Merino	Dakota	3
1523	One of these is not a true breed of chicken. Which one?	Hamburg	Plymouth Rock	Leghorn	Red-tailed	Red-tailed	3
1524	Which of the following is not a breed of pig?	Norwegian Yorkshire	Vietnamese pot-belly	Ridgeback	Tokyo-X	Ridgeback	3
1525	What is a group of lions called?	Family	Group	School	Pride	Pride	3
1526	Generally, how many times in an interval of 5 hours do lions mate?	1	5	20	10	10	3
1527	What is the breed of animal created from the crossing of a male lion and a female tiger?	Tigon	Tiges	Ligon	Liger	Liger	3
1528	What is the breed of animal created from the crossing of a female lion and a male tiger?	Tigen	Liger	Tigon	Liges	Tigon	3
1529	What do male lions have which females do not possess?	An extra tooth	A mane	Longer nails	Distinguished eyes	A mane	3
1530	What is the average lifespan of a lion living in the wild?	20 - 30 years	Less than 10 years	10 -15 years	Greater than 30 years	10 -15 years	3
1531	Cats twitch the tips of their tails slightly when hunting or when angry, while stronger twitching indicates what?	Stress	Displeasure	Boredom	Playfulness	Displeasure	3
1532	If a cat pushes its face against your head, this means what?	Impatience	Submission	Acceptance	Aggression	Acceptance	3
1533	Cats generally purr when they are happy, but they can also be heard purring in what other situation?	When they are distressed or in pain	When they are hunting or playing	When they are hungry or thirsty	When they are lonely or angry	When they are distressed or in pain	3
1534	How many different vocalization sounds does a cat make?	100	200	50	150	100	3
1535	What was the largest  eagle ever found on Earth?	Golden Eagle	Haasts Eagle	Harpy Eagle	Bald Eagle	Haasts Eagle	3
1536	Which term refers to the group formed by frogs and amphibians?	Drosophillia	Herps	Mollusks	Nematodes	Herps	3
1537	Which statement about elephants is untrue?	Elephants sleep standing up	Elephants cry	There are some pink elephants in India	Elephants do not have great memories	Elephants do not have great memories	3
1538	What is alektorophobia?	The unreasonable fear of birds of prey	The unreasonable fear of roaches	The unreasonable fear of chickens	The unreasonable fear of sharks	The unreasonable fear of chickens	3
1539	How do scientists calculate the age of a fish?	They count all the teeth in the fishs mouth.	They measure the size of the fish and compare that to the average size of that type of  fish.	They count the growth rings on the ear bone.	They count the teeth in the fishs lower lip.	They count the growth rings on the ear bone.	3
1540	Pound for pound, humans are not the strongest animals. What is considered the strongest species, pound for pound?	The Hercules beetle	The leaf-cutting ant	The red ant	The atlas roach	The Hercules beetle	3
1541	Human beings have 23 pairs of  chromosomes. Which animal has the most chromosomes?	minke whale	millipedes	elephants	hermit crabs	hermit crabs	3
1542	What type of animal is a lamprey?	worm	fish	insect	amphibian	fish	3
1543	What is the name of the first book by Darwin that directly dealt with evolution?	Essay on the Principles of Population	Totem and Taboo	On the Origins of the Species	The Descent of Man and the Selection in Relation to Sex	On the Origins of the Species	3
1544	Which of these animals has the largest paws?	An average mountain lion	An average nematode	An average lynx	An average lichen	An average lynx	3
1545	Despite the myth that Chihuahuas were descendants of the royal dog of the Aztecs, it is also believed that Spanish trade merchants brought Chihuahuas to which of these countries?	Venezuela	United States	Brazil	Mexico	Mexico	3
1546	What maximum height at the withers can Chihuahuas reach?	24 inches (60 cm)	15 inches (38 cm)	12 inches (30 cm)	9 inches (22 cm)	15 inches (38 cm)	3
1547	Chihuahuas are the only dogs to be born with what?	An extra leg tendon	Hairless inner ears	An incomplete skull	Two extra canine teeth	An incomplete skull	3
1548	What is the average lifespan of Chihuahuas?	8 - 12 years	8- 18 years	8 - 26 years	8 - 15 years	8- 18 years	3
1549	The Chihuahua Gidget is famous for what reason?	Paris Hilton has it as a pet.	It was a fill-in mascot for the Georgia Bulldogs.	It was a mascot for Taco Bell.	It was a mascot for Taco John.	It was a mascot for Taco Bell.	3
1550	What does the word �hippopotamus� mean?	Water pig	Fat horse	River horse	River pig	River horse	3
1551	How long in years is the life span of an average wild hippopotamus?	10-20	40-50	30-40	20-30	40-50	3
1552	This is the basic food of the sea. Billions upon billions of these organisms live in the sea.	Seaweed	Plankton	Crabs	Shrimp	Plankton	3
1553	This is the result of the gravitational pull from the moon and sun.	Migration of certain species of whales	Tides	Shoreline	Waves	Tides	3
1554	These creatures look like flowers as they grow attached to rocks. Their tentacles open like fleshy petals and contract whenever danger is near.	Kelp	Jellyfish	Sponges	Sea Anemones	Sea Anemones	3
1555	This sea animal, widely considered the most valuable shellfish, is common in shallow, warmer waters of all oceans.	Oyster	Shrimp	Scallop	Lobster	Oyster	3
1556	This crab is not really a crab, but an arthropod. Its closest relative is the spider.	Fiddler Crab	Horseshoe crab	Spider Crab	Rock Crab	Horseshoe crab	3
1557	These worms are not in fact worms, but bivalves. They enter wood as larvae, where they remain and grow, burrowing through the wood.	Sea Mice	Ribbon Worms	Lugworms	Shipworms	Shipworms	3
1558	Also called Sea Biscuit, this animal lives in deeper water half-buried in the sand.	Sand Dollar	Star Fish	Scallop	Mussel	Sand Dollar	3
1559	The red kangaroo appears on the Coat of Arms of Australia together with what other endemic Australian animal?	Emu	Platypus	Dingo	Koala	Emu	3
1560	Which of these mammals was brought to Australia by humans?	The echidna	The dingo	The koala	The Tasmanian tiger	The dingo	3
1561	Which of the following statements about echidnas, mammals native to Australia, is wrong?	Echidnas are covered with spines.	Echidnas have snouts.	Echidnas lay eggs.	Echidnas are marsupials.	Echidnas are marsupials.	3
1562	The diet of the koala consists mainly of what plant species?	Eucalyptus	Bamboo	Willow	Cork Oak	Eucalyptus	3
1612	How many young skunks can be born in one litter?	1-10	1-5	1-7	1-4	1-7	3
1563	Which one of these Australian reptiles is the largest living crocodile in the world?	The thorny devil	The weedy sea dragon	The blue-tongued skink	The saltwater crocodile	The saltwater crocodile	3
1564	This Australian monotreme lays eggs and has a remarkable sense of electroception.	Platypus	Red kangaroo	Dingo	Emu	Platypus	3
1565	Which Australian animal is the largest living carnivorous marsupial on Earth?	The Tasmanian tiger	The Tasmanian devil	The platypus	The red kangaroo	The Tasmanian devil	3
1566	Qantas, Australias largest airline company, has what Australian animal on its red-and-white logo?	Koala	Kangaroo	Emu	Tasmanian devil	Kangaroo	3
1567	What is the difference between the male and the female Galah, a cockatoo bird native to Australia?	There is no difference between them.	Males and females have different eye colour.	Galah males are crested.	Galah females have shorter tails.	Males and females have different eye colour.	3
1568	What is the average weight of the Tasmanian Pygmy Possum?	About 250g	About 50g	About 100g	About 7g	About 7g	3
1569	Which lizard can squirt blood from the corners of its eyes in order to confuse and drive back its enemies?	Anole	Gila monster	Horned lizard	Komodo dragon	Horned lizard	3
1570	The venomous lizard Gila monster was named after what?	The Gila River basin	The Gila Expedition 1857	Alberto Gilardino	Gilligans Island	The Gila River basin	3
1571	The Komodo dragon, the largest living lizard on Earth, lives in which part of the world?	North America	Indonesia	South-western China	Madagascar	Indonesia	3
1572	Which term refers to the self-defense mechanism which allows lizards to break off their tails when captured?	Apotemnophilia	Autonomy	Autotomy	Autism	Autotomy	3
1573	Which of these statements about geckos is true?	Geckos have toe pads which help them climb smooth vertical surfaces.	All of these	Geckos can make chirping sounds.	Geckos feed on insects.	All of these	3
1574	Chameleons are lizards that can change their colour. What does Chameleon mean in Greek?	Green melon	Karma lion	Colourful	Earth lion	Earth lion	3
1575	Geckos have immovable eyelids and cant blink. How do they keep their eyes clean?	A tiny insect lives under their eyelids and cleans their eyes.	They lick their own eyes.	They dip their eyes in water.	They cover their eyes with their toes.	They lick their own eyes.	3
1576	The lizards which do not have legs are commonly known by what name?	Glass lizards	Monitor lizards	Skinks	Iguanas	Glass lizards	3
1577	Which of these lizard species is not endangered?	Eastern Bearded Dragon	Blunt-nosed Leopard Lizard	Mona Ground Iguana	Komodo Dragon	Eastern Bearded Dragon	3
1578	No lizard species live on which continent?	South America	Antarctica	Europe	Asia	Antarctica	3
1579	This shark is considered a filter- feeder. Its diet consists mainly of plankton, krill, and macro-algae.	whale shark	bull shark	great white shark	pygmy shark	whale shark	3
1580	This sharks white belly and grey back make it difficult for prey to spot.	hammerhead shark	tiger shark	great white shark	whale shark	great white shark	3
1581	Which of these sharks has a flat body like a stingray?	basking shark	blue shark	blacktip reef shark	angel shark	angel shark	3
1582	This shark was believed to be extinct, until it was found on the coast of Japan in 1898.	cookie cutter shark	mako shark	goblin shark	angel shark	goblin shark	3
1583	Which shark is the fastest swimmer?	goblin shark	mako shark	nurse shark	sandtiger shark	mako shark	3
1584	What is the common name for baby sharks?	calves	pecks	cubs	pups	pups	3
1585	How many recognized giraffe subspecies exist?	6	7	9	5	9	3
1586	Which of these is not a subspecies of giraffe?	Somali Giraffe	Rothschilds Giraffe	Kordofan Giraffe	East African Giraffe	East African Giraffe	3
1587	How long is a giraffes gestation period?	18 - 20 months	10 months	14- 15 months	9 months	14- 15 months	3
1588	How many pounds of leaves can a giraffe consume daily?	60 pounds	100 pounds	140 pounds	210 pounds	140 pounds	3
1589	What group of dogs does the beagle belong to?	retrievers	setters	hound	terriers	hound	3
1590	The beagle was developed mainly for tracking what animal?	squirrels	rabbits	raccoons	coyotes	rabbits	3
1591	About how many years have beagles been around?	2,000	5,000	4,000	3,000	2,000	3
1592	Which of the following cartoon dogs was a beagle?	Courage	Scooby Doo	Snoopy	Clifford	Snoopy	3
1593	What is the typical lifespan of the beagle?	20 years	15 years	7 years	12 years	12 years	3
1594	What type of coat do beagles have?	long	short	medium	depends on the dog	medium	3
1595	The puggle is a mix between a beagle and what dog?	papillion	puli	poodle	pug	pug	3
1596	In what country was the goldfish first domesticated?	Egypt	China	Japan	India	China	3
1597	How long can a goldfish live in optimal conditions?	5 years	8 years	10 years	20 years	20 years	3
1598	In Europe goldfish were first introduced to what country?	France	England	Italy	Portugal	Portugal	3
1599	What color goldfish were most prized by the Chinese royalty several centuries ago?	Silver	Yellow	Orange	Red	Yellow	3
1600	What color are wild goldfish?	Silver	Orange	Yellow	Green	Green	3
1601	This bird is the fastest animal on the planet in its hunting method, the stoop.	Bald Eagle	Red-tailed Hawk	Peregrine Falcon	Golden Eagle	Peregrine Falcon	3
1602	These raptors are known for their unusually social behavior. They even hunt in groups while the majority of raptors are solitary hunters.	Golden Eagle	Turkey Vulture	Spotted Owl	Harris Hawk	Harris Hawk	3
1603	This animal is the largest of the deer family and can be found in the northern parts of North America.	Gazelle	Moose	White Tailed Deer	Elk	Moose	3
1604	Which of these animals cannot be found in North America?	Flamingo	Walrus	Dingo	Beaver	Dingo	3
1605	This bear, also known as a Silvertip bear, is native to North America.	Panda Bear	Polar Bear	Red Panda Bear	Grizzly Bear	Grizzly Bear	3
1606	The coyote lives in North America and also goes by this name.	Desert Dog	Prairie Wolf	Prairie Dog	Small Wolf	Prairie Wolf	3
1607	This North American animal is at the top of the food chain in the arctic region.	Walrus	Polar Bear	Arctic Fox	Penguin	Polar Bear	3
1608	This mammal is known for its black fur with a white stripe and for its apparent odor.	Sloth	Ferret	Skunk	Weasel	Skunk	3
1609	What type of animal is the cottonmouth?	Mouse	Snake	Bat	Lizard	Snake	3
1610	This creature belongs to the rodent family and is covered in sharp spines or quills.	Nutria	Armadillo	Kiwi	Porcupine	Porcupine	3
1611	How many species of skunk exist?	6	8	13	11	11	3
1613	What do skunks eat in the wild?	All of these	Insects	Meat	Fruit	All of these	3
1614	How much of an effective range do skunks odor glands have?	15 feet	10 feet	8 feet	20 feet	15 feet	3
1615	How many subspecies of Red Fox are found in India?	2	None. Red Fox are not native to India.	1	3	3	3
1616	Which of these coat colors is not found in wild Red Fox populations?	Golden	Spotted	Red	Black	Black	3
1617	What is the top speed that the Red Fox can reach?	25 mph	35 mph	45 mph	55 mph	45 mph	3
1618	Which of these are eaten by the Red Fox?	Insects	worms	All of these	eggs	All of these	3
1619	How long is the Red Foxs lifespan in the wild?	3 years	8 years	6 years	10 years	3 years	3
1620	Approximately how long is a Red Foxs gestation period?	89 days	55 days	40 days	34 days	55 days	3
1621	What is an adult male rooster known as?	Rooster	Buck	Hen	Foul	Rooster	3
1622	What is the word used for someone that is afraid of chickens?	Xenophobic	Chickopobic	Alektorphobic	Avianphobic	Alektorphobic	3
1623	Which of the following is not a breed of chicken?	Australorp	Cubalaya	Houdan	Chinese Crested	Chinese Crested	3
1624	How many beats per minute does a chickens heart usually beat?	100-234	147-189	280-315	95-124	280-315	3
1625	Which of the following color of egg is incorrect for a chicken egg?	black	white	pink	blue	black	3
1626	All domestic chickens can be traced back to which bird?	The Wild Turkey	The Macaw	The Red Jungle Fowl	The Amazon Rain Forest Chicken	The Red Jungle Fowl	3
1627	Which of the following characters is a chicken?	Dori	Foghorn Leghorn	Daffy	Kermit	Foghorn Leghorn	3
1628	What is the average lifespan of a lion in the wild?	6-9 years	20-24 years	10-14 years	15-20 years	10-14 years	3
1629	Most lions only survive in Africa. But a population of the much endangered Asiatic lion lives in India. How many estimated lions live in India as of 2007?	300	550	1,500	3,000	300	3
1630	What is the average maximal speed a lion can reach?	35 mph / 56 km/h	45 mph / 72 km/h	20 mph / 32 km/h	40 mph / 64 km/h	35 mph / 56 km/h	3
1631	Approximately what amount of meat does an adult male lion�s diet require per day?	10 lbs. (4.5 kg)	5 lbs. (2.2 kg)	15 lbs. (6.8 kg)	25 lbs. (11 kg)	15 lbs. (6.8 kg)	3
1632	Approximately how long is a lions gestation period?	200 days	30 days	120 days	60 days	120 days	3
1633	How many species of penguins live in warm or even tropical environments?	0	3	2	4	4	3
1634	Which of these is the largest species of penguins?	King Penguin	Giant Penguin	Emperor Penguin	Royal Penguin	Emperor Penguin	3
1635	What does the word penguin mean?	Fat	Black and White	Swimmer	Bird	Fat	3
1636	Which of these animals is NOT a natural predator of penguins?	Leopard Seal	Polar Bear	Stellars Sea Eagle	Orca (Killer Whale)	Polar Bear	3
1637	Where can the polar bear be found?	South Pole	Antartica	Arctic	All of these	Arctic	3
1638	What color is a polar bears skin?	Black	White	Pink	Yellow	Black	3
1639	Approximately how many wild polar bears are estimated to live across the Arctic?	20,000	100,000	150,000	60,000	20,000	3
1640	According to Guinness Book of World Records, the heaviest wild bear was caught in 1960 and weighed 1,960 lbs (890 kg). What was its length?	Over 11 feet (3,40 m) tall	Over 12 feet (3,70 m) tall	Over 9 feet (2,70 m) tall	Over 10 feet (3 m) tall	Over 11 feet (3,40 m) tall	3
1641	A polar bear is used as the marketing icon for which of these popular products?	Maytag Freezers	Hoods Ice Cream	Popsicles	Klondike Bars	Klondike Bars	3
1642	The Labrador Retriever is considered a medium-sized dog. How much does it weigh when fully grown?	65 - 110 pounds	40 - 55 pounds	55 - 80 pounds	20 - 60 pounds	55 - 80 pounds	3
1643	What is the estimated average lifespan of a crocodile?	80+ years	50+ years	90+ years	70+ years	70+ years	3
1644	On which of these continents can you find the Salt Water Crocodile?	Africa	South America	Australia	North America	Australia	3
1645	A crocodile bite strength is up to how many pounds psi (per square inch)?	3000 psi	5000 psi	700 psi	1500 psi	3000 psi	3
1646	Which of these is NOT a species of crocodile?	Nile Crocodile	Mugger Crocodile	American Crocodile	African Crocodile	African Crocodile	3
1647	What is the average incubation period of crocodile eggs?	50 days	80 days	120 days	25 days	80 days	3
1648	Beavers are the second largest rodents in the world after which animal?	Muskrat	Mountain Marmot	Capybara	Sea Otter	Capybara	3
1649	The North American Beaver is Canadas National symbol that adorns which Canadian coin?	Penny	Nickle	Quarter	Dime	Nickle	3
1650	What is the gestation period of a beaver?	2 months	3 months	6 months	4 months	4 months	3
1651	Butterflies need the warmth of the sun in order to fly. They cannot possibly fly if the temperature is below this.	60 F (16 C)	80 F (27 C)	70 F (21 C)	50 F (10 C)	50 F (10 C)	3
1652	Butterflies taste their food through this organ.	The wings	Their faceted eyes	The proboscis	The legs	The legs	3
1653	Butterflies do not have lungs. They breathe trough this organ.	The proboscis	The abdomen	The eyes	The legs	The abdomen	3
1654	This is what mostly attracts a butterfly to a flower.	The flowers nectar	The flowers color	The flowers shape	The flowers smell	The flowers nectar	3
1655	The expression social butterfly is often used to describe a woman. It means that she does this.	Uses too much cosmetics	Behaves quite self-conceited	Flits from one person to another	Wears clothes with bright colors	Flits from one person to another	3
1656	Finish this old phrase:	en you call a dog, he comes right over to you. When you call a cat, she________________.	takes a message	climbs the curtains	runs away from you		3
1657	Why does your cat interrupt you and want petting when youre on the phone?	your cat thinks you are talking to him/ her	to annoy you	to be a part of your telephone call	your cats is jealous that youre talking to someone else	your cat thinks you are talking to him/ her	3
1658	Why do cats seem to be attracted to the one person who doesnt like cats?	Kitty wants to annoy them	Kitty thinks that person has food	Kitty wants to win them over	Kitty sees that person as unintimidating	Kitty sees that person as unintimidating	3
1659	Why do cats suddenly race through the house?	They feel a change in the weather.	They have an overflow of pent-up energy.	They want to get your attention.	They feel the presence of a ghost.	They have an overflow of pent-up energy.	3
1660	Why does a cat rub against your leg?	Because she/ he really likes you.	Because it feels good.	To mark you by depositing his/ her scent	To show he/ she trusts you	To mark you by depositing his/ her scent	3
1751	How many species of pigeons and doves exist?	200	375	300	250	300	3
1661	Why does a cat bury his/ her waste?	To show their dominance	To protect their trail from predators	Because they are so territorial.	Because they are very clean animals.	To protect their trail from predators	3
1662	Why do cats always want in when they are out, and out when thery are in?	To re-mark their scent	To annoy you	Because they have pent-up energy	Because they are bored	To re-mark their scent	3
1663	Why do cats like to sleep in the sun?	To make up for the drop in body temperature when they sleep	To keep from shedding so much	It reminds them of being kittens	Because they can hear better when they are warm	To make up for the drop in body temperature when they sleep	3
1664	Why do cats go crazy over catnip?	Because it smells like a cat in heat	Because it smells like prey	Because it smells like tasty food	Because it is an aphrodisiac	Because it smells like a cat in heat	3
1665	How many known species of earthworm exist worldwide?	3,000	2,500	5,500	1,000	5,500	3
1666	How many hearts does a typical earthworm have?	2	10	4	8	10	3
1667	How many species of earthworm are native to Australia?	650	450	250	850	650	3
1668	How many million of earthworms were exported from Canada and sold worldwide in 1980?	225 million	260 million	370 million	100 million	370 million	3
1669	To which animal class do octopuses belong?	Mollusk	Coleoid	Nautiloid	Cephalopod	Cephalopod	3
1670	Which of the following animals is the least related to the octopus?	Scallop	Snail	Eel	Clam	Eel	3
1671	How many arms do octopuses have?	8	5	0	2	8	3
1672	Approximately how tall is a grizzly bear when standing on its hind legs?	9 feet (2.7 m)	7 feet (2.1 m)	6 feet (1.8 m)	8 feet (2.4 m)	8 feet (2.4 m)	3
1673	In which country is the grizzly bear listed as a threatened species?	U.S.	Germany	Canada	Sweden	U.S.	3
1674	Although the grizzly bear is on the flag of this state, the last grizzly was shot there in 1922.	Nevada	California	Oregon	Idaho	California	3
1675	Which of these do grizzly bears eat?	Moose	Berries	Fish	All of these	All of these	3
1676	How many fatal brown and grizzly bear attacks have been reported between 1900 and 2003 in North America?	175	53	542	257	53	3
1677	Which of these things is something you should never feed your dog?	Coconuts	Chocolate	Milk	Raw meat	Chocolate	3
1678	Which of these is only a dog food brand?	Eukanuba	Cesar	Iams	Purina	Cesar	3
1679	A dog should never be left with a child under this age because the child may injure the dog or him/herself.	ten	seven	three	five	five	3
1680	What were the dodos closest living relatives in nature?	Chickens	Pigeons	Parrots	Turkeys	Pigeons	3
1681	In what year was the dodo discovered?	1627	1605	1681	1598	1598	3
1682	In what year did the dodo become extinct?	1705	1789	1681	1803	1681	3
1683	The does �cheetah� mean translated from Sanskrit?	Fast	Spotted One	Lightning	Stealth cat	Spotted One	3
1684	What are cheetahs that have mutated patterning that creates blotches instead of spots called?	King Cheetahs	Smudge Cheetahs	Black Cheetahs	Striped Cheetahs	King Cheetahs	3
1685	Which of these is not a sound made by cheetahs?	Hiss	Yelp	Roar	Purr	Roar	3
1686	The ruler of the Mughal Empire Akbar the Great was very enamored with cheetahs and it is said he kept a stable of how many of these cats?	5,000	750	1,000	500	1,000	3
1687	What is the typical lifespan of the cheetah?	25-40 years	15-25 years	5-10 years	10-20 years	10-20 years	3
1688	In 2007 the amount of cheetahs left in the wild dropped to what number?	12,000	20,000	30,000	5,000	12,000	3
1689	What frog is the most poisonous?	Cane Toad	Dart Frog	Corroboree Frog	Red-Eyed tree frog	Dart Frog	3
1690	Which of these types of frogs shares its name with an animal that is not a frog?	horned frog	leopard frog	tree frog	arrow frog	horned frog	3
1691	What is the smallest frog?	Red-Eyed Tree frog	Brazilian Gold Frog	Cane Toad	Monte Iberia Eleuth	Brazilian Gold Frog	3
1692	How many species of zebra are known to exist?	6	4	3	5	4	3
1693	Which one of these is not a species of zebra?	Savanna Zebra	Cape Mountain Zebra	Grevys Zebra	Plains Zebra	Savanna Zebra	3
1694	How tall is a typical zebra at the shoulder?	4 feet (1.2 m)	6 feet (1.8 m)	5 1/2 feet (1.6 m)	3 feet (0.9 m)	4 feet (1.2 m)	3
1695	How fast can a zebra run?	30 mph (50 km/h)	25 mph (40 km/h)	50 mph (80 km/h)	40 mph (65 km/h)	40 mph (65 km/h)	3
1696	Which of these are not a function of a zebras stripes?	A warning sign to other zebras	Identification within the herd	Heat dissipation	Confusion of predators	A warning sign to other zebras	3
1697	How long can a zebra live in captivity?	30 years	20 years	40 years	15 years	40 years	3
1698	This type of ant causes a lot of allergic reactions in the USA.	Jack Jumper  ant	Bulldog ant	Western brown ant	Fire ant	Fire ant	3
1699	This type of ant is considered the most venomous of all insects.	Western brown ant	Bulldog ant	Jack jumper ant	Fire ant	Jack jumper ant	3
1700	About how long have ants been around on Earth?	8 million years	45 milllion years	60 million years	25 million years	60 million years	3
1701	The largest ant colony is located on the Ishikari coast of Hokkaido. Approximately how many ants are there in this colony?	300,000,000	30,000,000	700,000,000	1,500,000	300,000,000	3
1702	What are the three basic parts of an ants body?	Antennae, abdomen, thoraces	Head, mesosoma, metasoma	Head, abdomen, metasoma	Head, thorax, somatomy	Head, mesosoma, metasoma	3
1703	All of these substances but one are a safe way to get rid of ants in the house. Which is the odd one?	Cider vinegar	Windex mixed with ivory soap	Wine	Whole cloves	Wine	3
1704	What do we call the type of ants that plant seeds to grow food?	Formicadae	Thresher ants	Farmer ants	Harvester ants	Harvester ants	3
1705	What is special about the red ants of the Southwestern USA and Central and South America?	They can live in temperatures from 11 degrees Centigrade to 51 degrees Centigrade.	They can live for six days without food or water.	They can change color.	They steal larvae for slaves.	They steal larvae for slaves.	3
1706	In 1966 was found the first ant fossil. From which geological period did it come from?	Cretaceous	Pennsylvannian	Pre-Fermaceous	Jurasic	Cretaceous	3
1707	Which statement about ants is untrue?	Anteaters prefer ants to any other type of food.	An ant colony will eat its own larvae if there is no other food around.	Bullet ants are considered to have the most painful sting.	Ants are sometimes put into Thai salads.	Anteaters prefer ants to any other type of food.	3
2282	Which cartoon dog is one of Mickey Mouses best friends?	Happy	Minnie	Doggie	Goofy	Goofy	3
1708	Warner Brothers highest grossing film of 1954 was about enormous ants that threatened a small town in the USA. What was the title of this movie?	Ants!	Them!	Invasion	Invaders	Them!	3
1709	How many species of flamingo are native to the Americas?	3	2	1	4	4	3
1710	What do you call a group of flamingos?	Family	Pink	Flock	Pat	Pat	3
1711	Which of these flamingo species is not native to the Americas?	Chilean Flamingo	Andean Flamingo	Lesser Flamingo	James Flamingo	Lesser Flamingo	3
1712	What decade did the pop culture icon the plastic lawn flamingo come into existence?	40s	60s	30s	80s	60s	3
1713	When was the last reported killing of a Thylacine in Australia?	1930	1880	1900	1910	1930	3
1714	What was the name of the zoo in which the last known Thylacine was placed in 1936?	Hobart Zoo	Queensland Zoo	Queen Elizabeth Zoological Gardens	Australia Zoo	Hobart Zoo	3
1715	Why were Thylacines called Tigers?	because of the vicious way in which they killed their prey	because they looked like cats	because of their mean disposition	because of the stripes on their back	because of the stripes on their back	3
1716	What was the fine for shooting a Thylacine?	$10,000	$1,000	$3,000	$5,000	$5,000	3
1717	In what year were Thylacines classified as extinct?	1986	1979	1974	1965	1986	3
1718	In 1984 what famous mogul offered a $100,000 reward for proof of the continued existence of Thylacines?	Donald Trump	Rupert Murdock	Ted Turner	Bill Gates	Ted Turner	3
1719	What is a pangolin?	A scaly ant-eating mammal	A poisonous snake	A type of fish	A type of waterfowl	A scaly ant-eating mammal	3
1720	What does the Malaysian word pangolin mean?	Armor	Roll into a ball	Walking Pinecone	Scaly Anteater	Roll into a ball	3
1721	Which of these statements concerning the way in which pangolins defend themselves is false?	They run away very quickly.	They spray a noxious odor like a skunk.	They curl up in a ball.	They attack by slashing their long claws or whipping their tails.	They run away very quickly.	3
1722	How many young pangolins can an adult pangolin have at one time?	1-2	3-4	4-5	2-3	1-2	3
1723	Although not all bear subspecies are vicious, there is a tendency for increase in bear attacks due to this factor.	Destruction of bears natural habitat	Pollution	Genetical mutation of bears	Hunting	Destruction of bears natural habitat	3
1724	Despite sharks� bad reputation thanks to movies out of 300 species of sharks only this much are known to have attacked and killed a man.	4	10	2	11	4	3
1725	Although jellyfish may seem to you calm and harmless, an encounter with some species may leave you in excruciating pain and even kill you in minutes. Which of the following species of jellyfish is venomous enough to kill a man?	Sea nettle	Mastigias	Box jellyfish	Medusa Jellyfish	Box jellyfish	3
1726	We�ve seen these animals as friendly and approachable but the truth is that they�re unpredictable. What is the average number of fatalities a year elephants cause?	150-200	20-40	300-500	1000-1500	300-500	3
1727	Hippopotamuses may seem slow, lazy and bulky but in fact are one of the most dangerous African animals. Which of the following should you avoid in order to prevent a hippopotamus attack?	Standing between the hippopotamus and its calf	All of these	Surprising the hippopotamus	Blocking the hippopotamus� way	All of these	3
1728	Crocodiles like to stay motionless in water and wait for the perfect time to strike. These powerful prehistoric creatures annually give what estimated number of fatalities?	1000-1500	50-100	100-200	600-800	600-800	3
1729	If you happen to be near a big cat (e.g. lion, tiger, lynx) that seems to be about to attack you, which of the following shouldn�t you do in any case?	Scream and shout	Try to look larger than you really are	Turn back and run	Stare at its eyes	Turn back and run	3
1730	Although only a small percent of scorpions are venomous to people, 800 to 2000 human deaths each year are caused by scorpions. During which part of the day are these creatures most active?	Morning	All day	Noon	Night	Night	3
1731	Which of the following statements about snakes is not true?	Snakes can strike upto half their length.	A fully grown king cobra can rear up so it looks a human in the eyes.	Not all venomous snakes are capable of killing a man.	Snakes will attack almost always they sense the presence of a human.	Snakes will attack almost always they sense the presence of a human.	3
1732	Surprisingly, the number one killer among animals with about 2-3 million human fatalities a year is a tiny insect. Which is it?	Bee	Mosquito	Tsetse fly	Wasp	Mosquito	3
1733	How many species of rhinoceros survive in the wild?	2	5	4	3	5	3
1734	Which of these is NOT a species of rhinoceros?	African Rhino	Indian Rhino	Javan Rhino	Sumatran Rhino	African Rhino	3
1735	Throughout the period from the 1970s to the end of the 20th century, the rhinoceros numbers declined by approximately what percentage?	50%	90%	60%	75%	90%	3
1736	What is the life span of a rhino?	15 years	40 years	20 years	30 years	40 years	3
1737	What is the gestation period of a rhino?	12 months	16 months	20 months	24 months	16 months	3
1738	What is the #1 reason for the rhinos decline worldwide?	Disease	Farming	Predators	Poaching	Poaching	3
1739	Hyenas are most closely related to what creatures?	Badger	Bears	Cats	Mongoose	Mongoose	3
1740	In which of these African environments are hyenas NOT found?	Desert	Forests	Mountains	Grasslands	Desert	3
1741	Which of these is not a species of hyena?	Brown	Striped	Golden	Spotted	Golden	3
1742	What is a group of hyenas called?	Pack	Posse	Giggle	Clan	Clan	3
1743	What country was home to the Moa?	New Zealand	Puerto Rico	Indonesia	Madagascar	New Zealand	3
1744	How many species of Moa are known to have existed?	3-5	5-7	10-13	11-15	11-15	3
1745	What was the main reason for the extinction of the Moa?	It was hunted by man for food.	There was not enough room on the island for so many large birds	It could easily be caught by predators.	It got to large to support itself.	It was hunted by man for food.	3
1746	What animal was the number one predator of the Moa?	They had no predator they were too large	An extinct species of eagle	An extinct species of lion	An extinct species of wolf	An extinct species of eagle	3
1747	In what year were the first Moa remains discovered by Europeans?	1765	1857	1839	1724	1839	3
1748	Which of these European countries is not home to any wild native reindeer?	Finland	Switzerland	Russia	Scotland	Switzerland	3
1749	Approximately how many miles per year can the North American caribou travel?	11,000	1,000	3,000	7,000	3,000	3
1750	Approximately how many reindeer live in Eurasia?	10 million	5 million	15 million	1 million	5 million	3
1752	Why are pigeon nests or eggs rarely seen?	Pigeons are cliff dwellers and build their nests in high places.	Pigeons do their best to conceal nests.	Pigeons are picky and only build nests high up in certain types of trees.	Pigeons dont build nests.	Pigeons are cliff dwellers and build their nests in high places.	3
1753	What is the common name for the pigeon that we see in the city streets and in our backyards?	Mourning Dove	Rock Dove	Common Dove	Fancy Dove	Rock Dove	3
1754	Dinosaurs lived during which geologic era?	Cretazoic	Protozoic	Holozoic	Mesozoic	Mesozoic	3
1755	The word dinosaur is a combination of two Greek words. One word  means lizard. What does the other word mean?	Terrifying	Herbivorous	Godlike	Beautiful	Terrifying	3
1756	Name the theropod dinosaur with a long head, flat snout, and large sickle-shaped claw on the second toe of each foot.	Stegosaurus	Velociraptor	Tyrannosaur	Raptor	Velociraptor	3
1757	Name the prehistoric reptile of the late Jurassic and Cretaceous period with featherless wing membrane.  It is believed this reptile flew.	Bronchialsaurus	Accipitridae Raptor	dactylic raptor	Pterodactyl	Pterodactyl	3
1758	The name brontosaurus is derived from the Greek words sauros, which means lizard, combined with another word. What does the word bronte mean?	Large	Long neck	Poetic	Thunder or roar	Thunder or roar	3
1759	Which of these dinosaurs had dorsal plates and spikes?	Heloderma  suspectum	H. horridum	Hydrodamalis gigans	Stegosaurus	Stegosaurus	3
1760	According to history/science/geology, dinosaurs became extinct approximately how many years ago?	10 million	25 million	80 million	65 million	65 million	3
1761	This reptile, endemic to new Zealand, is the only surviving rhynchocephalian.	Perisssodactyl	None of these	Kephalosaurus	Tuatara	Tuatara	3
1762	Which one of these movies tells the story of Littlefoot, an Apatosaurus in search of the Great Valley where dinosaurs can live in peace?	Walking With Dinosaurs	Jurassic Park	King Kong	The Land Before Time	The Land Before Time	3
1763	Which of these books about prehistoric animals and dinosaurs was written by Arthur Conan Doyle?	Dinosaur Planet	Jurassic Park	Dinotopia	The Lost World	The Lost World	3
1764	In the 1980s, who voiced the character of Dino, the pet dinosaur in the animated series The Flintstones?	Frank Welker	Mel Blanc	Jean Vander Pyl	Alan Reed	Mel Blanc	3
1765	In the book Jurassic Park, the fictional island Isla Nublar, where recreated dinosaur species live, is situated in which part of the world?	Near Costa Rica	Near Japan	Near Chile	Near Spain	Near Costa Rica	3
1766	The BBC series Walking with Dinosaurs, which won three Emmy Awards, consisted of how many parts?	12	3	6	2	6	3
1767	The design of the Japanese fictional monster Godzilla was based on the characteristics of which dinosaur?	Stegosaurus	All of these	Tyrannosaurus	Iguanodon	All of these	3
1768	In the cartoon Dinosaucers, Bronto Thunder is what kind of dinosaur?	An evolved Apatosaurus	An evolved Stegosaurus	An evolved Archaeopteryx	An evolved Triceratops	An evolved Apatosaurus	3
1769	What is Dinotopia, the fictional place where humans and dinosaurs live together in James Gurneys books and Hallmarks mini series?	A planet	A hidden island	A mountain	A large volcano	A hidden island	3
1770	Which band recorded a song called Brontosaurus which includes the following verse:	w her daddys getting old	d he seemed to lose control	en the brontosaurus	ormed into the house to trap her.?		3
1771	What kind of celestial body is the 9949 Brontosaurus?	Asteroid	Planet	Star	Black hole	Asteroid	3
1772	What is the meaning of the term Triceratops, referring to a dinosaur genus discovered in 1888 in North America?	Three heads	Beast with three tails	Three-tongued beast	Three horns on the face	Three horns on the face	3
1773	Which one of these dinosaurs was bigger than a dog?	Saltopus	Parvicursor	Microraptor	Triceratops	Triceratops	3
1774	In the scientific classification of animals, what does the term Dinosauria signify?	A family	A superorder	A genus	A kingdom	A superorder	3
1775	Fossils of a Velociraptor attacking a Protoceratops, proving that dinosaurs attacked and ate each other, were discovered in which part of the world in 1971?	Death Valley	The Gobi Desert	The Balkans	Bernissart, Belgium	The Gobi Desert	3
1776	Which one of these dinosaurs was carnivorous?	Eoraptor	Diplodocus	Maiasaura	Triceratops	Eoraptor	3
1777	Which one of these dinosaurs was herbivorous?	Velociraptor	Protoceratops	Tyrannosaurus	Allosaurus	Protoceratops	3
1778	How many fingers did the Tyrannosaurus rex have on its forelimbs?	4	3	5	2	2	3
1779	The first evidence of herding behaviour among dinosaurs was discovered in 1878 in which part of the world?	USA	Argentina	Belgium	China	Belgium	3
1780	Which one of these statements about the Seismosaurus, the Earth-shaking lizard, is wrong?	It could reach 33 meters in length.	It was recognized as a species in 1991.	Its hind legs were shorter than its front legs.	It was herbivorous.	Its hind legs were shorter than its front legs.	3
1781	How long is the average lifespan of an elephant?	70 years	15 years	110 years	35 years	70 years	3
1782	Until what age can the female elephant (called a cow) produce offspring?	50 years	15 years	75 years	7 years	50 years	3
1783	Elephants express joy by spinning in circles, trumpeting, roaring, screaming, urinating, and flapping their ears. In which of these cases will an elephant not act this way?	when meeting a friend (elephant or human)	when playing games	after the death of an elderly elephant	after the birth of a new baby elephant	after the death of an elderly elephant	3
1784	How many species of elephant exist today?	1	6	5	3	3	3
1785	How many individual muscles are in an elephants trunk?	2,000	10,000	40,000	500	40,000	3
1786	Elephants intertwine their trunks with the trunks of other elephants, much like a handshake. What does an elephant not do with its trunk?	caress a baby elephant	drink through it like through a straw	place food in their mouth	grab enemies and fling them away	drink through it like through a straw	3
1787	Elephants spend 16 hours a day collecting and eating food, an average of 400 lbs of food a day. But their bodies do not digest 100% of the food. How much of the food does the elephants body digest?	40%	80%	60%	20%	40%	3
1788	It has been reported that in the period 1992-2008, Ringling Bros. and Barnum  Bailey Circus had at least this many elephant deaths caused by abuse and neglect.	24	0	1	7	24	3
1789	Through what body part can an elephant NOT hear?	feet	skin	trunk	ears	skin	3
2002	What type of food do Tasmanian devils prefer in the wild?	Sheep	Carrion	Insects	Fish	Carrion	3
1790	In Islamic history, 570 A.D. was The Year of the Elephant. Which of these happened in that year?	The Qur�an was written in book form	Muhammad received his first revelation	Muhammad was born	Muhammad became ill and died	Muhammad was born	3
1791	Which is true about elephants?	The elephant is a good jumper.	The elephant is not a protected species.	An elephants skin is 2.5 inches thick.	The elephant is a good swimmer.	The elephant is a good swimmer.	3
1792	What is the only marsupial in the world that has a backwards pouch?	kangaroo	echidna	koala	wombat	wombat	3
1793	This reef, that extends along the east coast of Australia, is home to countless animals and is considered one of the wonders of the natural world.	Great Barrier Reef	Division Reef	Australia Reef	Surfer Reef	Great Barrier Reef	3
1794	The female of this species is sometimes called a Blue Flyer, because of its bluish coloration.	white heron	emu	red kangaroo	kookaburra	red kangaroo	3
1795	Which one of these is NOT a type of wombat?	Common	Southern Hairy Nosed	Arid Central	Northern Hairy Nosed	Arid Central	3
1796	The echidnas diet consists mainly of this group of animals.	Mammals	Insects	Fish	Birds	Insects	3
1797	Where does the kookaburra, a common Australian bird, get its name from?	The food it eats	The aboriginal name for it	Its appearance	The sound it makes	The aboriginal name for it	3
1798	Which of these animals is NOT native to Australia?	Frilled-neck lizard	Kangaroo	Dingo	Bilby	Dingo	3
1799	What does the word Triceratops mean?	Three Big Horns	Big Horned Beast	Three Horned Head	Three Horned Face	Three Horned Face	3
1800	How much is Triceratops thought to have weighed?	Between 13,000 and 26,000 lbs	Between 1,000 and 9,000 lbs	Between 50,000 and 75,000 lbs	Between 110,000 and 140,000 lbs	Between 13,000 and 26,000 lbs	3
1801	In what year was Triceratops first discovered?	1894	1888	1885	1906	1888	3
1802	Triceratops is the official State Dinosaur of which state?	Utah	Oregon	Wyoming	Nevada	Wyoming	3
1803	It is thought that Triceratops was able to run how fast?	40 mph	15 mph	20 mph	30 mph	15 mph	3
1804	What does the word �mantis� mean?	Savage insect	Killer or hunter	Prophet or fortuneteller	Leaflike	Prophet or fortuneteller	3
1805	In what year was the Praying mantis placed on the Endangered Species List?	1972	1970	1974	1976	1976	3
1806	What is the meaning of the name Stegosaurus?	Tank Lizard	Roof Lizard	Spike Lizard	Spike Tail	Roof Lizard	3
1807	How many bony plates did a Stegosaurus have embedded on its back?	11	17	9	15	17	3
1808	What was the length of an average Stegosaurus?	20-28 feet (6-8.5 m)	30-40 feet (9.2-12.2 m)	26-30 feet (8-9.2 m)	34-38 feet (10.4-11.5 m)	26-30 feet (8-9.2 m)	3
1809	What was the average weight of a Stegosaurus?	8,000 lbs. (3.6 tonnes)	6,000 lbs. (2.7 tonnes)	6,800 lbs. (3 tonnes)	7,400 lbs. (3.3 tonnes)	6,800 lbs. (3 tonnes)	3
1810	What was the average height of a stegosaurus?	9 feet (2.7 m)	8 feet (2.4 m)	10 feet (3 m)	12 feet (12.6 m)	9 feet (2.7 m)	3
1812	How many cubs are usually in a tigers litter?	1-6 cubs	3-4 cubs	1-2 cubs	2-4 cubs	3-4 cubs	3
1813	How long is the gestation period of a tiger?	16 weeks	22 weeks	10 weeks	14 weeks	16 weeks	3
1814	How many living species of bears are there?	4	10	6	8	8	3
1815	Which country does the Clydesdale horse originate from?	Scotland	Ireland	Spain	England	Scotland	3
1816	What famous beer brand uses the Clydesdale horse as its mascot?	Anheuser-Busch	Fosters	Upland	Heineken	Anheuser-Busch	3
1817	What year was the Clydesdale Horse Society formally founded?	1925	1901	1887	1885	1887	3
1818	What class of horse breed does the Clydesdale horse belong to?	Draft Horse	Carriage Horse	Farm Horse	Saddle Horse	Draft Horse	3
1819	What year was the Clydesdale horse introduced to North America?	1636	1715	1525	1800	1715	3
1820	How long does a Clydesdale horse�s pregnancy last?	9 months	24 Months	15 Months	11 Months	11 Months	3
1821	This dog breed, which originated in Mongolia and China, has very thick fluffy fur and a blue-black tongue.	Chow Chow	Jonangi	Kai Ken	Hokkaido	Chow Chow	3
1822	The representatives of this dog breed are small, have long white silky fur and are also known as Roman Ladies Dogs.	Maltese	Norrbottenspets	Phalene	Mudi	Maltese	3
1823	What common name does the dog breed New Guinea Highland Dog have?	Singer	Prowler	Wrestler	Swimmer	Singer	3
1824	In what color does the Pekingese dog breed come?	Light gold	White	Black	All of these	All of these	3
1825	In what European country did the Rough Collie dog breed originate?	Scotland	Germany	Ireland	France	Scotland	3
1826	What dog breed has an elongated body, very short legs, short shiny coat and a long snout?	Dogo Guatemalteco	Dachshund	English Foxhound	Elo	Dachshund	3
1827	This extremely large and tall German dog breed has a very short shiny coat and strong muscular body with a majestic posture.	German Mastiff	Boarhound	Great Dane	All of these	All of these	3
1828	In which European country did the Dalmatian dog breed originate?	Croatia	Netherlands	Italy	Denmark	Croatia	3
1829	This dog breed, developed in England, has an egg-shaped head, small eyes, and very strong muscular body with smooth short fur and short legs.	Bull Terrier	Cairn Terrier	English Shepherd	Wire Fox Terrier	Bull Terrier	3
1830	What is the literal meaning of the word carnivore which has a Latin origin?	Blood drinker	Animal killer	Meat eater	Monster	Meat eater	3
1831	Which of these statements is true about carnivorous organisms in general?	They feed on vertebrate animals.	All of these	They feed through scavenging.	They feed on invertebrate animals.	All of these	3
1832	What is the meaning of the term apex predator which is related to carnivorous animals?	A predator that has no predators itself.	A very skilled predator that is highly specialized in killing animals.	It is a term for a human being.	An animal which consumes the highest number of animal species.	A predator that has no predators itself.	3
1833	What is the definition of the term hypercarnivore?	It is a synonym for apex carnivore.	A predator that feeds on carnivorous animals.	It is a term that refers to humans.	An animal whose diet consists exclusively of meat.	An animal whose diet consists exclusively of meat.	3
1834	Which of these methods do carnivorous plants use for capturing their prey?	Rapid leaf movements	A sticky mucilage	Vacuum sucking into a bladder	All of these	All of these	3
1835	What does the diet of the Great Blue Heron, found in North and Central America, consist of?	All of these	Birds	Reptiles	Small mammals	All of these	3
2330	What year was named by the United Nations as the Year of the Dolphin?	1985	2007	2000	1999	2007	3
1836	Which of these statements is true about the diet of coyotes?	All of these	60% of their diet consists of mammals.	They eat insects.	They do not eat prairie dogs.	They eat insects.	3
1837	Which of these characteristics is generally associated with carnivorous animals, particularly predators?	Aggressive behavior	Claws	Sharp teeth	All of these	All of these	3
1838	Which of these statements is true about the consumption of plant material by carnivores?	All of these	Carnivores consume feces of herbivores to get nutrients.	Carnivores consume some plant material in order to get minerals, vitamins and fiber.	Carnivores ingest the plant material the need along with their herbivorous prey.	All of these	3
1839	What does the term facultative carnivore mean?	It is a synonym for scavenger.	Animal that has all characteristics of carnivores but is a herbivore.	A carnivore that also consumes plant food.	It is a synonym for omnivore.	A carnivore that also consumes plant food.	3
1840	How many box turtle species are there in North America?	4	1	9	2	4	3
1841	What color eyes do male box turtles commonly have?	blue	green	red	black	red	3
1842	What city is known as the White Squirrel Capital of the World, since it is home to the largest colony of albino squirrels?	Marionville, Missouri	Olney, Illinois	Columbus, Ohio	Kenton, Tennessee	Olney, Illinois	3
1843	Whiteflies generally feed on what?	Fruit	Insects	Leaves	Carrion	Leaves	3
1844	Which of these white foxes populates the polar zone of the Northern Hemisphere?	White Fox	Arctic Fox	All of these	Snow Fox	All of these	3
1845	In what novel one of the main characters is a white whale hunted by a whaling ship?	North Against South	Moby-Dick	Twenty Thousand Leagues Under the Sea	The Purchase of the North Pole	Moby-Dick	3
1846	What type of insect is often referred to as a white ant, although it is not related to the ant species?	A type of small spider	Termite	Head louse	A type of albino wasp	Termite	3
1847	The White Snake is a fairy tale included in the collection of fairy tales by this author.	Andrew Lang	Brothers Grimm	Oscar Wilde	Hans Christian Andersen	Brothers Grimm	3
1848	What is the meaning of the figurative expression a white elephant?	Something that is idolized but that does not exist	An extraordinary person	A pricey and useless possession	A chimera	A pricey and useless possession	3
1849	The representatives of the Old Danish Pointer breed are white, with markings of this other color on their coat.	Grey	Brown	All of these	Black	Brown	3
1850	Which of these dog breeds originated in Hungary?	Pumi	Puli	Mudi	All of these	All of these	3
1851	In what Latin American country did the Chihuahua dog breed originate?	Mexico	Cuba	Guatemala	Nicaragua	Mexico	3
1852	To what group of dog breeds does the Beagle dog breed belong?	Terrier group	Toy group	Herding group	Hound group	Hound group	3
1853	In what country did the American Akita dog breed originate?	Canada	Japan	China	United States	Japan	3
1854	This dog breed, considered one of the first sighthound dog breeds, has very long fur and is quite tall, with long legs and ears.	Canadian Pointer	Bolognese	Afghan Hound	Airedale Terrier	Afghan Hound	3
1855	In what northern country did the Siberian Husky dog breed originate?	Norway	Finland	Russia	Alaska, USA	Russia	3
1856	The Papillon is a small dog breed of the Toy group. What does the word Papillon mean in French?	Butterfly	Cherry	Flower	Angel	Butterfly	3
1857	This dog, which was once used as a personal defense dog, police dog and war dog, is often mistakenly believed to be very aggressive.	Field Spaniel	Doberman Pinscher	Elo	Finnish Spitz	Doberman Pinscher	3
1858	This dog breed was developed as a gun dog in Canada?	Mountain Cur	Pharaoh Hound	Lakeland Terrier	Labrador Retriever	Labrador Retriever	3
1859	What is the mortality rate of a cheetah cub growing to adulthood?	50% die	15% die	65% die	95% die	95% die	3
1860	What is another name for a nutria?	Beaver	Muskrat	Rat	Coypu	Coypu	3
1861	The nutria is native to which continent?	Europe	South America	Africa	North America	South America	3
1862	What is the average weight of an adult nutria?	15-25 lbs.	5-10 lbs.	Over 30 lbs.	10-20 lbs.	10-20 lbs.	3
1863	Which of the following is a characteristic of the nutria?	Webbed front feet	Huge black eyes	Large orange teeth	Flat beaver like tale	Large orange teeth	3
1864	What do farmers raise nutrias for?	Their fur is very valuable.	Their huge teeth can be sold as jewelry.	They can use their oil for shampoos and lotions.	Their milk is very nutritious.	Their fur is very valuable.	3
1865	Nutria meat is lean and low in what?	Iron	Sodium	Cholesterol	Fiber	Cholesterol	3
1866	What time of year do nutrias breed?	In the winter months	All year round	In the Fall	In the spring	All year round	3
1867	What is a common nickname for the Yorkshire Terriers?	Yorkie	They have no nickname.	Yorkle	Shorky	Yorkie	3
1868	What is the Yorkshire Terriers average lifespan?	5 - 8 years	11 - 13 years	15 - 18 years	99 - 101 years	11 - 13 years	3
1869	What place did the Yorkshire Terrier take in the AKC registered breed popularity in the USA in 2008?	1st	50th	2nd	79th	2nd	3
1870	Venomous and poisonous are two different terms. What does the term venomous refer to?	Animals that inject venom	Animals that are deadly when eaten	Plants and animals that secrete venom and are harmful when touched	All of these	Animals that inject venom	3
1871	Which of these statements is true about the slow loris, a primate which is both poisonous and venomous?	All of these	It covers its young with a toxin to keep them from being eaten.	It has a venomous bite.	It secretes a toxin from the glands on the inside of its elbows.	All of these	3
1872	The Brazilian wandering spiders are included in Guinness World Records 2007 as the worlds most venomous spiders. How do they inject their venom?	By stinging	By biting	All of these	By urticating hairs	By biting	3
1873	What creature is considered the most venomous on the planet?	Fat-tailed scorpion	Killer bee	Box jellyfish	Cone snail	Box jellyfish	3
1874	The stonefish is an extremely venomous type of fish that lives in the coastal regions of Indo-Pacific oceans. How does it inject its venom?	With its sharp teeth	With its tail fin	With its pectoral fin	With its dorsal fin	With its dorsal fin	3
1875	The name of cobras, which are very venomous, comes from the Portuguese cobra de capello. What does this mean?	Snake with hood	Poisonous hat	Poisonous nose	Snake with nose	Snake with hood	3
1876	Venomous mammals do exist, although they are very rare. Which of these mammals is venomous?	European Mole	Cuban Solenodon	All of these	Platypus	All of these	3
2283	Which Rough Collie was awarded a star on the Hollywood Walk of Fame?	Odie	Honey	Lassie	Beauty	Lassie	3
1877	How do fire ants, a type of venomous ants, introduce their venom?	All of these	Through biting	Through biting and then spraying the wound with venom	Through stinging	Through stinging	3
2197	On which continent can you find the turltle-dove during most of the year?	Australia	Antarctica	South America	Europe	Europe	3
1878	What kind of animal is the venomous Gila monster that is indigenous to southwestern United States and northern Mexico?	Lizard	Invertebrate	Frog	Mammal	Lizard	3
1879	What phylum do jellyfish belong to?	Arthropoda	Chordata	Cnidaria	Mollusca	Cnidaria	3
1880	Which of these body systems do jellyfish NOT have?	osmoregulatory	respiratory	circulatory	all of these	all of these	3
1881	What is a group of jellyfish called?	herd	bloom	school	pack	bloom	3
1882	How is the body of the jellyfish oxygenated?	osmosis	active transport	diffusion	photosynthesis	diffusion	3
1883	What is the deadliest jellyfish in the world?	Box Jellyfish	Lions Mane Jellyfish	Moon Jellyfish	Sea Nettle	Box Jellyfish	3
1884	According to statistics, how are wolves killed today?	By people	By hunters and poachers	By poison and areal hunters	All of these	All of these	3
1885	How many different types of wolves including sub-species are there around the world?	Over 100	44	9	3	9	3
1886	How long is the female gestation period in wolves?	90 days	25 days	63 days	200 days	63 days	3
1887	What is the most amount of wolf pups ever recorded in a litter?	4 pups	5 pups	14 pups	10 pups	14 pups	3
1888	At what age does a wolf usually leave its pack?	5-6 years	2-3 years	1-2 years	3-4 years	2-3 years	3
1889	The blue whale is the largest animal, but what is the largest toothed whale on the planet?	Cuviers Beaked Whale	Orca	All of these	Sperm whale	Sperm whale	3
1890	What Gorilla is the largest primate on the planet?	Mountain Gorilla	Western Lowland Gorilla	Eastern Lowland Gorilla	Cross River Gorilla	Eastern Lowland Gorilla	3
1891	What is the largest living bird of prey on the planet?	Philippine Eagle	Booted Eagle	Lappet-faced Vulture	Eurasian Black Vulture	Eurasian Black Vulture	3
1892	What is the largest fish in existence?	Manta ray	Whale shark	Ocean sunfish	Basking shark	Whale shark	3
1893	Name the largest mollusk and the largest invertebrate in the world?	Giant African snail	North Pacific Giant Octopus	Colossal squid	Giant squid	Colossal squid	3
1894	What is the largest living terrestrial organism on the planet?	African Forest Elephant	Asian Elephant	African Bush Elephant	Indian Elephant	African Bush Elephant	3
1895	Approximately how much does a typical female vampire bat weigh?	8 oz.	1.5 oz.	5 oz.	1 lb.	1.5 oz.	3
1896	Out of 200 vampire bats, approximately how many have rabies?	5	25	10	1	1	3
1897	What is the average lifespan of a vampire bat?	20-25 years	5-10 years	40-50 years	70-80 years	40-50 years	3
1898	Where are vampire bats mostly found?	Australia	Mexico, Central America and South America	Asia	Africa	Mexico, Central America and South America	3
1899	A vampire bat will die if it doesnt find blood for how many nights in a row?	2	5	1	7	2	3
1900	How do wolves mark their territory?	By urinating	By defecating	By rubbing against objects	All of these	All of these	3
1901	What actor directed and starred in the popular 1990 movie Dances with Wolves?	Sean Connery	Kevin Costner	Mel Gibson	Harrison Ford	Kevin Costner	3
1902	What is the largest wolf species on the planet as well as the largest wild representative of the Canidae family?	Grey wolf	Polar wolf	Black wolf	Red wolf	Grey wolf	3
1903	Wolf pups are usually born with irises of this color, which changes with time.	Black	Golden	Green	Blue	Blue	3
1904	What animal is considered the major enemy of the wolf in the wild, apart from humans?	Bear	Other wolves	Eagle	None of these	Other wolves	3
1905	What type of wolf is White Fang from Jack Londons popular novel White Fang?	Grey wolf	White wolf	Wolf hybrid	Red wolf	Wolf hybrid	3
1906	In what European city is the popular bronze statue Capitoline Wolf located?	Madrid	Paris	London	Rome	Rome	3
1907	What animals do wolves generally prefer to feed on?	Rodents	Birds	Fish	Ungulates	Ungulates	3
1908	To what continent is the unique Maned Wolf endemic?	Asia	Africa	South America	Europe	South America	3
1909	Which animals have the most unique species endemic to Australia?	Amphibians	Mammals	Insects	Reptiles	Amphibians	3
1910	Which of these statements about the Australian fauna is true?	Australia is the only continent that has more venomous than non-venomous snake species	Two of the five known species of monotremes live in Australia	All of these	Placental mammals are relatively rare in Australia	All of these	3
1911	What animal is the largest macropod and one of Australias heraldic animals?	Pademelon	Red kangaroo	Grey kangaroo	Quokka	Red kangaroo	3
1912	What kind of animal is the Spotted wobbegong?	Fish	Reptile	Amphibian	Marsupial	Fish	3
1913	What is the common name of the Quoll, a carnivorous marsupial native to Australia and Papua New Guinea?	Native cat	Native rat	Native fox	Native dog	Native cat	3
1914	Which of these areas is the Black Salamander endemic to?	Hawaii	United States	Australia	India	United States	3
1915	Which of these statements is true about the Western black widow spider?	The female always eats the male after mating.	It is extremely venomous.	It is native to Madagascar.	All of these	It is extremely venomous.	3
1916	What type of food does the Lesser Vasa Parrot, also known as Black Parrot, feed on?	Fruit	Insects	All of these	Carrion	Fruit	3
1917	How did the Black Mamba snake get its name?	Because of its color	Because its eggs are black	Because its mouth is black	Because its venom is black	Because its mouth is black	3
1918	Which of these names refers to the Asian black bear, a close relative of the American black bear?	Himalayan black bear	All of these	Tibetan black bear	Moon bear	All of these	3
1919	The Black wolf is actually a color variant of which wolf species?	White wolf	None of these	Brown wolf	Grey wolf	Grey wolf	3
1920	The name Lumbriculus variegatus, or blackworm, refers to a few worm species. In what way do they reproduce?	By parthenogenesis	With eggs	All of these	By regeneration	By regeneration	3
1921	Which of these statements is true about the Black dog, a ghost-like creature popular in the folklores of the British Isles?	It is believed to appear at night.	It is associated with the Devil.	It is considered a portent of death.	All of these	All of these	3
1922	Which of these statements is true about the Black garden ant?	Each colony has only one queen.	It is found in Europe.	All of these	It is found in North America and Asia.	All of these	3
1923	Which of these statements is true about the Black Iberian Pig?	It is indigenous to the Mediterranean.	It is a rodent.	All of these	It is not actually black.	It is indigenous to the Mediterranean.	3
1924	What animal is is the only strictly-marine herbivorous mammal in the world?	Dugong	All of these	Sea pig	Sea cow	All of these	3
1925	This animal is considered a marine mammal because it lives on the sea ice most of the year.	Polar bear	All of these	Walrus	Polar fox	Polar bear	3
1926	The Hooded Seal is a marine mammal that populates this geographic area.	North and northeast Pacific	All of these	Central and western North Atlantic	North Indian Ocean	Central and western North Atlantic	3
1927	This animal is the heaviest member of its family, and also one of the smallest marine mammals.	Sea pig	Sea otter	Polar mouse	None of these	Sea otter	3
1928	Which of these marine mammals matches the description: Very large body, has tusks and whiskers?	Tusked seal	Elephant seal	Walrus	Polar bear	Walrus	3
1929	The Humpback Whale, one of the largest marine mammals, feeds in this season.	Spring and winter	Winter	Summer	Fall	Summer	3
1930	This extraordinary marine mammal is often considered a whale, but it is actually a dolphin.	All of these	Killer Whale	Blackfish	Seawolf	All of these	3
1931	Dolphins are considered some of the most intelligent animals on the planet. How are they classified according to their diet?	They are specialized eaters.	They are carnivores.	They are herbivores.	They are omnivores.	They are carnivores.	3
1932	This marine mammal is known as the pilot whale, but it is not actually a whale. What type of animal is it?	Walrus	Seal	Dolphin	Otter	Dolphin	3
1933	Which of these animals are among the many marine mammals that use songs for the purposes of communication?	All of these	Blue Whale	Humpback whale	Beluga	All of these	3
1934	Translated in English, what does the name of the chinchilla mean?	Little Chilean	Little Chincha	Little Chile	Of Chincha	Little Chincha	3
1935	The natural habitat of the Chinchilla is this region in South America.	Tierra del Fuego	The Atacama Desert	The Amazon River basin	The Andes	The Andes	3
1936	Which is the wrong statement about chinchilla breeding?	Chinchilla litters predominately consist of twins.	Chinchillas can breed any time of the year.	Little chinchillas are born furred and with eyes open.	Chinchillas have a 45-day gestation period.	Chinchillas have a 45-day gestation period.	3
1937	To which chinchilla species do most of the domestic chinchillas belong?	None of these	Chinchilla lanigera	Giant Chinchilla	Chinchilla brevicaudata	Chinchilla lanigera	3
1938	In nature, chinchillas can be found in only one color. Which one is it?	Grey	Black	Brown	Beige	Grey	3
1939	Which of the following should be avoided in the pet chinchillas diet?	Fresh vegetables	Hay	Water	Raisin	Fresh vegetables	3
1940	Which of these physiological features does the chinchilla lack?	The ability to sweat	The ability to sneeze	The ability to jump	The ability to swallow	The ability to sweat	3
1941	Name the two types of Chinese Crested dogs.	Water and Runner	Hairless and Hound	Sporty and Spotted	Hairless and Powderpuff	Hairless and Powderpuff	3
1942	Which breed group does the Chinese Crested dog belong to?	Sporting	Hound	Toy	Non-Sprint	Toy	3
1943	Which of the following behaviors is not typical for the Chinese Crested dog?	Pant to keep cool	Bark	Lift a leg to urinate	Wag their tail when happy	Pant to keep cool	3
1944	The origin of the Chinese Crested dog is unknown, but according to some sources it may have come from which of these places?	Canada and USA	Thailand and Egypt	Mexico and Africa	Japan and China	Mexico and Africa	3
1945	A hairless Chinese Crested dog needs to be protected from which of the following?	Sunburn	Winter Wind	Dry Skin	All of these	All of these	3
1946	What term is commonly used to denote a group of foxes?	Earth	Troop	All of these	Skulk	All of these	3
1947	What is the meaning the word which stands for fox in many languages?	Fur	Nose	Cunning	Tail	Tail	3
1948	How are most foxes generally classified according to their diet?	Omnivores	Specialized eaters	Insectivores	Carnivores	Omnivores	3
1949	Which of these names refers to the Crab-eating Fox, a medium-sized fox found in the central part of South America?	Forest Fox	Wood Fox	Common Fox	All of these	All of these	3
1950	What fox species is considered to be the smallest on the planet?	Short-Tailed Fox	Fennec Fox	Island Fox	Coast Fox	Fennec Fox	3
1951	What notable feature does the Fennec Fox possess, that makes it easily recognizable?	It has no tail	Bluish fur	Very large ears	Red eyes	Very large ears	3
1952	Which of these names belongs to the fox species that is the second smallest fox species in the world, slightly smaller than a domestic cat?	Short-Tailed Fox	All of these	Coast Fox	California Channel Island Fox	All of these	3
1953	According to Chinese mythology, what shape do fox spirits known as huli jing take in the real world?	Cats	Children	Bushes	Women	Women	3
1954	which of these stories and books have a fox character involved in the storyline?	Pippi Longstocking	The Adventures of Pinocchio	The Little Match Girl	Thumbelina	The Adventures of Pinocchio	3
1955	What eminent musician released his album The Fox in 1981?	Tom Johnes	Elton John	Barry White	Julio Iglesias	Elton John	3
1956	Chipmunks are small squirrel-like rodents belonging to the genus Tamias. What does the Greek word tamias mean?	Storer	Nibbler	Squirrel	Stripes	Storer	3
1957	What would some species of  porcupine consume in order to supply calcium ans salts?	Nails	All of these	Tiny rocks	Bones	Bones	3
1958	What defense tactic does the chinchilla use in order to escape from its predators, which include birds of prey, skunks, felines, snakes and canines?	Playing dead	Squeaking	Scratching	Spraying urine	Spraying urine	3
1959	What rodent, closely related to the chinchilla and guinea pig, is also known as the Brush-Tailed Rat and is native to Chile?	Gerbil	Degu	White-tailed Antelope Squirrel	Prairie dog	Degu	3
1960	The Capybara is the largest rodent in the world. What is the meaning of its name, derived from a word of the Guaran� language?	Master of the grasses	River keeper	Rabbit pig	Water squirrel	Master of the grasses	3
1961	The acouchis, small diurnal rodents found along riverbanks in the Amazon Rainforest, usually feed on this type of food.	Insects	Grass	Fruit	Nuts	Fruit	3
1962	Guinea pigs are very intelligent, highly social animals that use special vocalization to communicate. What does their whistling or wheeking sound express?	Excitement	Danger or pain	Discomfort	Warning	Excitement	3
1963	Groundhogs are mostly herbivorous rodents that sometimes eat animal matter. What kind of animals would they feed on?	Larvae	Grasshoppers	All of these	Snails	All of these	3
1964	What kind of unique activity is characteristic of the African Pygmy Mouse, the smallest rodent in the world?	It sings at night.	It disguises its young using leaves.	It starts dancing when it feels threatened by a predator.	It piles up pebbles in front of its burrow.	It piles up pebbles in front of its burrow.	3
1965	Which of these statements is true about rodent species in general?	All of these	The Latin word rodere, from which rodent originates, means rat.	Rodents have canine teeth only on their lower jaw.	Rodents do not vomit.	Rodents do not vomit.	3
1966	How did Hummingbirds get their interesting name?	None of these	They are named after their discoverer, Michael Hummings.	Because of their singing	Because of the noise they produce when they fly	Because of the noise they produce when they fly	3
1967	Hummingbirds are the only birds on the planet to have this amazing ability.	They can stay without water for as many as 30 days.	All of these	They can carry food that is 3 times heavier than their own weight.	They can fly backwards.	They can fly backwards.	3
1968	What is the major type of food that Hummingbirds depend on for their survival?	All of these	Seeds	Buds	Nectar	Nectar	3
1969	Which of the following statements is true about Hummingbirds?	Hummingbirds heart can beat as fast as 300 times per minute.	When Hummingbirds are flying they have the fastest metabolism of all animals, except for insects.	All of these	Hummingbirds often consume very large amounts of food and they are not able to lift off.	When Hummingbirds are flying they have the fastest metabolism of all animals, except for insects.	3
1970	What is the term for the state of temporary hibernation that Hummingbirds enter when food is not available?	Hush	Stupor	Stillness	Torpor	Torpor	3
1971	What is the reason for Hummingbirds short life-span?	Their fast metabolic rate	They have many predators.	They often get poisoned when feeding on nectar or insects.	Their small size	Their fast metabolic rate	3
1972	The usage of raw sugars, including brown sugar, is not recommended when preparing artificial nectar for Hummingbirds. Why?	All of these	Raw sugars contain iron.	Raw sugars contain zinc.	They contain harmful heavy metals.	Raw sugars contain iron.	3
1973	Aztecs are known for wearing hummingbird talismans which symbolize which of the following?	Skill at arms	Energy	Sexual potency	All of these	All of these	3
1974	How did the smallest bird in the world, the Bee Hummingbird, get its name?	Because of its black-and-yellow plumage	Because it is approximately the size of a large bee	Because of the sound it make with its wings	Because it feeds on bees	Because it is approximately the size of a large bee	3
1975	Where does the Giant Cowbird, a passerine bird found in South America, lay its eggs?	In other birds nests	On rocks	On balconies	On the ground	In other birds nests	3
1976	The vicuna, a South American animal, is a close relative of this other animal.	Iguana	Llama	Tarantula	Chinchilla	Llama	3
1977	What common name is used to denote the dolphin species Sotalia fluviatilis, indigenous to South America?	Tucuxi	Bufeo gris	All of these	Bufeo negro	All of these	3
1978	What color is the head of the South American stork Jabiru, whose body is predominantly white?	Purple	Green	Black	Red	Black	3
1979	What type of animal is the Gold tegu, found in South America?	Reptile	Insect	Deer	Primate	Reptile	3
1980	What makes the Scarlet Macaw, a parrot species indigenous to South America, unsuitable for a pet?	It is very demanding.	It is extremely noisy.	It is a high maintenance pet.	All of these	All of these	3
1981	What does the South American snake Lachesis muta, commonly known as South American bushmaster, do when it feels threatened?	It starts vibrating its tail.	It spreads its neck.	It hisses and dances.	All of these	It starts vibrating its tail.	3
1983	Which of the following is a characteristic of the tiger shark?	They can breath above water.	They have eyelids.	They give birth to live young.	They have body hair.	They give birth to live young.	3
1984	What time of day does the tiger shark usually hunt?	They hunt at different times throughout the day	Early morning	Nighttime	Mid morning	Nighttime	3
1985	How long is the gestation period for a female tiger shark?	15-16 months	20-21 months	10-12 weeks	9-10 Months	15-16 months	3
1986	Which of these is one of the nicknames of the tiger shark?	Garbage Can of the Deep	Predators  that will kill	Wastebasket of the Sea	Killers of the Ocean	Wastebasket of the Sea	3
1987	What does the Latin word  omnivore stand for?	Fast eater	Eating constantly	Eating whatever	Eating everything	Eating everything	3
1988	Most bear species are omnivores and their diet consists mainly of what?	Tubers	Leaves	Grass	Mast	Mast	3
1989	Which of these statements is NOT true about the Common Raven, a popular omnivorous bird?	It wouldnt reject carrion	It would feed on animal feces	It wouldnt eat birds	It feeds on human food waste	It wouldnt eat birds	3
1990	Which of these is not within the natural diet of the omnivorous Eastern Box Turtle?	Small amphibians	Earthworms	Snails	Carrion	Small amphibians	3
1991	Which of these is true about raccoons?	They do not produce enough saliva to moisten their food	They use their front paws to examine their food and remove unwanted parts	Only wild raccoons douse their food	All of these	They use their front paws to examine their food and remove unwanted parts	3
1992	What is the main food source for the sloth, an omnivorous mammal living in Central and South America?	Small reptiles	Leaves	Insects	Fruit	Leaves	3
1993	What bizarre food would pigs occasionally eat, being omnivores?	Tree bark	Their young	Rotting carcasses	All of these	All of these	3
1994	Skunks, which are omnivorous mammals, are one of the primary predators of these animals.	Moles	Termites	Honeybees	Salamanders	Honeybees	3
1995	What is the prevailing color of the fur of the Tasmanian devil?	Grey	White	Brown	Black	Black	3
1996	In what part of their body do Tasmanian devils store body fat?	Abdomen	Neck	Tail	Back	Tail	3
1997	What is the meaning of the word Sarcophilus, the name of the genus that the Tasmanian devil belongs to?	Devil creature	Blood-lover	Dog-like	Meat-lover	Meat-lover	3
1998	At what time of the day are Tasmanian devils most active?	At night	Early morning	At noon	During the daytime	At night	3
1999	Which of these statements is true about Tasmanian devils?	They are predominantly solitary animals	They live in couples	They live in groups	None of these	They are predominantly solitary animals	3
2000	What does the Tasmanian devil do when it feels stressed or threatened?	It starts screaming	It plays dead	It produces a strong odour	It attacks	It produces a strong odour	3
2001	Which of these statements are wrong about the reproduction of the Tasmanian devil?	The female gives birth to 20-30 young	Gestation lasts 21 days	The female has six nipples	None of these	The female has six nipples	3
2003	In May 2009 the Tasmanian devil was declared to be endangered because this disease had almost wiped out its population.	AIDS	Facial cancer	Kawasaki disease	Rabies	Facial cancer	3
2004	What is the name of the Tasmanian devil cartoon character from Looney Tunes by Warner Bros.?	Taz	Tess	Devlin	Tassie	Taz	3
2005	Which of these are a part of an ant colony?	All of these	Drones	Soldiers	Workers	All of these	3
2006	Which of these behaviors is typical of ant societies?	Ability to solve complicated problems	Communication between individuals	Division of labor	All of these	All of these	3
2007	Which of these is true about ants diet?	All ants are herbivores.	All ants are carnivores.	Most ant species are carnivores.	Most ants are omnivores.	Most ants are omnivores.	3
2008	What is the usual size range of mature ants?	From 1.5 to 12 millimeters	From 3.5 to 61 millimeters	From 2 to 33 millimeters	From 0.75 to 52 millimeters	From 0.75 to 52 millimeters	3
2009	Which of the following statements is true about ants eyes and eyesight?	The eyesight of most ants ranges from poor to average, and a number of species that live underground are completely blind.	All of these	Ants have compound eyes which consist of multiple small lenses.	Ants have three simple eyes called ocelli on the top of their heads that detect light levels and polarization	All of these	3
2011	Which of these ways of defence and attack do ants use?	All of these	Injecting or spraying chemicals	Stinging	Biting	All of these	3
2012	This chemical is found in the venom of most ants and some other insects.	Formaldehyde	Saxitoxin	Formic acid	Cyanic acid	Formic acid	3
2013	Some small spider species, as well as the young of larger species, are known for floating in the wind. What is this activity commonly known as?	Skydiving	Jetting	Drifting	Ballooning	Ballooning	3
2014	Which of these mollusks is able to glide over in air for up to 50 meters (164 feet)?	Oyster	Squid	Octopus	Slug	Squid	3
2015	In what ocean can the 50 species of Exocoetidae, also known as flying fish, be found?	Atlantic ocean	All of these	Indian ocean	Pacific ocean	All of these	3
2016	Of all the gliding animals, which one is the one best glider?	Sifaka	Flying lemurs	All of these	Flying squirrels	Flying lemurs	3
2017	Which  frog is a skilled glider, able to make two types of turns midair?	Malayan flying frog	Benjamins gliding frog	Wallaces Flying Frog	Chinese gliding frog	Chinese gliding frog	3
2018	Some mammals are able to glide and parachute, but bats are the only ones capable of flying.  What is the name of the membrane that forms the surface of their wings?	Reticulum	Patagium	Corticulum	Flagellum	Patagium	3
2019	In what geographical region can you find the Paradise Flying Snake, also called Paradise Tree Snake?	Central and South America	North America	Australia	Asia	Asia	3
2020	What kind of organism is the Greater Glider, a gliding animal indigenous to Australia?	Reptile	Fish	Amphibian	Mammal	Mammal	3
2021	Where are the gliding membranes of the Draco lizard species positioned?	Between their fingers and toes	Between its front and hind legs	They do not have a gliding membrane	On their elongated ribs	On their elongated ribs	3
2022	Which of these species of geckos is able to glide in the air after jumping or falling from a tree?	Gold dust day gecko	Ptychozoon	Uroplatus fimbriatus	Leopard gecko	Ptychozoon	3
2023	The large tsetse fly, found in Africa, feeds on what?	All of these	Blood	Carrion	Nectar	Blood	3
2024	What type of animal is the serval?	Canine	Ungulate	Reptile	Feline	Feline	3
2025	What is the largest crocodilian in Africa?	Gharial	Slender-snouted Crocodile	Nile crocodile	Saltwater crocodile	Nile crocodile	3
2026	What body part of the giraffe can indicate its gender?	Tongue	Teeth	Horns	Eyes	Horns	3
2027	Adult Goliath beetles, found in Africas tropical forests, feed on what?	Leaves and grasses	Insects and other invertebrates	Fruits and tree sap	Carrion	Fruits and tree sap	3
2028	What type of animal is the dik-dik, indigenous to Africa?	Cricket	Wild cat	Rodent	Antelope	Antelope	3
2029	In cetaceans, the species identification �rorqual� comes from the Norwegian word �rorhval� which means �furrow.� These furrows are obvious on all rorqual whales. Which of the following is not a rorqual whale?	Beluga whale	Sei whale	Bryde�s whale	Minke whale	Beluga whale	3
2030	Right and gray whales have been over-fished almost to extinction. Which of the following is a gray or right whale?	Bowhead whale	Blue whale	Sperm whale	Narwhal	Bowhead whale	3
2031	Narwhals and belugas make up separate subspecies of cetaceans. However, taxonomists often include in it a dolphin which lives in Indo-Pacific waters. What is the name of this dolphin?	Irrawaddy dolphin	Bottlenose dolphin	Boto	Risso�s dolphin	Irrawaddy dolphin	3
2032	Which whale expels a reddish-brown fluid when threatened, much like an octopus?	Dwarf sperm whale	Pygmy sperm whale	Andrew�s beaked whale	Fin whale	Pygmy sperm whale	3
2033	Males of this whale species have one tooth that can grow to be 10 feet (3 m) long.	Strapped-tooth whale	Narwhal	Long-finned pilot whale	Blainville�s beaked whale	Narwhal	3
2034	The largest family of whales is the beaked whales (Ziphiidae). Most of the scarce information about this family has been found from dead specimens. Their teeth are the most distinctive aspect of these whales; most have only 2-4 oversized teeth. Which whale�s teeth erupt from bulges in the lower jaw?	Stejneger�s beaked whale	Longman�s beaked whale	Blainville�s beaked whale	Arnoux�s beaked whale	Blainville�s beaked whale	3
2035	The family �delphinidae� include which kind of cetacean?	Rorqual whales	Southern right whales	Porpoises	Dolphins	Dolphins	3
2036	The family �phocoenidae� describe which group of cetacean?	Indus and Ganges river dolphins	Porpoises	Beaked whales	Dolphins	Porpoises	3
2037	These cetaceans live off the southern coast of South America and can be found up to 150 miles (240 km) up the Amazon River. They are colored pale blue with a white underside. What is their name?	Tuxici	Amazon dolphin	South American dolphin	Franciscana	Tuxici	3
2038	Sometimes called the �hooked-finned� porpoise, this animal has a barely noticeable beak. It lives in the deep waters of the northern latitudes between North America and Asia, and is a very fast swimmer (up to 20 mph / 32 km/h). What is its name?	Dusky dolphin	Dall�s porpoise	Pacific white-sided dolphin	Pantropical dolphin	Pacific white-sided dolphin	3
2039	The representatives of this type of dolphins have very small eyes, making them virtually blind. They rely on echolocation to find food and swim in turbid waters. They include the baiji and boto. What are they called?	Oceanic dolphins	River dolphins	Muddy dolphins	Blind dolphins	River dolphins	3
2331	Approximately, how many species of dolphins exist?	20	40	30	12	40	3
2040	This family of cetaceans has representatives like the vaquita, the harbor, and spectacled type. They are shy and stay away from boats; however, they are particularly susceptible to fishing lines, nets, and other pollution. Which is the family?	Pilot whales	River dolphins	Porpoises	Dolphins	Porpoises	3
2041	This oceanic dolphin has distinctive yellow patches on its sides. It is mostly found in the northern latitudes of the Atlantic Ocean.	Atlantic white-sided dolphin	Hector�s dolphin	Atlantic yellow-sided dolphin	Common dolphin	Atlantic white-sided dolphin	3
2042	This popular dolphin often herds fish onto the beach in order to eat the stranded fish. As a result, the teeth on one side (usually the right) are worn down due to eating sand as well as the fish. Which is this dolphin?	Stranded dolphin	Bottlenose dolphin	Right-sided dolphin	Spotted dolphin	Bottlenose dolphin	3
2043	Which of the following do orca NOT do with their food?	Regurgitate it for their young	Throw it	Use it as a teaching tool for young orca	Slam it on the surface of the water	Regurgitate it for their young	3
2044	What animal is considered the smallest mammal in length on the planet?	None of these	Pygmy Jerboa	Kittis Hog-nosed Bat	Etruscan Shrew	Kittis Hog-nosed Bat	3
2045	The Microraptor, the smallest known non-avian dinosaur, inhabited this modern day area during the early Cretaceous Period 130-125.5 million years ago.	Madagascar	China	Australia	Canada	China	3
2046	What kind of animal is the smallest known reptile on the planet?	Lizard	Snake	Turtle	Gecko	Gecko	3
2047	This tiny frog is the smallest amphibian in the world.	Monte Iberia Eleuth	Brazilian Gold Frog	Rana Minuscula	Small Frog	Brazilian Gold Frog	3
2048	What type of insect is the smallest known insect on the planet?	Cockroach	Wasp	Ant	Fly	Wasp	3
2049	Which of these tiny bugs is considered the smallest beetle in the world?	None of these	Scydosella musawasensis	Nanosella	Vitusella fijiensis	Scydosella musawasensis	3
2050	What type of animal is the smallest vertebrate?	Mammals	Reptiles	Amphibians	Fish	Fish	3
2051	The smallest turtle in the world, the Speckled Padloper Tortoise, inhabits which of these areas?	South Asia	North Australia	South America	South Africa	South Africa	3
2052	Where is its natural habitat of the smallest bird on the planet, the Bee Hummingbird?	Hawaii	All of these	Cuba and the Isle of Youth	Madagascar	Cuba and the Isle of Youth	3
2053	What bacterium is believed to be the smallest living organism that is capable to grow and reproduce independently?	Staphylococcus aureus	Escherichia coli	Carsonella ruddii	Mycoplasma genitalium	Mycoplasma genitalium	3
2054	What does the diet of most penguin species primarily consist of?	Krill	All of these	Squid	Fish	All of these	3
2055	The largest penguin species on the planet is the Emperor Penguin. What is the smallest one?	All of these	Blue Penguin	Little Penguin	Fairy Penguin	All of these	3
2056	There are various theories for the origin of the word penguin, such the Latin word pinguis, which means what?	Diver	Upright	Swimmer	Fat	Fat	3
2057	What color is the crest on the head of the Southern Rockhopper Penguin, which is known for having red eyes?	Bright blue	Yellow	Red	Green and blue	Yellow	3
2058	Which of these penguin species is the closest relative of the Magellanic Penguin?	African Penguin	All of these	Galapagos Penguin	Humboldt Penguin	All of these	3
2059	What is the common name of the Eudyptes schlegeli penguin species that have a white face and live in the waters surrounding Antarctica?	King Penguin	All of these	Emperor Penguin	Royal Penguin	Royal Penguin	3
2060	The sound of what musical instrument does the call of the Macaroni Penguin resemble?	Trumpet	Saxophone	Flute	Ocarina	Trumpet	3
2061	Most penguin species are piscivorous, meaning what?	They do not drink water	They have a tubular body shape	They feed primarily on fish	An aquatic animal	They feed primarily on fish	3
2062	What notable feature does the Gentoo Penguin possess which makes it easily recognizable?	A white stripe on the top of its head	A longer blue tail	A red crest on its head	A yellow spot on its abdomen	A white stripe on the top of its head	3
2063	What is the special talent of the penguin Mumble from the 2006 animated movie Happy Feet?	Shoe making	Singing	Break dancing	Tap dancing	Tap dancing	3
2064	What large mammal is the national animal of India?	Water Buffalo	Bengal tiger	Indian Rhinoceros	Indian Elephant	Bengal tiger	3
2065	What type of Indian animals are included in the so-called Big Four selection?	Poisonous snakes	Largest insects	Most dangerous animals	Largest land animals	Poisonous snakes	3
2066	What interesting physical feature does the Nicobar Bulbul, endemic to the Nicobar Islands of India, possess?	It has a bright red beak.	Its tail is very long and yellow.	Its eyes are purple.	It has a dark cap on its head.	It has a dark cap on its head.	3
2067	Which of these statements is not true about the Indian Elephant?	It has a smaller trunk than the African Elephant.	All of these	Its abdomen is quite large compared to its skull, unlike African elephants.	It has larger ears than the African Elephant.	All of these	3
2068	What interesting resting posture does the Indian Treeshrew, a.k.a. Madras Treeshrew, have?	Sprawling on the ground as if its dead	With its tail resting on its head	Cuddling its rear legs	Hanging upside down from a branch	With its tail resting on its head	3
2069	What type of animal is the Indian Flying-fox, found in India, Bangladesh, China, and other parts of Asia?	Bat	Fox	Squirrel	Primate	Bat	3
2070	What is the only place in the world you can see platypuses in the wild?	South-eastern Asia	Australia and Tasmania	Hawaii Island	South America	Australia and Tasmania	3
2071	How do platypuses reproduce?	None of these	Platypuses reproduce asexually.	Platypuses lay eggs.	Platypuses are metatherian.	Platypuses lay eggs.	3
2072	How does the platypus feed its young for the first three to four months?	The mother is feeding them with insects.	The mother is breastfeeding them.	The young rely on their yolk sacs for food.	The mother is lactating, but she has no teats.	The mother is lactating, but she has no teats.	3
2073	What is the weight range of normal mature platypuses?	Between 3.2 and 4.6 kg	From 2.5 to 5.5 kg	Between 0.5 to 2.8 kg	From 0.7 to 2.4 kg	From 0.7 to 2.4 kg	3
2074	Platypuses use this method to detect their prey.	They rely on their well-developed sense of smell.	Platypuses rely mainly on their hearing.	They use electrolocation.	They rely on their exceptional eyesight.	They use electrolocation.	3
2075	What is the normal life span of a platypus in the wild?	Up to 22 years	Up to 11 years	Around 2 years	About 4 years	Up to 11 years	3
2195	What is the name of the smallest wombat species on the planet?	Northern Hairy-nosed Wombat	Southern Hairy-nosed Wombat	Common Wombat	None of these	Southern Hairy-nosed Wombat	3
2076	Which of these statements is true about the diet of the platypus?	Platypuses are carnivores.	Platypuses are herbivores.	Platypuses are specialized eaters.	Platypuses are omnivores.	Platypuses are carnivores.	3
2077	What is the normal body temperature of a healthy platypus?	Around 22�C	Around 28�C	Between 35�C and 37�C	About 32�C	About 32�C	3
2078	What geographical region are chinchillas native to?	Asia	Africa	North America	South America	South America	3
2079	How is the chinchilla classified according to the peak of its activeness throughout the day?	None of these	Nocturnal	Crepuscular	Duirnal	Crepuscular	3
2080	What type of food do chinchillas prefer to feed on in the wild?	Plants	All of these	Insects	Fruits	All of these	3
2081	What name is used for the social groups that chinchillas form when living in the wild?	Schools	Herds	Flocks	Troops	Herds	3
2082	What chinchilla species has become extinct as a result of fur hunting?	All of these	Long-tailed Chinchilla	Giant Chinchilla	Red-nosed Chinchilla	Giant Chinchilla	3
2083	In which of these studies are chinchillas used as animal models?	Studies of vocalization	Eyesight studies	Studies of the auditory system	Studies of the reproductive system	Studies of the auditory system	3
2084	If the ears of a chinchilla turn red, it is a sign of this condition.	It is pregnant.	The animal is in heat.	The animal is disturbed or angry.	Overheating	Overheating	3
2085	What kind of sounds do baby chinchillas produce in order to show their parents that they are hungry?	Hissing	Chirps	Barks	Clucking	Chirps	3
2086	What is the literal translation of the word lanigera in the name of the chinchilla species Chinchilla lanigera?	Long-tailed	Having long ears	Sleeping in straw	Wearing a woolen coat	Wearing a woolen coat	3
2087	This cat breed, developed by American breeder Ann Baker, is large and has blue eyes and soft fluffy coat with point coloration.	Ragdoll	LaPerm	Egyptian Mau	Savannah	Ragdoll	3
2088	This large cat breed, created in the United States, has rabbit-like fur of medium length, rectangular body, and a fatty pad in the lower abdomen.	Balinese	California Spangled Cat	Munchkin	Ragamuffin	Ragamuffin	3
2089	This cat breed occurred naturally, most probably in Egypt. It has silky short fur with special ticked coloration.	Korat	Sphynx	Abyssinian	Burmilla	Abyssinian	3
2090	This very old cat breed, which occurred naturally in Turkey, has a slender body with medium length fur, usually white.	Ocicat	Cymric	Selkirk Rex	Turkish Angora	Turkish Angora	3
2091	This cat breed, which appeared naturally in Thailand, has a slim body and short fur with point coloration.	Himalayan	Siamese	Korat	Burmese	Siamese	3
2092	This hairless cat breed originated in Russia.	Don Sphynx	Donskoy	Don Hairless	All of these	All of these	3
2093	This cat breed occurred in Thailand, has very slim elongated body, short fur and very large ears.	Oriental Shorthair	Selkirk Rex	Singapura	Siamese	Oriental Shorthair	3
2094	This exotic cat breed was developed in Kenya by crossbreeding between a Serval and a domestic cat.	Bengal	Maine Coon	Egyptian Mau	Savannah	Savannah	3
2095	This cat breed with curly hair appeared as a natural mutation in the United States.	Selkirk Rex	LaPerm	Kurilian Bobtail	American Curl	LaPerm	3
2096	What cat breed, which originated in France, has thick waterproof grey fur, gold-colored eyes and large muscular body?	Chartreux	Chausie	Pixie-bob	LaPerm	Chartreux	3
2097	To what geographic area is the ostrich native?	Asia	Africa	South America and Africa	Europe and Africa	Africa	3
2098	The feathers of adult male ostriches are primarily of this color.	White	Gray	Brown	Black	Black	3
2099	How many toes do ostriches have?	One toe	Two toes	Tree toes	Five toes	Two toes	3
2100	What important internal organ does the ostrich lack?	Liver	Gallbladder	Spleen	All of these	Gallbladder	3
2101	What defense method do ostriches use when they are attacked or feel threatened?	All of these	They bury their heads in the sand.	Kicking	They use their wings to beat the enemy.	Kicking	3
2102	What does the diet of ostriches consist of?	Insects	All of these	Seeds	Grass	All of these	3
2103	What unusual anatomical feature does the male ostrich possess?	It has four testicles.	It has a copulatory organ.	It has a very small horn on its head.	All of these	It has a copulatory organ.	3
2104	Which is the largest subspecies of ostrich on the planet?	Southern Ostrich	Masai Ostrich	Red-necked Ostrich	Middle Eastern Ostrich	Red-necked Ostrich	3
2105	Unlike other ostriches, this subspecies of ostrich has small feathers on its head.	Arabian Ostrich	Masai Ostrich	Somali Ostrich	North African Ostrich	Masai Ostrich	3
2106	Which subspecies of ostrich became extinct around 1966?	Red-necked Ostrich	Middle Eastern Ostrich	Southern Ostrich	Somali Ostrich	Middle Eastern Ostrich	3
2107	What are the anatomical differences between African elephants and Asian elephants?	All of these	In the tusks	In the ears	In the body size	All of these	3
2108	Which elephant subspecies is the largest on the planet?	Sri Lankan Elephant	Indian Elephant	Forest Elephant	Savanna Elephant	Savanna Elephant	3
2109	Which is the smallest elephant subspecies on the planet?	Forest Elephant	Sumatran Elephant	Indian Elephant	Sri Lankan Elephant	Sumatran Elephant	3
2110	What elephant species has two fingerlike projections at the end of its trunk?	Asian Elephant	All of these	African Elephant	Sri Lankan Elephant	African Elephant	3
2111	What does the diet of elephants mostly consist of?	Leaves	Twigs	Grasses	Tree bark	Grasses	3
2112	What statement is true about elephants mammary glands?	They have two pairs of mammary glands.	None of these	They have one pair of mammary glands.	They have only one mammary gland.	They have one pair of mammary glands.	3
2113	How long does the gestation period of elephants last?	22 months	30 months	18 months	12 months	22 months	3
2114	How do elephants protect their skin from the aggressive UV-radiation?	By wallowing in their own feces	By hiding in the shadow of thick branches	By wallowing in mud	None of these	By wallowing in mud	3
2115	Why isnt the baby elephant able to control its trunk?	All of these	Because it is too heavy for it	Because it cannot feel it	Because it lacks muscle tone	Because it lacks muscle tone	3
2116	Cockroaches belong to the order Blattaria. What is the meaning of the Latin word blatta?	Cockroach	Annoying	Fast	Pest	Cockroach	3
2117	Apart from the American cockroach, what other cockroach species is among the best-known pests?	Oriental cockroach	Asian cockroach	German cockroach	All of these	All of these	3
2196	What should a person do to escape the attack of a wombat in the wild?	Climb a tree	Run	Play dead	Jump in a river	Climb a tree	3
2118	Which of these statements is true about the anatomy of cockroaches?	They have two ocelli, or simple eyes.	They have two long antennae on their heads.	All of these	They have large compound eyes.	All of these	3
2119	Which of these statements is true about cockroaches?	They are wingless and have six legs.	They have two pairs of wings and six legs.	They have two wings and eight legs.	They have have two wings and six legs.	They have two pairs of wings and six legs.	3
2120	What kind of interesting noise are cockroaches known to produce when they feel threatened?	Hissing	Crackling	Whistling	All of these	Hissing	3
2121	What organs do cockroaches use for the purpose of respiration?	All of these	Gills	Lungs	Tracheae	Tracheae	3
2122	Which of these statements is true about the reproduction of cockroaches?	All of these	Male roaches use court rituals to attract the female.	A few species can reproduce through parthenogenesis, or without the need of fertilization.	Males and females attract each other through pheromones.	All of these	3
2123	How are cockroaches classified according to the way they deliver their young?	They are viviparous.	All of these	They are ovoviviparous.	They are oviparous.	All of these	3
2124	Which of these statements is true about the cockroaches ability to survive in hard times?	They are able to slow down their heart rate.	Cockroaches can survive radiation up to 15 times stronger than the lethal dose for humans.	Some roaches can survive without food for about one month.	All of these	All of these	3
2125	The pregnancy of this animal lasts from 2 to 3 years depending on the altitude it inhabits.	Spanish Imperial Eagle	Asian Elephant	All of these	Alpine Salamander	Alpine Salamander	3
2126	These animals are usually monogamous and both parents take care of their young.	Hedgehogs	Swans	All of these	Wolves	Swans	3
2127	For which of these animals is the following description true: The gestation period lasts 35�58 days. Smaller species have 5-6 babies, and larger species - 3-4 babies. The young are born blind.	Hedgehog	Lizard	Fox	Rabbit	Hedgehog	3
2128	Which of the following statements is true about scorpions?	They give birth to their young one by one.	They lay the eggs and they hatch almost immediately.	They lay eggs which hatch after 2 weeks.	None of these	They give birth to their young one by one.	3
2129	The Gastric-brooding frog is an extinct species that is famous for this unique way of incubating its eggs.	The mother keeps the eggs inside her mouth until they hatch.	The female keeps the fertilized eggs in pouches along her abdomen.	The female keeps the eggs between her rear legs until they hatch.	The mother swallows the eggs and incubates them inside her stomach.	The mother swallows the eggs and incubates them inside her stomach.	3
2130	Which of these statements is true about the Jacksons Chameleon?	It lays about 15-30 eggs that hatch in 10 days.	It gives birth to 8-30 live young.	It lays about 5-10 eggs that hatch immediately.	It gives birth to 2-3 live young.	It gives birth to 8-30 live young.	3
2131	Which of these statements is true about the Echidna, an egg-laying mammal?	The female lays 1 egg that hatches immediately.	The female lays 1 egg which she incubates in her pouch.	The female lays 3-5 eggs and incubates them for 26 days.	The female lays 2 eggs that are incubated by the male for 22 days.	The female lays 1 egg which she incubates in her pouch.	3
2132	Which of these statements is true about the German cockroach?	The female carries her eggs in a capsule.	The female lays about 40 eggs.	All of these	In rare cases live births can occur.	All of these	3
2133	Which of these statements is true about the Seahorse?	All of these	The male Seahorse has a brooding pouch on the front side of his body.	The male and the female stay together for life.	The female produces dozens to thousands of eggs.	All of these	3
2134	Which of these statements is true about the King Penguin?	They are serially monogamous.	Both parents take part in the incubation.	All of these	The female lays 1 single egg.	All of these	3
2135	What name is commonly used to refer to the guinea pig?	Netty	Poppy	Willy	Cavy	Cavy	3
2136	How many times per year is a healthy female guinea pig able to give birth?	Twice	Seven times	Five times	Once	Five times	3
2137	What geographic area did the guinea pig originate from?	South America	Africa	Australia and New Guinea	North America	South America	3
2138	What term is commonly used to refer to the young of the guinea pig?	Pups	Kits	Calves	Piglets	Pups	3
2139	What type of food does the guinea pig naturally feed on?	Grass	Grains	Green leaved	Nuts	Grass	3
2140	The guinea pig is unable to produce this substance in its own body and gets it from its food.	Saliva	Vitamin C	Stomach acid	Digestive enzymes	Vitamin C	3
2141	What plant is poisonous for guinea pigs and should never be offered to them?	All of these	All plants growing from a bulb	Bracken	Wild celery	All of these	3
2142	In this 2009 Walt Disney action comedy movie the main characters are guinea pigs.	G-Force	The Fast and the Furry	Darwin	Fluffy Spies	G-Force	3
2143	What actor voiced the guinea pig character called Rodney in the 1998 comedy movie Dr. Dolittle?	Jim Carrey	Chris Tucker	Eddie Murphy	Chris Rock	Chris Rock	3
2144	The representatives of what guinea pig breed have extremely long hair that never stops growing all over their bodies?	Teddy	Texel	Abyssinian	Peruvian	Peruvian	3
2145	Captive raccoons are known for performing this vacuum activity.	Dousing their food	Scratching their belly	Playing dead	All of these	Dousing their food	3
2146	Which of these regarding the reproduction of raccoons is correct?	Pregnancy can last from 54 to 70 days.	The male brings food for the young.	None of these	Females usually give birth to only one kit.	Pregnancy can last from 54 to 70 days.	3
2147	What animal is a major predator for wild raccoons?	Coyote	Bald eagle	Bobcat	All of these	All of these	3
2148	Raccoons are omnivorous animals but they have a preference for this type of food.	Invertebrates	Birds	Fruits and nuts	Fish	Fruits and nuts	3
2149	What is the most important sense for raccoons?	Vision	Sense of smell	Hearing	Sense of touch	Sense of touch	3
2150	Why is it not recommended to be keep raccoons as pets?	They have and intense odor.	Their fur promotes allergies.	They transmit many diseases.	They can be aggressive.	They can be aggressive.	3
2151	What have raccoons been mostly hunted for throughout history?	Their fur	Their bones	Their meat	Their fat	Their fur	3
2152	What popular cartoon character from a 1995 animated movie keeps a raccoon as a pet?	Simba	Shrek	Pocahontas	Mulan	Pocahontas	3
2153	Studies of raccoons intelligence have shown that raccoons are capable of performing this activity.	Opening locks	Understanding spoken words	Painting	Differentiating sounds	Opening locks	3
2280	What is the term denoting a group of zebras that live together?	Harem	Pack	Stud	Herd	Harem	3
2154	The Ramphotyphlops braminus, a harmless blind snake species, found in Africa and Asia, is often mistaken for this animal.	Black mamba	Dog-faced water snake	Elephant Trunk Snake	Earthworm	Earthworm	3
2155	How are the young Box turtles classified according to their diet, which differs from the diet of mature Box turtles?	Specialized eaters	Omnivores	Carnivores	Herbivores	Carnivores	3
2156	What distinctive feature is characteristic of the crocodile species called gharial, or Indian gavial?	Very short tail	Red spots on its back	Narrow snout	Purple scales	Narrow snout	3
2157	How did the glass lizard, also known as glass snake, get its interesting name?	It can climb on glass.	Its eyes are glass-like.	It is almost transparent.	It breaks easily.	It breaks easily.	3
2158	What other common name is used for the New Caledonian bumpy gecko, a reptile found only on the southern end of the island of New Caledonia?	All of these	Gargoyle gecko	Devil gecko	Horny gecko	Gargoyle gecko	3
2159	This snake, the only existing member of its family, can be found in Mexico and has a very muscular body and a shovel-shaped snout.	All of these	Dwarf boa	Pipe snake	Loxocemidae bicolor	Loxocemidae bicolor	3
2160	What is unique about the reptile called tuatara, which is endemic to New Zealand and is sometimes called living fossils?	It has a well-developed third eye.	All of these	It has two rows of teeth in the upper jaw.	It is able to hear though it has no ears.	It is able to hear though it has no ears.	3
2161	What feature of the turtle species Dermochelys coriacea makes it easily distinguishable from all the other sea turtles?	It has a very long tail.	It has no shell.	Its body has very vivid colors.	It has a horn on its head.	It has no shell.	3
2162	In what geographical area is the Rock monitor lizard, or Legavaan, found?	South America	New Guinea	Australia	Africa	Africa	3
2163	What is the smallest extant species of crocodilian on the planet?	Smooth-fronted Caiman	Musky Caiman	Spectacled Caiman	Yacare Caiman	Musky Caiman	3
2164	Where is the natural habitat of sloths?	Central and South Asia	Central and South America	Australia and the island of Tasmania	South Africa	Central and South America	3
2165	Which of these is true about the sloths diet?	Sloths are carnivores.	Sloths are autotrophic organisms.	Sloths are herbivores.	Sloths are omnivores.	Sloths are omnivores.	3
2166	Sloths have this number of toes and fingers depending on the family they belong to.	Two or three	Sloths do not have toes.	Four or five	One or two	Two or three	3
2167	What is the the body length of an average mature sloth from head to tail?	90-100 centimeters	70-80 centimeters	30-40 centimeters	50-60 centimeters	50-60 centimeters	3
2168	How many hours of sleep do sloths normally need per day?	20-22 hours	12-13 hours	Less than 10 hours	15-18 hours	Less than 10 hours	3
2169	How long does it take for a sloth to digest its food completely?	1 week	More than 2 weeks	A month or more	About 3 months	A month or more	3
2171	How many babies do female sloths give birth to per one pregnancy?	Four	Three	One	Two	One	3
2172	Which of the following statements is wrong?	There are seven living species of sloths.	Two-toed sloths have only six cervical vertebrae instead of seven.	Sloths hairs grow away from their extremities instead of towards them.	Three-toed sloths have nine cervical vertebrae instead of seven.	There are seven living species of sloths.	3
2173	What type of mammal is the kangaroo?	Monotreme	All of these	Amniote	Marsupial	Marsupial	3
2174	What term is used to refer to the young of the kangaroo?	Joey	Mary	Jack	Wally	Joey	3
2175	Which kangaroo species is the largest on the planet?	Antilopine Kangaroo	Western Grey Kangaroo	Eastern Grey Kangaroo	Red Kangaroo	Red Kangaroo	3
2176	What is the difference between the digestion of kangaroos and the digestion of ruminants?	Nothing	Kangaroos need to consume some animal matter to provide essential digestive bacteria.	Kangaroos do not release methane.	Kangaroos digest plant matter five times faster than ruminants do.	Kangaroos do not release methane.	3
2177	What does the diet of all kangaroos consist of in general?	All of these	Plant matter	Fungi	Plant and animal matter	Plant matter	3
2178	Apart from jumping, kangaroos are known for fleeing from predators using this tactic.	All of these	Playing dead	Climbing	Swimming	Swimming	3
2179	What kangaroo species set a record by moving with 64 kilometers per hour (40 mph)?	Eastern Grey Kangaroo	Great Grey Kangaroo	All of these	Forester Kangaroo	All of these	3
2180	Male Western Grey Kangaroos were nicknamed Stinkers because they have this kind of odor.	Sour cabbage	Curry	Garlic	Gasoline	Curry	3
2181	How do male kangaroos fight to win the privilege to fertilize the female?	They push each other.	All of these	They kick each other.	They hit each other by boxing.	All of these	3
2182	What is the meaning of the word kangaroo according to legend?	I dont know.	Look at this!	I dont understand you.	What is this?	I dont understand you.	3
2183	What other common name is used for a mudpuppy?	Water Canine	Waterdog	Mud Dog	Salamander	Waterdog	3
2184	What type of animal is a mudpuppy?	skink	eel	fish	salamander	salamander	3
2185	What is the average lifespan of a mudpuppy?	2 years	5 years	11 years	35 years	11 years	3
2186	Which of these statements is true about the mudpuppy?	They are nocturnal.	They live in and out of the water.	They are poisonous.	Their lifecycle is divided into three stages.	They are nocturnal.	3
2187	In which of the following states will you not find the mudpuppy?	Texas	Indiana	Kentucky	Ohio	Texas	3
2188	How long is the average mudpuppy?	1 1/2 -3 inches	5-7 inches	12 inches	13-16 inches	13-16 inches	3
2189	Wombats are endemic to this geographical area.	Australia and Tasmania	South America	Madagascar	Indonesia and the Philippines	Australia and Tasmania	3
2190	What does the diet of wombats consist of in general?	Small vertebrates	Insects	Plants	All of these	Plants	3
2191	How many babies does the female wombat give birth to every spring?	Three	Four	Two	One	One	3
2192	What unusual anatomical feature do wombats possess?	Their pouch faces backwards.	They dont have a spleen.	They dont have eyelids.	All of these	Their pouch faces backwards.	3
2193	Which of these wombat species is also known as Coarse-haired Wombat?	Southern Hairy-nosed Wombat	Northern Hairy-nosed Wombat	Common Wombat	None of these	Common Wombat	3
2194	What way of defence do wombats use when they feel threatened?	All of these	Running	Climbing on trees	Kicking	Kicking	3
2198	Which continent does the turtle-dove migrate to in the colder winter months?	Africa	Australia	North America	Asia	Africa	3
2199	Which of the following statements is true about the turtle-dove?	They are not related to the pigeon.	They have never been domesticated.	They are flightless	They are viewed as a symbol of love.	They are viewed as a symbol of love.	3
2200	What is the expected lifespan of a turtle-dove?	28 years	9 months	7 years	20 years	20 years	3
2201	What is the incubation period for turtle-dove eggs?	7 weeks	17-25 days	12-14 days	1 month	12-14 days	3
2202	Which of the following makes the turtle-dove different from other birds?	They suck to drink instead of tilting their heads back.	When they hatch they can fly within 2 days.	They cannot make any sound.	They can fly backwards.	They suck to drink instead of tilting their heads back.	3
2203	What are the main colors of turtle-doves?	Dark orange and gray	Brown and gray	Pale yellow and some black	blue and red	Brown and gray	3
2204	Which of these statements is not true about the vision of bats?	Most smaller bat species are blind.	All of these	All bat species are able to detect UV light.	All bat species have underdeveloped eyesight.	All of these	3
2205	What important bone-building mineral do the cartilage of bats finger bones lack, which makes them very flexible?	Potassium	Magnesium	Calcium	Iron	Calcium	3
2206	What do megabats, also called flying foxes, feed on?	All of these	Carrion	Insects	Fruit and nectar	Fruit and nectar	3
2207	How do most bat species spend the cold winter months?	They migrate south to to regions with warmer climates.	They do not change their behavior in the winter.	None of these	They hibernate.	They hibernate.	3
2208	A bat is featured on the coat of arms of this Spanish city.	Palma de Mallorca	Fraga	Valencia	All of these	All of these	3
2209	What status does the bat have in Chinese folklore and tradition?	It is believed to be an incarnated spirit.	It is a symbol of happiness and longevity.	It is considered a bad omen.	It is considered simply a pest.	It is a symbol of happiness and longevity.	3
2210	What city in the US state of Texas is a home of the largest bat colony in North America during the summer?	Morton	Austin	Houston	Pittsburg	Austin	3
2211	What name is commonly used when referring to the bat species Vampyrum spectrum, also known as False Vampire Bat?	Phantom Bat	Spectral Bat	All of these	Ghostly Bat	Spectral Bat	3
2212	What bat species is considered the largest in the world?	Livingstone�s Fruit Bat	Fijian Monkey-faced Bat	Hammer-headed bat	Golden-capped fruit bat	Golden-capped fruit bat	3
2213	What other common name is used for the Kittis Hog-nosed Bat, the smallest bat species in the world?	Wasp bat	Hummingbird bat	Bumblebee bat	Ladybug bat	Bumblebee bat	3
2214	During what geological time period did the ammonites evolve?	The Devonian period	The Silurian period	The Triassic period	The Carboniferous period	The Devonian period	3
2215	Name the largest known species of ammonite, which was found in Germany in 1895.	Parapuzosia seppenradensis	Allonautilus perforatus	Nautilus pompilius	Parapuzosia bradyi	Parapuzosia seppenradensis	3
2216	What is the greatest depth the shell of a nautilus can withstand before imploding?	800 meters	100 meters	300 meters	187 meters	800 meters	3
2217	What is the average lifespan of a nautilus?	10 years	20 years	2 years	40 years	20 years	3
2218	Ammonites became extinct at the end of what geological period?	Cretaceous	Jurassic	Triassic	Permian	Cretaceous	3
2219	What flower remedy would be most beneficial to a stand-offish horse that gets irritated quickly and has a hard time accepting change?	Birch	Cerery	Beech	Cerato	Beech	3
2220	Up to how many different Bach remedies can you combine?	4	as many as you want to	1	7	7	3
2221	Which of the following is used as a cleansing remedy?	Cherry Plum	Gentian	None of these	Crab Apple	Crab Apple	3
2222	Salix vitellina is the scientific name of this essence usually given to a horse that appears to sulk, goes into moods and refuses any sort of attention.	Wild Rose	Wild Oat	Willow	Water Violet	Willow	3
2223	What kind of animals are the colugos, or cobegos, which is found only in Asia?	Mammals	Reptiles	Birds	Amphibians	Mammals	3
2224	What other name is commonly used for the Japanese Macaque, a monkey native to Japan?	Snow Monkey	All of these	Whistling Monkey	Storm Monkey	Snow Monkey	3
2225	Which of these Asian tortoise species is a very popular pet in many countries around the world?	Cuora	Russian Tortoise	Keeled Box Turtle	Rafetus	Russian Tortoise	3
2226	What is the color of the legs, bill and eye rims of the Green Magpie, a small Asian bird with bright green plumage?	Purple	Blue	Red	Bright pink	Red	3
2227	To which Asian country is the Giant Panda native?	Indonesia	India	Japan	China	China	3
2228	What is the name of the smallest bat species on the planet, endemic to the Asian continent?	Mouse-tailed Bat	Sucker-footed Bat	Bulldog Bat	Kittis Hog-nosed Bat	Kittis Hog-nosed Bat	3
2229	What name is used for the enigmatic bovid mammal Kting Voar, which is believed to populate Cambodia and Vietnam in Asia?	Snake-eating Cow	Lizard-eating Goat	All of these	Frog-chewing Sheep	Snake-eating Cow	3
2230	What sense of the Malayan Tapir, also called Asian Tapir, is underdeveloped?	Eyesight	Hearing	Smell	Touch	Eyesight	3
2231	How many horns does the Indian Rhinoceros, found only in Asia, have on its snout?	None	Two	Three	One	One	3
2232	What is the favorite food of the Fairy-bluebird, which is found only in Asia?	Goji berries	Grasshoppers	All of these	Figs	Figs	3
2233	What term is used the denote the terrestrial stage of the development of the young newt?	Eft	Imago	Elf	Larva	Eft	3
2234	To what country is the Rhinoderma rufum, a species of frog from the family Rhinodermatidae, endemic?	India	United States	Chile	Brazil	Chile	3
2235	What is the literal translation of the Greek word amphibios, from which the modern word amphibian originated?	Water and land	Both kinds of life	Two in one	Water and air	Both kinds of life	3
2236	What interesting characteristic do all amphibians called caecilians share?	They have no legs.	They are hermaphrodites.	They have four eyes.	They have external ears.	They have no legs.	3
2237	What animal does the greater siren, a nocturnal amphibian, resemble externally?	An eel	A lizard	A gecko	A frog	An eel	3
2238	Which of these statements is wrong about the Glass frogs from the amphibian family Centrolenidae?	They are arboreal animals.	They are found mainly in Australia and Tasmania.	All of these	Their skin is transparent.	They are found mainly in Australia and Tasmania.	3
2281	Unfortunately this fictional dog is constantly bullied by his buddy cat.	Snoopy	Lucky	Goofy	Odie	Odie	3
2284	What is the real name of the dog who first played the fictitious dog Benji in the series of Benji films?	Benji	Higgins	Arnold	Lassie	Higgins	3
2239	What other interesting name is used commonly to refer to the Purple frog, an amphibian endemic to the Western Ghats in India?	Pignose Frog	Chicken frog	All of these	Mole frog	Pignose Frog	3
2240	What does the diet of the Eastern Tiger Salamander mainly consist of?	Shrimp	Leaves	Insects	Fish	Insects	3
2241	What behavior is typical of the Argentine horned frog, also known as Argentine wide-mouthed frog?	It never stops moving.	It sings almost incessantly.	It would eat up anything that comes in its eyesight.	All of these	It would eat up anything that comes in its eyesight.	3
2242	Where does the female Suriname Toad keep its eggs until they develop into young frogs?	In its vocal sac	Between its hind legs	On its back	In its stomach	On its back	3
2243	How many orders of trilobite are there?	9	3	15	10	10	3
2244	What order of trilobite was the only one to survive the Devonian mass extinction?	Proetida	None of these	Phacopida	Lichida	Proetida	3
2245	Approximately how many species of trilobite existed over the duration of the Paleozoic?	12,000	9,000	17,000	18,000	17,000	3
2246	What genus and species did the largest complete trilobite fossil ever found belong to?	None of these	Isotelus rex	Isotelus maximus	Isotelus brachycephalus	Isotelus rex	3
2247	The pygidium refers to what section of a trilobites body?	The head	None of these	The thorax	The tail	The tail	3
2248	Which of the following is believed to be an ancestor of the trilobites?	Onega	None of these	Spriggina	Trichophycus	Spriggina	3
2249	To what geographical region is the Aye-aye indigenous?	Madagascar	New Zealand	Tasmania	Hawaii	Madagascar	3
2250	Which of these statements is true about the lemur Aye-aye?	It is the second smallest primate on the planet.	It is the second largest primate in the world.	It is the smallest nocturnal primate in the world.	It is the largest nocturnal primate on the planet.	It is the largest nocturnal primate on the planet.	3
2251	What physical feature does the lemur Aye-aye share with rodents, leading to its original classification in order Rodentia?	Very large incisors	Inability to vomit	All of these	Similarities in the digestive system	Very large incisors	3
2252	What unusual physical characteristic does the lemur Aye-aye possess?	Its pupils are constantly dilated.	It has 4 nipples.	It has extremely long fingers.	All of these	It has extremely long fingers.	3
2253	In what places does the nocturnal Aye-aye sleep during the daytime?	On a branch, covering its body with a big leaf	Hanging from a branch.	On trees	In holes in the ground	On trees	3
2254	Where did the name of the Aye-aye originate from according to common hypothesis?	All of these	From the Malagasy expression for I dont know	From the sound made by the animal	From an exclamation	All of these	3
2255	How is the lemur Aye-aye classified according to its diet?	Herbivore	Omnivore	Carnivore	Specialized eater	Omnivore	3
2256	What is the Aye-aye traditionally associated with according to ancient Malagasy legends?	Future marriage	Rain	Luck	Death	Death	3
2257	What is the name of the Aye-aye character from the 2005 animated comedy movie Madagascar?	Maurice	Marty	Mort	King Julien	Maurice	3
2258	To what geographic area is the koala endemic?	Tasmania	Australia and Tasmania	Australia	Australia and New Guinea	Australia	3
2259	What unique feature do the the fingers of the koala possess?	There are six fingers on each leg.	They have fingerprints.	All of these	Each finger consist of 10 bones.	They have fingerprints.	3
2260	What does the diet of the koala almost exclusively consist of?	Eucalyptus leaves	Grass	All of these	Insects	Eucalyptus leaves	3
2261	What term is used to refer to the infant koala, as well as to any other baby marsupial?	Jerry	Joey	Jimmy	Jelly	Joey	3
2262	Which of these statements is true about koalas?	All of these	Keeping a koala as a pet is legal in the USA.	They were nearly erased from the planet due to hunting in the early 20th century.	In August 1927, 100 000 koalas were killed.	They were nearly erased from the planet due to hunting in the early 20th century.	3
2263	This fictional koala character, created by author Dorothy Wall, fist appeared in the 1933 book Jacko - the Broadcasting Kookaburra.	Nutsy	Jeremy	Noozles	Blinky Bill	Blinky Bill	3
2264	What unusual anatomical characteristic does the koala possess?	The female has two vaginas.	The female has two uteri.	The make has a bifurcated penis.	All of these	All of these	3
2265	The koala is the only animal species on the planet to possess this quality.	All of these	It sleeps with open eyes.	When its hungry, it starts sucking on its tail.	Its brain size is extremely reduced.	Its brain size is extremely reduced.	3
2266	What does the Greek word Phascolarctos, denoting the genus to which koalas belong, mean?	Ash-colored	Pouch bear	Doesnt drink	Monkey bear	Pouch bear	3
2267	When anxious, the koala produces a loud sound similar to the cry made by this creature.	Baby bear	Crow	Human baby	Rabbit	Human baby	3
2268	What is the literal meaning of the word giraffe considering its Arabic origin?	Unbelievable	Ambiguous	Scary	Tall	Tall	3
2269	Which of these statements is wrong?	All of these	The giraffe is the largest ruminant.	The giraffe is the only surviving member of its family.	The giraffe is the only surviving member of its genus.	The giraffe is the only surviving member of its genus.	3
2270	What term is used for the behavior exhibited by male giraffes that are engaged in a fight?	Hoofing	Tailing	Necking	Horning	Necking	3
2271	Giraffes sometimes use their extremely long blue tongues for this purpose.	Cleaning insects from their face	Stealing eggs from birds nests	Playing games with other giraffes	All of these	Cleaning insects from their face	3
2272	Which of these giraffe subspecies is easily distinguished by the very light colored spots on its body?	All of these	South African Giraffe	Somali Giraffe	West African Giraffe	West African Giraffe	3
2273	The horns of which giraffes are very often bald on top?	Babies	Females	Males	Very old giraffes	Males	3
2274	Of all mammals, giraffes require the least amount of which of the following?	Vitamins	Food	Water	Sleep	Sleep	3
2275	This artiodactyl mammal is the closest surviving relative of the giraffe.	Okapi	Tapir	Llama	Zebra	Okapi	3
2276	What is the largest living subspecies of giraffe on the planet?	Masai Giraffe	South African Giraffe	Rothschild Giraffe	Nubian Giraffe	Masai Giraffe	3
2277	What method of defense do giraffes most often employ against predator attacks?	None of these	Kicking	They use their horns	Standing still	Kicking	3
2278	What does the name of the zebra literally mean?	Wild ass	Funny horse	Striped	Black-and-white	Wild ass	3
2279	What animal is the number one predator of zebras?	Jackal	Lion	Hyena	Crocodile	Lion	3
2285	This dog, whose name means barker in Russian, became the first living creature from Earth to enter orbit.	Mandy	Laika	Lucky	Sporty	Laika	3
2286	This dog, who first showed up in a Bud Light Beer Super Bowl ad, had a black circle around one eye.	Spuds MacKenzie	Blue MacKenzie	Long John	Spottie	Spuds MacKenzie	3
2287	Name the Red Baron hunting Beagle from Charles Schultz popular comic strip, Peanuts.	Scooby	Lassie	Odie	Snoopy	Snoopy	3
2288	This cartoon Great Dane often needs his nephew headstrong nephew to protect him.	Scooby	Odie	Scrappy	Snoopy	Scooby	3
2289	Which of these is the most distinctive feature of one of the largest marine creatures, which is also known to be the best diver - the sperm whale?	Its huge vivid eyes	Its extremely long tail	Its enormous head	The unique curvatures of its fins	Its enormous head	3
2290	Giant squids, for long believed to be mythical creatures, are a type of deep-ocean dwelling squid that can grow to a tremendous size. The giant squid also holds the record for the largest organ, in which of these bodily systems?	Digestive system	Visual system	Auditory system	Reproductive system	Visual system	3
2291	In Herman Melvilles Moby-Dick, the leading character Ahab, consumed with the desire for revenge for his lost leg, mindlessly pursues a whale nicknamed Moby Dick. What type of whale is Moby Dick, according to the book?	Sperm whale	Baleen whale	Blue whale	Humpback whale	Sperm whale	3
2292	This member of the oceanic dolphin family, named for its versatile predatory habits, cannot be mistaken with any other sea creature, due to its distinctive coloration - black back, white chest, sides, and a patch above and behind each eye.	Killer whale	Humpback dolphin	Pilot whale	Spinner dolphin	Killer whale	3
2293	In marine science, ichthyology, branch of zoology closely related to marine biology and oceanography, is the study of what?	Microscopic marine life	Fish	Marine mammals	Marine plant life	Fish	3
2294	Devilfish, a large species of ray, also called manta, was named such due to which of these characteristic features?	Its pointed tail	Two pointed lobes on each side of the head	Its hunting habits	Extended, winglike fins	Two pointed lobes on each side of the head	3
2295	Periplaneta americana, Blattella germanica and Gromphadorhina portentosa are all species of this insect.	House fly	Cockroach	Stick Insect	Butterfly	Cockroach	3
2296	It is the national insect of Canada and the state insect of Texas.	Ladybug	Cricket	Praying Mantis	Monarch butterfly	Monarch butterfly	3
2297	Many Royal Navy and US Navy ships are named after this fearful insect. Not just that, but an F/A-18 aircraft and a Honda motorcycle also carry its name.	Tarantula	Cicada	Hornet	Yellowjacket	Hornet	3
2298	The scarab, a sacred beetle to Ancient Egyptians, is commonly known as what?	Dung Beetle	Stag Beetle	June Bug	Noble Chafer	Dung Beetle	3
2299	What is the common length of a full grown male Komodo Dragon?	11 feet	8 feet	6 feet	9 feet	9 feet	3
2300	The Komodo Dragon is NOT native to which of these islands?	Rinca	Flores	Gili Motang	Savalhi	Savalhi	3
2301	How heavy was the largest verified wild Komodo Dragon?	154 lbs.	275 lbs.	200 lbs.	365 lbs.	365 lbs.	3
2302	What is the top speed that a Komodo Dragon can reach?	13 mph	6 mph	10 mph	27 mph	13 mph	3
2303	Which of these American zoos does NOT house Komodo Dragons?	Honolulu Zoo	Disneys Animal Kingdom	Memphis Zoo	Bronx Zoo	Bronx Zoo	3
2304	How fast can a black bear run?	61km/hour	48 km/hour	39 km/hour	53 km/hour	48 km/hour	3
2305	Which of the following is not a nickname for a polar bear?	White bear	Great bear	Northern bear	Sea bear	Great bear	3
2306	At what age can grizzly bears start to mate?	9 years	1 and a half year	7 weeks	4 and a half year	4 and a half year	3
2307	How many years does a mother grizzly stay with her cubs?	5 months to 10 months	1and a half to 3 and a half years	6 weeks to 1 year	7-8 years	1and a half to 3 and a half years	3
2308	How many polar bear subspecies are there?	0	3	5	1	0	3
2309	Which of these animals usually preys on black bear cubs?	Hedgehog	Garden snake	Cougar	Dog	Cougar	3
2310	What of these members of the bear family is the largest?	Black bear	Panda	Grizzly bear	Polar bear	Polar bear	3
2311	Where do orphaned grizzly cubs Grinder and Coola live?	Yukon	Northwest Territories	British Columbia	Ontario	British Columbia	3
2312	How many eggs does a turkey usually lay?	8-15	4-12	6-13	4-8	8-15	3
2313	How fast can a domestic cat sprint?	15 MPG	30 MPH	17 MPH	25 MPH	30 MPH	3
2314	Which of these statements if true about a cat?	Their urine glows under a black light.	Normal body temperature for a a cat is 95 degrees Fahrenheit.	They take about 50 breaths per minute.	They walk on the bottoms of their feet.	Their urine glows under a black light.	3
2315	According to a survey, what percentage of American cat owners admit to blow drying their feline after giving it a bath?	15%	70%	25%	5%	25%	3
2316	Which type of cat is almost always female?	Calico	White	Persian	Siamese	Calico	3
2317	Cats have 517 of these in their entire body.	Claws	Whiskers	Muscles	Bones	Muscles	3
2318	What year was the very first cat show held?	1895	1926	1877	1901	1895	3
2319	Which of these is not one of the most popular names for female cats in the USA?	Missy	Pumpkin	Socks	Tigger	Socks	3
2320	Finish this old phrase:	takes a message	climbs the curtains	takes a message	thinks its dinner time	en you call a dog, he comes right over to you. When you call a cat, she________________.	3
2321	On what continent can aardvarks be found?	Africa	Asia	South America	Australia	Africa	3
2322	What is the scientific name for an aardvark?	Troglodytes pan	Orycteropus afer	Loxodonta aficanus	Muscous domesticus	Orycteropus afer	3
2323	Aardvark is a word coming from the Afrikaans/Dutch that literally translates as what?	Long Nose	Ant Eater	Pig Like	Earth Pig	Earth Pig	3
2324	How many young can an adult aardvark have at one time?	6	up to one dozen	only 1	3	only 1	3
2325	What is the gestation period for an aardvark?	1 full year	9 months	3 months	7 months	7 months	3
2326	Which one of these statements about aardvarks is false?	Aardvarks are hunted for meat.	Aardvarks are color blind.	Aardvarks are nocturnal.	Aardvarks only eat termites.	Aardvarks only eat termites.	3
2327	What color was the aardvark from the Pink Panther cartoon?	Red	Blue	Pink	Gray	Blue	3
2328	What is the gestation period of a dolphin?	Varies by species	16 months	9 months	12 months	Varies by species	3
2329	Which of these is NOT a species of dolphin?	Eastern Dolphin	Orca	Pilot whale	False Killer Whale	Eastern Dolphin	3
2332	Where in the world can you find the dolphin known as the Boto?	Asia	Australia	South America	North America	South America	3
2333	What is the scientific name of the Common Raccoon?	Procyon cancrivorus	Procyon nelus	Procyon lotor	Procyon insularis	Procyon lotor	3
2334	Which of these in NOT a species of raccoon?	Common Raccoon	Tree Raccoon	Tres Marias Raccoon	Crab Eating Raccoon	Tree Raccoon	3
2335	How many young can an adult badger have at one time?	1-8	just 1	1-5	1-2	1-5	3
2336	Which of these is not a part of the badgers diet?	Insects	Birds	Ground squirrels	Rattlesnakes	Insects	3
2337	Which of the following octopuses could most easily kill a human?	The Common Octopus	The Blue Ringed Octopus	The Giant Pacific Octopus	Seven Armed Octopus	The Blue Ringed Octopus	3
2339	Which of the following best defines the octopus related word midden?	a pile of shells	a burrow in the sand used as a den	a hole in the rock face or corral used as a den	a chemical in the ink sprayed from an octopus siphon	a pile of shells	3
2340	Which of the following is the name for an octopuss tongue?	Siphon	Hemetoy	Mantle	Radula	Radula	3
2341	Octopuses have excellent vision. Which of the following statements about an octopuss vision is NOT true?	They can see well at night.	They can see in depth.	They can make out size and shape very well.	They can see in color.	They can see in color.	3
2342	Which of the following octopi has the scientific name Enteroctopus Dofleini?	None of these	Giant Pacific Octopus	Common Octopus	Blue Ringed Octopus	Giant Pacific Octopus	3
2343	Which of the following words is NOT related to the octopus?	Chemoreceptors	Chromatophores	Ambush	Tentacles	Tentacles	3
2344	How much could a full-grown Smilodon weigh?	525 lbs.	350 lbs.	450 lbs.	400 lbs.	450 lbs.	3
2345	Which species of Smilodon was the largest?	Smilodon fatalis	Smilodon populator	Smilodon locor	Smilodon gracilis	Smilodon populator	3
2346	Approximately how long ago did Smilodon become extinct?	5,000 years	20,000 years	10,000 years	15,000 years	10,000 years	3
2347	What king of habitat do Tomato Frogs live in?	in the snowy mountain tops	in marshes, shallow pools, flooded meadows, and wetlands	in dessert areas that are very arid and dry	in the salty ocean	in marshes, shallow pools, flooded meadows, and wetlands	3
2348	Tomato Frogs existence is threatened due to what reason?	Habitat destruction	Their legs are used for food in fine dining restaurants.	They are hunted for their oils that are used as a skin moisturizer.	Flooding	Habitat destruction	3
2349	When Tomato Frogs are in captivity at a zoo, what kind of food are they fed?	Grass, seaweed, and other vegetation	Small fish, such as minnows and guppies	Vitamin-dusted crickets and mealworms.	The same food they would eat in the wild	Vitamin-dusted crickets and mealworms.	3
2350	Manatees are found more commonly in Caribbean, Mexico, and Florida waters. Why?	The water is cool.	There is a better food variety.	The water is warm.	The water is salty.	The water is warm.	3
2351	Which of these do manatees use to communicate with their calves and other manatees?	Sounds	All of these	Touch	Movement	All of these	3
2352	Due to the presence of a specific protein in the blood plasma octopuses have this unusual blood color.	Blue	Black	Bright green	Fluorescent pink	Blue	3
2353	Some animals have an inborn instinct to swallow gastroliths in order to improve the breaking down of food inside their stomachs. What kind of objects are gastroliths?	Rocks	Plants that are rich in digestive enzymes	Insects	Excrements	Rocks	3
2354	Parthenogenesis (from Greek - virgin creation), an asexual way of reproduction without the need of fertilization, occurs naturally in these animals.	All of these	Birds	Reptiles	Fish	All of these	3
2355	Which of  the following statements is true about mosquitoes?	Only female mosquitoes suck blood.	Only male mosquitoes suck blood.	All mosquitoes on the planet drink blood.	Only baby mosquitoes drink blood.	Only female mosquitoes suck blood.	3
2356	What kind of respiratory organs do lungfish have?	They have both lungs and gills.	Lungfish do not have any respiratory organs. They absorb oxygen through their skin.	They breathe only with gills.	They do not have gills, they use their lungs for respiration.	They have both lungs and gills.	3
2357	Cockroaches are among the most resilient creatures on our planet. But how long can they survive without air?	60 minutes	45 minutes	10 minutes	2 hours	45 minutes	3
2358	Human skin has the unique ability to acquire a darker shade when exposed to UV-rays. What animals share this ability with us?	Dolphins and seals	Chimpanzees and gorillas	Pigs and hammerhead sharks	All reptiles and anthropoid apes	Pigs and hammerhead sharks	3
2359	Koalas almost exclusively feed on this type of food.	Bottle tree leaves	Tea tree leaves	Eucalyptus leaves	Bamboo leaves	Eucalyptus leaves	3
2360	Which of the following statements is true about snails?	None of these	Snails do have tooth-like formations.	Snails do not have any teeth or tooth-like formations.	Snails have real teeth very similar to those of mammals.	Snails do have tooth-like formations.	3
2361	Some sharks hardly ever stop swimming during their whole existence. What is the reason for this?	Some sharks are very desirable hosts for small parasitic creatures. Those sharks are constantly trying to escape from them by incessant swimming.	Sharks are highly anxious and easily agitated animals. They cannot stay in the same place for more than a few seconds.	Sharks are cold-blooded animals. If they stop moving their body temperature will decrease too much and will cause hypothermia, which can be lethal.	Some sharks have lost the ability to pump water through their gills, so they need to keep moving in order to stay alive	Some sharks have lost the ability to pump water through their gills, so they need to keep moving in order to stay alive	3
2362	The Mimic Leatherjacket, found in the tropical marine waters throughout the Indo-Pacific, mimics which poisonous fish?	Red Bass	Hogfish	Saddled Puffer	Stonefish	Saddled Puffer	3
2363	This primitive shark, with a brown thin eel-like body, has six pairs of gill slits and trident-like teeth.	Frilled shark	Tiger shark	Bull shark	Sharpnose seven-gill shark	Frilled shark	3
2440	This hairless cat has a dog-like face and folded ears.	Sphynx	Donskoy	Peterbald	Ukrainian Levkoy	Ukrainian Levkoy	3
2364	This fish, which resembles the Angel fish, is recognized by its brightly coloured and patterned body, as well as by the dark band across its eyes.	Butterfly fish	Purple queen	Cichlid	Clown fish	Butterfly fish	3
2365	The Parrot fish, found in the Atlantic Indian and Pacific Ocean reefs, was given its name for what reason?	Because of the shape of its body	Because it can fly a few metres above water	Because its body is in different flashy colours	Because of its beak-like mouth	Because of its beak-like mouth	3
2366	What is the other name of Mola mola, a fish generally considered to be the most massive bony fish in the world?	Filefish	Ocean Sunfish	Pufferfish	Triggerfish	Ocean Sunfish	3
2367	When threatened, this fish, also known as balloonfish, increases in size by swallowing water or air.	Bowfin	Porcupinefish	Bichir	Oar fish	Porcupinefish	3
2368	The zebrafish (Girella zebra), which can be recognised by its pale body and yellow fins, is endemic to which region?	Amazon River Basin	Australian waters	The Caribbean	Japan waters	Australian waters	3
2369	The Flashlight fish, has a light-producing organ, which contains luminescent bacteria. Where is this organ located?	On the dorsal fin of the fish	Below the eye of the fish	Above the eye of the fish	Between the eyes of the fish	Below the eye of the fish	3
2370	The catfishes Physailia pellucida and Kryptopterus bicirrhis, found in the mid-waters of Southeast Asia, use what kind of camouflage?	Transparency	Change their colour	Mimic algae	Mimic poisonous fish	Transparency	3
2371	The Giant Panda and which of the following serve as an Asian countrys national emblem?	The dragon	The Golden Lion Tamarin	The Chinese alligator	The South China Tiger	The dragon	3
2372	What is the gestation period of the Giant Panda?	40-50 days	60-90 days	90-120 days	95-160 days	95-160 days	3
2373	This animal is the second most expensive for zoos to maintain after the Giant Panda.	Lion	Elephant	Giraffe	Bear	Elephant	3
2374	The giant pandas diet is 99% this.	bananas	fish	honey	bamboo	bamboo	3
2375	Pandas live in the mountains in the Sichuan, Shaanxi, and Gansu provinces in this country.	Mongolia	Thailand	China	Korea	China	3
2376	At birth, pandas weigh about 4 ounces and are the size of a stick of butter. Which of these is NOT true about a newborn panda?	They are grey in color.	They nurse up to 14 times a day.	They are hairless.	They are blind.	They are grey in color.	3
2377	Pandas spend 10-16 hours a day eating, the rest of the time they are usually resting. When are pandas most active?	at dusk and at dawn	between 10am and 2pm	between 2p and 10pm	only at night	at dusk and at dawn	3
2378	When a panda is born, it is impossible to tell if it is male or female. How old is the panda before its gender is known?	3 months	1 year	4 years	6 months	4 years	3
2379	Which of these is TRUE about pandas?	They belong to the raccoon family.	They are poor climbers.	They were unknown to the Western world until the 1600s.	They are carnivores.	They are carnivores.	3
2380	How long does a panda usually live in captivity?	10 - 15 years	80 - 90 years	20 - 30 years	55 - 65 years	20 - 30 years	3
2381	The panda is the symbol of this conservation organization, formed in 1961.	Leave It Wild	The Conservation Society	The African Conservation Foundation	The World Wildlife Fund	The World Wildlife Fund	3
2382	How many stomachs does a starfish have?	1	0	2	5	2	3
2383	In which country is the Gohongaze Starfish considered an edible delicacy?	China	Italy	New Zealand	Japan	Japan	3
2384	There are two classes of starfish. Name them.	Salt Stars and Fresh Stars	Soft Stars and Hard Stars	Sea Star and Brittle Stars	Common Stars and Rare Stars	Sea Star and Brittle Stars	3
2385	Which of these is not a relative of the starfish?	Sea Urchin	Sea Cucumber	Sand Dollar	Sea Horse	Sea Horse	3
2386	What is located on the end of every arm of a starfish?	Ear	Whisker	Eye	Mouth	Eye	3
2387	Scorpions are active at night in order to avoid which of their predators?	Mice	Lizards	All of these	Centipedes	All of these	3
2388	Raccoons are usually nocturnal animals, and they are famous for dousing their food before eating it. This is actually an activity that imitates foraging for food at shores. What is the term for such an activity?	Vacuum activity	Vain activity	All of these	False activity	Vacuum activity	3
2389	What sense helps kiwis find food in the dark?	All of these	Sense of smell	Eyesight	Hearing	Sense of smell	3
2390	Kakapo is a nocturnal parrot indigenous to New Zealand. Due to its resemblance to this nocturnal animal, it is also called by its name.	Raccoon	Cat	Rat	Owl	Owl	3
2391	Mink are mainly active at night and they do not hibernate. Which of these animals is a predator of the American Mink?	All of these	Wolf	Owl	Coyote	All of these	3
2392	What animal is the largest nocturnal prosimian on the planet?	Gorilla	Mantled Guereza	Aye-aye	Olive Baboon	Aye-aye	3
2393	Catfish are bony fish that are active in the nighttime. How did they get their interesting name?	They have barbels that remind of cat whiskers.	They like to rub against objects like cats do.	They have cat eyes.	All of these	They have barbels that remind of cat whiskers.	3
2394	Fireflies are known for their ability to produce light of this color.	Yellow	All of these	Pale red	Green	All of these	3
2395	The Ocelot is a nocturnal cat that is also called by this name in certain regions.	All of these	McKenneys Wildcat	Jaguarete	Painted Leopard	All of these	3
2396	Tapeti is a nocturnal cottontail rabbit that is indigenous to these areas.	Central and South America	Australia and Tasmania	South Asia	South Africa and Madagascar	Central and South America	3
2397	What is the average speed dolphins can reach?	25.5 km/hr	14.5 km/hr	16.5 km/hr	38.5 km/hr	16.5 km/hr	3
2398	How deep can a bottlenose dolphin dive?	300 meters	800 meters	1250 meters	700 meters	300 meters	3
2399	How many different species of dolphins are there in the world?	15	48	32	12	32	3
2400	How do dolphins generally sleep if they are in the wild?	None of these	like land mammals	They dont sleep at all.	with only one brain hemisphere in slow-wave sleep	with only one brain hemisphere in slow-wave sleep	3
2401	Which is the smallest species of dolphin?	Maui Dolphin/Hectors Dolphin	The Spinner Dolphin	The Pacific White-Sided Dolphin	The Bottlenose Dolphin	Maui Dolphin/Hectors Dolphin	3
2402	Which of these statements is true about squirrels?	Some squirrel species are omnivorous.	Most squirrels are active in the daytime.	They cannot digest cellulose.	All of these	All of these	3
2403	Which of these statements is true about the tongue of the giraffe?	The animal uses it as a tool to remove insects from its face.	All of these	It is about 18 inches (45 centimeters) long.	It is tough.	All of these	3
2404	Which of these statements is true about elephants?	All of these	Their diet consists of 80% tree leaves.	They are able to digest 40% of their food.	They spend 8-10 hours a day eating.	They are able to digest 40% of their food.	3
2405	Which of these statements is true about grasshoppers?	They have salivary glands.	Their digestive tract secretes digestive enzymes.	They have two antennae on their heads.	All of these	All of these	3
2406	Which of these foods does the Canada goose include in its diet?	Green vegetation	All of these	Grains	Seaweeds	All of these	3
2407	Which of these statements is true about the digestive system of the Hoatzin, a herbivorous tropical bird?	All of these	It has teeth that it uses for mastication.	It has four stomachs.	It breaks down its food through bacterial fermentation.	It breaks down its food through bacterial fermentation.	3
2408	What is the meaning of the term graminivore?	an animal that feeds on fruit	an animal that feeds on seaweed	an animal that feeds on grass	an animal that feeds on tree leaves	an animal that feeds on grass	3
2409	What kind of herbivorous animals are the granivores?	Animals that feed on buds	All of these	Animals that feed on seeds	Animals that feed on fruit	Animals that feed on seeds	3
2410	Which of these statements is true about the diet of Green iguanas?	All of these	Young iguanas are known to eat the feces of mature iguanas.	Wild iguanas sometimes eat bird eggs.	They are primarily herbivorous.	All of these	3
2411	Which of these statements is true about the diet of the Sumatran rhinoceros?	It feeds mainly in the morning and before dusk.	It consumes about 220 lb (100 kg) of food daily.	All of these	Its diet is rich in protein and poor in fiber.	It feeds mainly in the morning and before dusk.	3
2412	Which of the following statements is not true about the reproduction of jaguars?	Jaguars gestation period is 93 - 105 days.	Female jaguars reach maturity earlier than males.	Both males and females provide parenting of the cubs.	Jaguars mate throughout the whole year.	Both males and females provide parenting of the cubs.	3
2413	How can jaguars be described in terms of social activity?	Solitary	Sociable	Group animals	None of these	Solitary	3
2414	All but one of the following activities are generally untypical for jaguars. Choose the one most natural to them.	Starting to eat their prey from the fleshy abdominal area	Stalking and ambushing their prey	Chasing their prey	Attacking humans	Stalking and ambushing their prey	3
2415	In nature adult jaguars are apex predators in the food chain. What does this mean?	They are not preyed on by other predators.	They feed only on other predators.	They do not hunt on other predators.	Besides hunting they also feed on plants.	They are not preyed on by other predators.	3
2416	The jaguar is the national animal of which of the following countries?	Brasil	Nicaragua	Peru	Costa Rica	Brasil	3
2417	Jaguars closely resemble which other big cats in physical appearance?	Tiger	Cheetah	Puma	Leopard	Leopard	3
2418	Jaguars appearance seems to vary across regions and habitats. How do forest jaguars differ from the jaguars in open areas?	Forest jaguars are generally darker and larger	Forest jaguars are generally and more spotted	Forest jaguars are generally darker and smaller	Forest jaguars are generally larger and lighter in fur color	Forest jaguars are generally darker and smaller	3
2419	What continent does the large Griffon Vulture inhabit?	Asia	All of these	Europe	Africa	All of these	3
2420	What common name is used to refer to the scavenging animals, representatives of the order Opiliones?	Waterbugs	Sweepers	Bumblebees	Harvestmen	Harvestmen	3
2421	What is the literal meaning of the word raccoon, which originates from the Algonquin word ahrah-koon-em and denotes a scavenging mammal?	One who grasps with their hand just like a human	One who rubs, scrubs and scratches with its hands	One who eats whatever is in front of them	One who washes their hands and their food before eating	One who rubs, scrubs and scratches with its hands	3
2422	What term is mainly used in literature to refer to a group of crows?	A mug	A plunder	A gaggle	A murder	A murder	3
2423	What term refers to the animal that is the result of crossbreeding between a male coyote and a female dog?	All of these	Coypup	Coydog	Dogote	Coydog	3
2424	What do the beetles from the genus Nicrophorus do after finding a carcass?	They remain right next to it and protect it violently.	They bury it.	They wait for it to decompose.	They tear it into small pieces.	They bury it.	3
2425	What hyena species is the largest surviving on the planet?	Aardwolf	Spotted Hyena	Striped Hyena	Brown Hyena	Spotted Hyena	3
2426	What kind of animals are the Yellow jackets, the scavenging and predatory animals belonging to the genera Vespula and Dolichovespula?	Flies	Wasps	All of these	Bees	Wasps	3
2427	Lions may be skilled predators, but they would also eat carrion. What animal is the lions preferred food?	Rhinoceros	Hippopotamus	Elephant	Wildebeest	Wildebeest	3
2428	Which of these names is commonly used for the carrion flies, belonging to the family Calliphoridae?	All of these	Greenbottle	Blow-flies	Cluster flies	All of these	3
2429	The diet of most parrots consists of this type of food.	Buds	Fruit	All of these	Seeds	All of these	3
2430	Which of these statements is true about the parrots breeding habits?	None of these	Parrots are polygamous.	Parrots are polyandrous.	Parrots are monogamous.	Parrots are monogamous.	3
2431	What is the color of the eggs of all parrot species?	White	Green	Multicolored	Blue	White	3
2432	Parrots are considered the most intelligent birds on the planet along with these birds.	Ravens	All of these	Jays	Crows	All of these	3
2433	These parrots are believed to be the best at imitating sounds and human speech.	Lory	Amazon Parrot	Cockatoo	African Grey Parrot	African Grey Parrot	3
2434	Larger parrot species have longer life spans than smaller ones. What is the average life span of a large parrot?	Up to 80 years	20-25 years	Up to 50 years	14-15 years	Up to 80 years	3
2435	What is the predominant color in Amazon Parrots plumage?	Yellow	White	Green	Blue	Green	3
2436	The heaviest parrot species on the planet is the Kakapo. What is the average weight that a normal mature Kakapo can reach?	1.5 to 2 kg	2 to 4 kg	2.5 to 3 kg	2 to 2.5 kg	2 to 4 kg	3
2437	Which of these makes Cockatoos different from other parrot species?	They have a gall bladder.	All of these	They are not so colorful as other parrots.	They have a headcrest.	All of these	3
2438	This cat breed has a wild markings and is a crossbreed between an Asian Leopard Cat and a domestic cat.	Bengal	Ocicat	Savannah	California Spangled Cat	Bengal	3
2439	This old breed of cat has long fur. It originated in the Middle East, and some of its representatives have a flat face.	Siamese	Chinchilla	Himalayan	Persian	Persian	3
2441	This large cat was is the result of crossbreeding between a domestic cat and a Jungle Cat.	All of these	Jungle Curl	Chausie	Mountain Cougar	All of these	3
2442	This cat breed originated in Russia and has a short fluffy tail.	Kurilian Bobtail	Siberian	Russian Blue	Manx	Kurilian Bobtail	3
2443	This cat breed is believed to have developed naturally in China. It has short golden brown fur with the so-called broken striped pattern and a large strong body.	Dragon Li	Oriental Bicolour	Korat	Cymric	Dragon Li	3
2444	What cat breed, also called the Greyhound of the cats, has no hair except for down?	Don Sphynx	Oriental Bicolour	Cornish Rex	Sokoke	Cornish Rex	3
2445	What cat breed has very thick short fur, large round eyes, round head and chubby cheeks?	Colorpoint Shorthair	British Shorthair	Selkirk Rex	European Shorthair	British Shorthair	3
2446	This breed of cat has a round head, large round eyes and very small ears bended forward and downward.	American Curl	Scottish Fold	Toyger	Ussuri	Scottish Fold	3
2447	What is the name of the communities formed by rabbits living together?	Herds	Schools	Flocks	Warrens	Warrens	3
2448	Which of these statements is true about the difference between rabbits and hares?	Hares live above the ground.	All of these	Unlike rabbits, hares are born with hair and are able to see.	Hares have longer ears than rabbits.	All of these	3
2449	Which of these statements is true about the digestive tract of rabbits?	Their cecum, together with the large intestine, comprises about 25-30% of rabbits digestive tract.	They are hindgut digesters.	All of these	Their cecum is about 5 times bigger than their stomach.	They are hindgut digesters.	3
2450	What is the common name of cecotropes, products of the cecum which rabbits reingest to get nutrients?	Rabbit pellets	False feces	All of these	Night feces	Night feces	3
2451	Which of these types of food do rabbits prefer to include  in their daily diet?	Grass	Leafy weeds	Forbs (such as sunflowers)	All of these	All of these	3
2452	Which of these statements is true about the behavior of rabbits?	They are very easily startled.	They run and hide immediately when they feel threatened.	They are always alert.	All of these	All of these	3
2453	What is the name used for young rabbits?	Kittens	Fluffles	Puppies	Conies	Kittens	3
2454	What are rabbits associated with in Aztec mythology?	Drunkenness	Parties	All of these	Fertility	All of these	3
2455	What is the place of rabbits in Japanese tradition and mythology?	They are despised as being too timid.	They are believed to inhabit the Moon.	They are considered omnipotent.	Rabbits are not a part of Japanese mythology.	They are believed to inhabit the Moon.	3
2456	Scorpions are not found naturally in this geographical area.	Australia	Europe	New Zealand	All of these	New Zealand	3
2457	What name is used to refer to the scorpion species also known as Omdurman scorpion, and Israeli desert scorpion?	Bonebreaker	Windchaser	Deathstalker	Nightkiller	Deathstalker	3
2458	Scorpions are known to glow when exposed to this type of light.	All of these	Infrared light	Laser light	Blacklight	Blacklight	3
2459	What distinctive anatomical characteristic do the scorpions from the Hemiscorpiidae family possess, which makes them easily recognizable?	They have only four legs.	Their sting is intense red	Their body is flat and broad.	All of these	Their body is flat and broad.	3
2460	Where does the female scorpion raise its young?	On her back	In the roots of plants	Under her abdomen	In burrows in the ground	On her back	3
2461	Which of these statements is wrong about the reproduction of scorpions?	Most scorpions reproduce through parthenogenesis.	All of these	Most scorpion species are hermaphrodites.	Most scorpions reproduce asexually.	All of these	3
2462	What does the diet of scorpions usually consist of?	Insects	All of these	Worms and maggots	Plant matter	Insects	3
2463	What type of behavior is characteristic of scorpion species?	Photophobic behavior	Hydrophobic behavior	All of these	Phonophobic behavior	Photophobic behavior	3
2464	Scorpion venom is regarded as a potential source of chemicals that can be used in the treatment of this disease.	Autoimmune disorders	Cancer	Multiple sclerosis	All of these	All of these	3
2465	What common name is used to refer to the insects from the subfamily Triatominae, mainly found in the Americas?	Kissing bugs	Lollipop bugs	Microphone bugs	Pretty bugs	Kissing bugs	3
2466	What is the largest extant butterfly species on the planet?	Rajah Brookes Birdwing	Goliath Birdwing	Queen Alexandras Birdwing	Cairns Birdwing	Queen Alexandras Birdwing	3
2467	Why were the insects known as snakeflies given this interesting name?	They hiss.	They have a venomous bite.	Their body is elongated.	They have snake skin color patterns on their back.	Their body is elongated.	3
2468	What distinctive anatomical feature does the beetle species Trogodendron fasciculatum possess?	Bright yellow antennae	A green W mark on the back	Very large red eyes	Its abdomen is blue	Bright yellow antennae	3
2469	What does the flamboyant flower beetle, also known as striped love beetle, feed on?	Insects	Nectar	Blood	Carrion	Nectar	3
2470	What belief about the European hornet, the largest European eusocial wasp, is widespread among the people who are afraid of it?	If it stings you, youll never have children.	If it stings you on the arm or leg, that limb has to be amputated.	Three stings can kill an adult human, and seven can kill a horse.	Stinging results in deep sleep that you may never wake up from.	Three stings can kill an adult human, and seven can kill a horse.	3
2471	To what geographical area is the Ctenomorphodes chronus, a species of stick insect, endemic?	All of these	Madagascar	South America	Australia	Australia	3
2472	What kind of substance does the female redeye cicada prefer for laying eggs into?	Dead animal matter	Animal and human hair	Plant tissue	Living animal organisms	Plant tissue	3
2473	What part of their body do the insects from order Archaeognatha use to spring up into the air?	Antennae	Front legs	Hind legs	Tail	Tail	3
2474	What is the literal translation of the Greek word Embioptera, which denotes an order of insects, also known as webspinners?	Small wings	None of these	Yarn knitter	Lively wings	Lively wings	3
2485	What is the capital of Afghanistan?	Tirana	Kabul	Dushanbe	Tashkent	Kabul	3
2486	What is the capital of Australia?	Canberra	Sydney	Melbourne	Ottawa	Canberra	3
2487	What is the capital of Belgium?	Amsterdam	Luxemburg	Brussels	Stockholm	Brussels	3
2488	What is the capital of Greece?	Ankara	Athens	Sofia	Thessaloniki	Athens	3
2489	What is the capital of Italy?	Venice	Rome	Naples	Milan	Rome	3
2490	What is the capital of Israel?	Tel Aviv	Kabul	Jerusalem	Islamabad	Jerusalem	3
2491	What is the capital of Germany?	Frankfurt	Berlin	Munich	Hamburg	Berlin	3
2492	What is the capital of Norway?	Stockholm	Helsinki	Oslo	Copenhagen	Oslo	3
2493	What is the capital and largest city of Hawaii, the 50th US state?	Little Rock	Dover	Frankfort	Honolulu	Honolulu	3
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: hugo.cridlig
--

COPY public.results (idresult, idgame, iduser, score) FROM stdin;
1	1	87	10
2	1	138	8
3	1	43	12
8	2	87	40
9	2	43	35
10	2	138	32
12	2	149	44
14	1	43	0
15	19	43	0
16	19	149	0
17	20	43	0
18	21	149	0
19	22	149	0
20	22	43	0
21	23	149	0
22	24	43	0
23	24	149	0
24	26	43	3
25	26	149	2
26	27	43	0
27	27	149	0
28	30	43	0
29	30	149	0
30	31	149	0
31	31	43	0
32	32	43	0
33	32	149	0
34	36	149	0
35	37	149	0
36	37	43	0
37	39	149	0
38	40	43	0
39	40	149	0
40	42	149	0
41	43	43	0
42	43	149	0
43	44	149	0
44	44	43	0
45	46	149	1
46	46	43	0
47	47	149	0
48	47	43	0
49	49	43	0
50	49	149	0
51	52	149	0
52	52	43	0
53	55	149	0
54	55	43	0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: hugo.cridlig
--

COPY public.users (iduser, email, password, username, role) FROM stdin;
87	alex@alex.fr	$2b$10$dDjX1VzL3nslHmP77373EuwI4YJGXwO7HH7B5TGGNUjic1pYskQn2	alex	t
138	michel@michel.fr	$2b$10$O3MTB5YoX4tTTd2vIIJqiuLzDl8nMq950FD9u5ReLCJBas6dsb902	michel	f
149	test@test.fr	$2b$10$RawGM0v.phQ71mNqPorK9epbCKtZHEQ2DtvJax3dme4wEYFOa1/iC	yann	f
43	hugo@hugo.fr	$2b$10$E0spo3TTb.iUF8kM0T1IZuZpp1.9OxUyzgfGurzQFdGhR657i6S3u	hugo	t
\.


--
-- Name: categories_idcat_seq; Type: SEQUENCE SET; Schema: public; Owner: hugo.cridlig
--

SELECT pg_catalog.setval('public.categories_idcat_seq', 24, true);


--
-- Name: games_idgame_seq; Type: SEQUENCE SET; Schema: public; Owner: hugo.cridlig
--

SELECT pg_catalog.setval('public.games_idgame_seq', 55, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugo.cridlig
--

SELECT pg_catalog.setval('public.questions_id_seq', 2520, true);


--
-- Name: results_idresult_seq; Type: SEQUENCE SET; Schema: public; Owner: hugo.cridlig
--

SELECT pg_catalog.setval('public.results_idresult_seq', 54, true);


--
-- Name: users_iduser_seq; Type: SEQUENCE SET; Schema: public; Owner: hugo.cridlig
--

SELECT pg_catalog.setval('public.users_iduser_seq', 149, true);


--
-- Name: categories category_pkey; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT category_pkey PRIMARY KEY (idcat);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (idgame);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (idquest);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (idresult);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users users_mail_key; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mail_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (iduser);


--
-- Name: questions fk_questions_categories; Type: FK CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_questions_categories FOREIGN KEY (idcat) REFERENCES public.categories(idcat);


--
-- Name: games games_idcat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_idcat_fkey FOREIGN KEY (idcat) REFERENCES public.categories(idcat);


--
-- Name: results results_idgame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_idgame_fkey FOREIGN KEY (idgame) REFERENCES public.games(idgame);


--
-- Name: results results_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugo.cridlig
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_iduser_fkey FOREIGN KEY (iduser) REFERENCES public.users(iduser);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

