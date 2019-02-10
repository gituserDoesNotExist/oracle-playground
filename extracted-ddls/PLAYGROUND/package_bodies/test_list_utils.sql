CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_LIST_UTILS" 
  AS

  --####################################################################

  PROCEDURE CREATE_INTEGER_ARRAY_FROM_TO
    AS
      N_START   NUMBER(19)    := 1;
      N_STOP    NUMBER(19)    := 5;

      R_RES     PLAYGROUND.INTEGER_ARRAY;
      V_RES_STR NVARCHAR2(10) := '';
    BEGIN
      R_RES := LIST_UTILS.CREATE_INTEGER_ARRAY_FROM_TO(N_START, N_STOP);

      FOR IDX IN R_RES.first .. R_RES.last
      LOOP
        V_RES_STR := CONCAT(V_RES_STR, R_RES(IDX));
      END LOOP;

      UT.EXPECT(V_RES_STR).TO_EQUAL('12345');

    END CREATE_INTEGER_ARRAY_FROM_TO;

  --##############################################################
  PROCEDURE CREATE_EMPTY_INTEGER_MATRIX
    IS
      N_NUMBER_OF_ROWS    INTEGER := 2;
      N_NUMBER_OF_COLUMNS INTEGER := 2;

      T_RES               PLAYGROUND.INTEGER_MATRIX;
    BEGIN
      T_RES := LIST_UTILS.CREATE_EMPTY_INTEGER_MATRIX(N_NUMBER_OF_ROWS, N_NUMBER_OF_COLUMNS);

      ut.expect(T_RES(1)(1)).to_equal(0);
      ut.expect(T_RES(1)(2)).to_equal(0);
      ut.expect(T_RES(2)(1)).to_equal(0);
      ut.expect(T_RES(2)(2)).to_equal(0);

    END CREATE_EMPTY_INTEGER_MATRIX;


END TEST_LIST_UTILS;
/
