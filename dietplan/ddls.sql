SET SERVEROUTPUT ON;

BEGIN
    drop_table_safely('vitamine');
    drop_table_safely('mineralstoffe');
    drop_table_safely('brennstoffe');
    drop_table_safely('food');
    
    drop_sequence_safely('seq_food');
    drop_sequence_safely('seq_vitamine');
    drop_sequence_safely('seq_mineralstoffe');
    drop_sequence_safely('seq_brennstoffe');
END;
/

EXECUTE drop_table_safely('food');

/*alle angaben in mg/100g */

CREATE TABLE food (
    id     NUMBER(10) NOT NULL,
    name   VARCHAR2(100),
    CONSTRAINT pk_food PRIMARY KEY ( id )
);
/
CREATE SEQUENCE seq_food START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE vitamine (
    id                      NUMBER(10) NOT NULL,
    vitamin_a_retinol       BINARY_FLOAT,
    vitamin_a_betacarotin   BINARY_FLOAT,
    vitamin_b1              BINARY_FLOAT,
    vitamin_b2              BINARY_FLOAT,
    vitamin_b6              BINARY_FLOAT,
    vitamin_b12             BINARY_FLOAT,
    vitamin_c               BINARY_FLOAT,
    vitamin_d               BINARY_FLOAT,
    vitamin_e               BINARY_FLOAT,
    vitamin_k               BINARY_FLOAT,
    food_id                 NUMBER(10) NOT NULL,
    CONSTRAINT pk_vitamine PRIMARY KEY ( id ),
    CONSTRAINT fk_vitamine_food FOREIGN KEY ( food_id )
        REFERENCES food ( id )
);
/
CREATE SEQUENCE seq_vitamine START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- mineralstoffe können in Mengen- und Spurenelemente unterteilt werden
CREATE TABLE mineralstoffe (
    id          NUMBER(10) NOT NULL,
    calcium     BINARY_FLOAT,
    chlorid     BINARY_FLOAT,
    eisen       BINARY_FLOAT,
    fluorid     BINARY_FLOAT,
    iodid       BINARY_FLOAT,
    kalium      BINARY_FLOAT,
    kupfer      BINARY_FLOAT,
    mangan      BINARY_FLOAT,
    magnesium   BINARY_FLOAT,
    natrium     BINARY_FLOAT,
    phosphor    BINARY_FLOAT,
    schwefel    BINARY_FLOAT,
    zink        BINARY_FLOAT,
    food_id     NUMBER(10) NOT NULL,
    CONSTRAINT pk_mineralstoffe PRIMARY KEY ( id ),
    CONSTRAINT fk_mineralstoffe_food FOREIGN KEY ( food_id )
        REFERENCES food ( id )
);
/
CREATE SEQUENCE seq_mineralstoffe START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


CREATE TABLE brennstoffe (
    id              NUMBER(10) NOT NULL,
    fett            BINARY_FLOAT,
    eiweiss         BINARY_FLOAT,
    kohlenhydrate   BINARY_FLOAT,
    food_id         NUMBER(10) NOT NULL,
    CONSTRAINT pk_brennstoffe PRIMARY KEY ( id ),
    CONSTRAINT fk_brennstoffe_food FOREIGN KEY ( food_id )
        REFERENCES food ( id )
);
/
CREATE SEQUENCE seq_brennstoffe START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

INSERT INTO food (
    id,
    name
) VALUES (
    seq_food.nextval,
    'apple'
);

INSERT INTO vitamine (
    id,
    vitamin_a_retinol,
    vitamin_a_betacarotin,
    vitamin_b1,
    vitamin_b2,
    vitamin_b6,
    vitamin_b12,
    vitamin_c,
    vitamin_d,
    vitamin_e,
    vitamin_k,
    food_id
) VALUES (
    seq_vitamine.nextval,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1
);

INSERT INTO mineralstoffe (
    id,
    calcium,
    chlorid,
    eisen,
    fluorid,
    iodid,
    kalium,
    kupfer,
    mangan,
    magnesium,
    natrium,
    phosphor,
    schwefel,
    zink,
    food_id
) VALUES (
    seq_mineralstoffe.nextval,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1
);

INSERT INTO brennstoffe (
    id,
    fett,
    eiweiss,
    kohlenhydrate,
    food_id
) VALUES (
    seq_brennstoffe.nextval,
    2,
    2,
    2,
    1
);