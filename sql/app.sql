CREATE SEQUENCE hello_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE hello (
    id       integer PRIMARY KEY DEFAULT nextval('hello_id_seq'::regclass),
    message  varchar(40) NOT NULL
);

INSERT INTO hello (message) VALUES ('Hello, World!');
