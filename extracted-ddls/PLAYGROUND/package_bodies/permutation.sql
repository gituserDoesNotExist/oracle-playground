CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."PERMUTATION" 
  AS
  V_LOG_INFO NVARCHAR2(40) := 'PLAYGROUND.PERMUTATION: ';

  PROCEDURE COMP_VARIATIONEN_MIT_WIEDERH(R_ITEM_POOL                         INTEGER_ARRAY,
                                         N_MAX_REC_DEPTH                     NUMBER,
                                         T_COMBINATIONS        IN OUT NOCOPY INTEGER_MATRIX,
                                         R_CURRENT_COMBINATION IN OUT NOCOPY INTEGER_ARRAY,
                                         N_DEPTH               IN            NUMBER)
    IS
      N_CURRENT_DEPTH NUMBER;
    BEGIN
      N_CURRENT_DEPTH := N_DEPTH + 1;
      IF N_CURRENT_DEPTH > N_MAX_REC_DEPTH
      THEN
        T_COMBINATIONS.extend;
        T_COMBINATIONS(T_COMBINATIONS.last) := R_CURRENT_COMBINATION;
        RETURN;
      END IF;

      FOR IDX IN 1 .. R_ITEM_POOL.count
      LOOP
        R_CURRENT_COMBINATION(N_CURRENT_DEPTH) := R_ITEM_POOL(IDX);
        COMP_VARIATIONEN_MIT_WIEDERH(R_ITEM_POOL, N_MAX_REC_DEPTH, T_COMBINATIONS, R_CURRENT_COMBINATION, N_CURRENT_DEPTH);
      END LOOP;

    END;

  --Mit Zuruecklegen, mit Beachtung der Reihenfolge entspricht einer Variation mit Wiederholung
  FUNCTION VARIATION_MIT_WIEDERHOLUNG(R_POOL_TO_PICK_FROM IN INTEGER_ARRAY,
                                      N_NUMBER_OF_PICKS   IN NUMBER)
    RETURN INTEGER_MATRIX
    IS

      R_CURRENT_COMBINATION INTEGER_ARRAY  := INTEGER_ARRAY();
      T_COMBINATIONS        INTEGER_MATRIX := INTEGER_MATRIX();
    BEGIN
      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'Berechnen Variationen mit Wiederholung: ' || N_NUMBER_OF_PICKS || ' mal ziehen, mit Zuruecklegen und mit Beachtung der Reihenfolge) fuer:');
      PLAYGROUND.PRINT_LIST(R_POOL_TO_PICK_FROM);

      LIST_UTILS.INITIALIZE_LIST(R_CURRENT_COMBINATION, N_NUMBER_OF_PICKS);

      COMP_VARIATIONEN_MIT_WIEDERH(R_POOL_TO_PICK_FROM, N_NUMBER_OF_PICKS, T_COMBINATIONS, R_CURRENT_COMBINATION, 0);

      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'computed ' || T_COMBINATIONS.count || ' different combinations');
      PLAYGROUND.PRINT_MATRIX(T_COMBINATIONS);
      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'finished.');

      RETURN T_COMBINATIONS;
    END VARIATION_MIT_WIEDERHOLUNG;


  --#############################################################################################################################

  PROCEDURE COMP_KOMBINATIONEN_NO_WIEDERH(R_ITEM_POOL           IN            INTEGER_ARRAY,
                                          N_MAX_REC_DEPTH                     NUMBER,
                                          T_COMBINATIONS        IN OUT NOCOPY INTEGER_MATRIX,
                                          R_CURRENT_COMBINATION IN OUT NOCOPY INTEGER_ARRAY,
                                          N_DEPTH               IN            NUMBER)
    IS
      N_CURRENT_ELEMENT NUMBER;
      N_CURRENT_DEPTH   NUMBER;
      R_COPY_ITEM_POOL  INTEGER_ARRAY;

    BEGIN
      N_CURRENT_DEPTH := N_DEPTH + 1;
      R_COPY_ITEM_POOL := LIST_UTILS.COPY_ARRAY(R_ITEM_POOL);
      IF N_CURRENT_DEPTH > N_MAX_REC_DEPTH
      THEN
        T_COMBINATIONS.extend;
        T_COMBINATIONS(T_COMBINATIONS.last) := R_CURRENT_COMBINATION;
        RETURN;
      END IF;
      IF R_COPY_ITEM_POOL.count = 0
      THEN
        --        DBMS_OUTPUT.PUT_LINE('pool to pick from is empty');        RETURN;
      END IF;

      FOR IDX IN REVERSE 1 .. R_COPY_ITEM_POOL.count
      LOOP
        N_CURRENT_ELEMENT := R_COPY_ITEM_POOL(IDX);
        R_CURRENT_COMBINATION(N_CURRENT_DEPTH) := N_CURRENT_ELEMENT;
        R_COPY_ITEM_POOL.trim;
        COMP_KOMBINATIONEN_NO_WIEDERH(R_COPY_ITEM_POOL, N_MAX_REC_DEPTH, T_COMBINATIONS, R_CURRENT_COMBINATION, N_CURRENT_DEPTH);
      END LOOP;

    END;


  FUNCTION KOMBINATION_OHNE_WIEDERHOLUNG(R_POOL_TO_PICK_FROM IN INTEGER_ARRAY,
                                         N_NUMBER_OF_PICKS   IN NUMBER)
    RETURN INTEGER_MATRIX
    IS

      R_CURRENT_COMBINATION    INTEGER_ARRAY  := INTEGER_ARRAY();
      T_COMBINATIONS           INTEGER_MATRIX := INTEGER_MATRIX();
      N_NUMBER_OF_COMBINATIONS NUMBER(20);
    BEGIN
      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'Berechnen Kombinationen ohne Wiederholung: ' || N_NUMBER_OF_PICKS || ' mal ziehen ohne Zuruecklegen und ohne Beachtung der Reihenfolge) fuer:');
      PLAYGROUND.PRINT_LIST(R_POOL_TO_PICK_FROM);

      LIST_UTILS.INITIALIZE_LIST(R_CURRENT_COMBINATION, N_NUMBER_OF_PICKS);

      COMP_KOMBINATIONEN_NO_WIEDERH(R_POOL_TO_PICK_FROM, N_NUMBER_OF_PICKS, T_COMBINATIONS, R_CURRENT_COMBINATION, 0);

      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'computed ' || T_COMBINATIONS.count || ' different combinations:');
      PLAYGROUND.PRINT_MATRIX(T_COMBINATIONS);
      DBMS_OUTPUT.PUT_LINE(V_LOG_INFO || 'finished.');

      RETURN T_COMBINATIONS;
    END KOMBINATION_OHNE_WIEDERHOLUNG;







END PERMUTATION;
/
