PGDMP  /                    |         
   petsitters    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    32769 
   petsitters    DATABASE     ~   CREATE DATABASE petsitters WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE petsitters;
                postgres    false                        2615    32770 
   petsitters    SCHEMA        CREATE SCHEMA petsitters;
    DROP SCHEMA petsitters;
                postgres    false            �            1259    32913 
   gameanswer    TABLE     �   CREATE TABLE petsitters.gameanswer (
    answerid integer NOT NULL,
    questionid integer NOT NULL,
    answertext text NOT NULL,
    score real
);
 "   DROP TABLE petsitters.gameanswer;
    
   petsitters         heap    postgres    false    6            �            1259    32866    gamequestion    TABLE     j   CREATE TABLE petsitters.gamequestion (
    questionid integer NOT NULL,
    questiontext text NOT NULL
);
 $   DROP TABLE petsitters.gamequestion;
    
   petsitters         heap    postgres    false    6            �            1259    32865    gamequestion_questionid_seq    SEQUENCE     �   CREATE SEQUENCE petsitters.gamequestion_questionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE petsitters.gamequestion_questionid_seq;
    
   petsitters          postgres    false    6    217            �           0    0    gamequestion_questionid_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE petsitters.gamequestion_questionid_seq OWNED BY petsitters.gamequestion.questionid;
       
   petsitters          postgres    false    216            �            1259    32889    user    TABLE     �   CREATE TABLE petsitters."user" (
    userid integer NOT NULL,
    fullname character varying(100),
    phone character varying(20),
    email character varying(100),
    profession character varying(20),
    currentgamequestionid integer
);
    DROP TABLE petsitters."user";
    
   petsitters         heap    postgres    false    6            �            1259    32888    user_userid_seq    SEQUENCE     �   CREATE SEQUENCE petsitters.user_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE petsitters.user_userid_seq;
    
   petsitters          postgres    false    6    219            �           0    0    user_userid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE petsitters.user_userid_seq OWNED BY petsitters."user".userid;
       
   petsitters          postgres    false    218            �            1259    32895 
   useranswer    TABLE     �   CREATE TABLE petsitters.useranswer (
    userid integer NOT NULL,
    questionid integer NOT NULL,
    answertext text,
    score real
);
 "   DROP TABLE petsitters.useranswer;
    
   petsitters         heap    postgres    false    6            �            1259    33097    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    postgres    false            ,           2604    32869    gamequestion questionid    DEFAULT     �   ALTER TABLE ONLY petsitters.gamequestion ALTER COLUMN questionid SET DEFAULT nextval('petsitters.gamequestion_questionid_seq'::regclass);
 J   ALTER TABLE petsitters.gamequestion ALTER COLUMN questionid DROP DEFAULT;
    
   petsitters          postgres    false    216    217    217            -           2604    32892    user userid    DEFAULT     t   ALTER TABLE ONLY petsitters."user" ALTER COLUMN userid SET DEFAULT nextval('petsitters.user_userid_seq'::regclass);
 @   ALTER TABLE petsitters."user" ALTER COLUMN userid DROP DEFAULT;
    
   petsitters          postgres    false    218    219    219            �          0    32913 
   gameanswer 
   TABLE DATA           Q   COPY petsitters.gameanswer (answerid, questionid, answertext, score) FROM stdin;
 
   petsitters          postgres    false    221   �#       �          0    32866    gamequestion 
   TABLE DATA           D   COPY petsitters.gamequestion (questionid, questiontext) FROM stdin;
 
   petsitters          postgres    false    217   
$       �          0    32889    user 
   TABLE DATA           g   COPY petsitters."user" (userid, fullname, phone, email, profession, currentgamequestionid) FROM stdin;
 
   petsitters          postgres    false    219   v$       �          0    32895 
   useranswer 
   TABLE DATA           O   COPY petsitters.useranswer (userid, questionid, answertext, score) FROM stdin;
 
   petsitters          postgres    false    220   %       �          0    33097    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          postgres    false    222   P%       �           0    0    gamequestion_questionid_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('petsitters.gamequestion_questionid_seq', 11, true);
       
   petsitters          postgres    false    216            �           0    0    user_userid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('petsitters.user_userid_seq', 8, true);
       
   petsitters          postgres    false    218            5           2606    32919    gameanswer gameanswer_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY petsitters.gameanswer
    ADD CONSTRAINT gameanswer_pkey PRIMARY KEY (answerid, questionid);
 H   ALTER TABLE ONLY petsitters.gameanswer DROP CONSTRAINT gameanswer_pkey;
    
   petsitters            postgres    false    221    221            /           2606    32873    gamequestion gamequestion_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY petsitters.gamequestion
    ADD CONSTRAINT gamequestion_pkey PRIMARY KEY (questionid);
 L   ALTER TABLE ONLY petsitters.gamequestion DROP CONSTRAINT gamequestion_pkey;
    
   petsitters            postgres    false    217            1           2606    32894    user user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY petsitters."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (userid);
 >   ALTER TABLE ONLY petsitters."user" DROP CONSTRAINT user_pkey;
    
   petsitters            postgres    false    219            3           2606    32901    useranswer useranswer_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT useranswer_pkey PRIMARY KEY (userid, questionid);
 H   ALTER TABLE ONLY petsitters.useranswer DROP CONSTRAINT useranswer_pkey;
    
   petsitters            postgres    false    220    220            7           2606    33101 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            postgres    false    222            :           2606    32920 %   gameanswer gameanswer_questionid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY petsitters.gameanswer
    ADD CONSTRAINT gameanswer_questionid_fkey FOREIGN KEY (questionid) REFERENCES petsitters.gamequestion(questionid);
 S   ALTER TABLE ONLY petsitters.gameanswer DROP CONSTRAINT gameanswer_questionid_fkey;
    
   petsitters          postgres    false    217    221    4655            8           2606    32907 %   useranswer useranswer_questionid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT useranswer_questionid_fkey FOREIGN KEY (questionid) REFERENCES petsitters.gamequestion(questionid);
 S   ALTER TABLE ONLY petsitters.useranswer DROP CONSTRAINT useranswer_questionid_fkey;
    
   petsitters          postgres    false    220    4655    217            9           2606    32902 !   useranswer useranswer_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY petsitters.useranswer
    ADD CONSTRAINT useranswer_userid_fkey FOREIGN KEY (userid) REFERENCES petsitters."user"(userid);
 O   ALTER TABLE ONLY petsitters.useranswer DROP CONSTRAINT useranswer_userid_fkey;
    
   petsitters          postgres    false    219    220    4657            �   T   x�3�4�0�bӅM�^lR0T�0�¾�/6\�w�Q��Ӑ�U��
]C.cT%�X�r�!)1S����e��zF\1z\\\ �\I�      �   \   x�Mͫ�0DQ���
���S��� <�@A���#p��5G]Q�1m��.����p��'<��D$d"C��!��]K}�YK�:1�c��+3      �   �   x�3�0���[.6\�
����;P�.���iahidldlbjfșX��V^�Z䐛�������钟^�YR�Z�i�eB5�Q�5�,.)��K�Q��@U�z�0��A��T�V$�䤂�WiD�JC,*�+������=... H^��      �   +   x�3�4�0�¾�/6\�w�Q��Ӑː�U�(���� g      �      x�3512�47MJKN5����� (��     