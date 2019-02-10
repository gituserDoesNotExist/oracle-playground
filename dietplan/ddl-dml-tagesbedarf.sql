execute drop_table_safely('tagesbedarf_vitamine');
execute drop_table_safely('tagesbedarf_mineralstoffe');


create table tagesbedarf_vitamine (
    id NUMBER(10) NOT NULL,
  	vitaminARetinol BINARY_FLOAT,
  	vitaminABetaCarotin BINARY_FLOAT,
    vitaminB1 BINARY_FLOAT,
    vitaminB2 BINARY_FLOAT,
    vitaminB6 BINARY_FLOAT,
  	vitaminB12 BINARY_FLOAT,
  	vitaminC BINARY_FLOAT,	
  	vitaminD BINARY_FLOAT,
    vitaminE BINARY_FLOAT,
  	vitaminK BINARY_FLOAT,
  	CONSTRAINT pk_tagesbedarf_vitamine primary key (id)
);
/
insert into tagesbedarf_vitamine (id,vitaminARetinol,vitaminABetaCarotin,vitaminB1,vitaminB2,vitaminB6,vitaminB12,vitaminC,vitaminD,vitaminE,vitaminK)
	values (1,2,2,2,2,2,2,2,2,2,2);
/

create table tagesbedarf_mineralstoffe (
    id NUMBER(10) NOT NULL,
    calcium BINARY_FLOAT,
    chlorid BINARY_FLOAT,
    eisen BINARY_FLOAT,
  	fluorid BINARY_FLOAT,
  	iodid BINARY_FLOAT,    
    kalium BINARY_FLOAT,
    kupfer BINARY_FLOAT,
    mangan BINARY_FLOAT,
    magnesium BINARY_FLOAT,
    natrium BINARY_FLOAT,
    phosphor BINARY_FLOAT,
  	schwefel BINARY_FLOAT,
    zink BINARY_FLOAT,
    CONSTRAINT pk_tagesbedarf_mineralstoffe primary key(id)
);
/
insert into tagesbedarf_mineralstoffe (id,calcium,chlorid,eisen,fluorid,iodid,kalium,kupfer,mangan,magnesium,natrium,phosphor,schwefel,zink)
	values (1,2,2,2,2,2,2,2,2,2,2,2,2,2);
/

