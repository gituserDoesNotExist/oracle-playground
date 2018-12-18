CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."LIST_UTILS" 
  AS

--###############################################################

  FUNCTION COPY_ARRAY(R_INPUT_ARRAY IN INTEGER_ARRAY)
    RETURN INTEGER_ARRAY

    IS
      COPY INTEGER_ARRAY := INTEGER_ARRAY();
    BEGIN
      FOR IDX IN 1 .. R_INPUT_ARRAY.count
      LOOP
        COPY.extend;
        COPY(IDX) := R_INPUT_ARRAY(IDX);
      END LOOP;
      RETURN COPY;

    END;

--################################################################

  PROCEDURE INITIALIZE_LIST(INIT_LIST IN OUT NOCOPY INTEGER_ARRAY,
                            INITSIZE  IN            NUMBER)
    IS
    BEGIN
      FOR I IN 1 .. INITSIZE
      LOOP
        INIT_LIST.extend();
      END LOOP;
    END INITIALIZE_LIST;

--###################################################################

  FUNCTION CREATE_INTEGER_ARRAY_FROM_TO(P_N_START IN NUMBER,
                                        P_N_END   IN NUMBER)
    RETURN INTEGER_ARRAY
    IS
      IDX_ARRAY PLAYGROUND.INTEGER_ARRAY := PLAYGROUND.INTEGER_ARRAY();
    BEGIN
      FOR IDX IN P_N_START .. P_N_END
      LOOP
        IDX_ARRAY.extend;
        IDX_ARRAY(IDX) := IDX;
      END LOOP;
      RETURN IDX_ARRAY;
    END CREATE_INTEGER_ARRAY_FROM_TO;

--################################################################
  FUNCTION CREATE_EMPTY_INTEGER_MATRIX(NUMBER_OF_ROWS    NUMBER,
                                      NUMBER_OF_COLUMNS NUMBER)
    RETURN PLAYGROUND.INTEGER_MATRIX
    AS
      R_CURRENT_ROW PLAYGROUND.INTEGER_ARRAY;
      MATRIX        PLAYGROUND.INTEGER_MATRIX := PLAYGROUND.INTEGER_MATRIX();
    BEGIN
      FOR ROW_IDX IN 1 .. NUMBER_OF_ROWS
      LOOP
        R_CURRENT_ROW := PLAYGROUND.INTEGER_ARRAY();
        FOR COL_IDX IN 1 .. NUMBER_OF_COLUMNS
        LOOP
          R_CURRENT_ROW.extend;
          R_CURRENT_ROW(COL_IDX) := 0;
        END LOOP;
        MATRIX.extend;
        MATRIX(ROW_IDX) := R_CURRENT_ROW;
      END LOOP;
      RETURN MATRIX;
    END CREATE_EMPTY_INTEGER_MATRIX;

END LIST_UTILS;
/
