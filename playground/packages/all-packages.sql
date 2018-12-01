--------------------------------------------------------
--  File created - Saturday-December-01-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package KNAPSACK
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."KNAPSACK" AUTHID DEFINER
  IS
  FUNCTION GET_ITEMS_OPTIMIZING_VALUE(P_ITEMS_IN_STORE IN PLAYGROUND.ITEMS,
                                      P_N_MAX_WEIGHT IN NUMBER)
    RETURN PLAYGROUND.ITEM_ASSORTMENT;

END KNAPSACK;

/
--------------------------------------------------------
--  DDL for Package LIST_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."LIST_UTILS" AUTHID DEFINER
  AS


  FUNCTION COPY_ARRAY(R_INPUT_ARRAY IN INTEGER_ARRAY)
    RETURN INTEGER_ARRAY;

  PROCEDURE INITIALIZE_LIST(INIT_LIST IN OUT NOCOPY INTEGER_ARRAY,
                            INITSIZE  IN            NUMBER);

  FUNCTION CREATE_INTEGER_ARRAY_FROM_TO(P_N_START IN NUMBER,
                                        P_N_END   IN NUMBER)
    RETURN INTEGER_ARRAY;



END LIST_UTILS;

/
--------------------------------------------------------
--  DDL for Package MY_TYPES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."MY_TYPES" AUTHID DEFINER
  IS


  TYPE NUMBER_TABLE IS TABLE OF NUMBER;


END MY_TYPES;

/
--------------------------------------------------------
--  DDL for Package PERMUTATION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."PERMUTATION" AUTHID DEFINER
  IS
  -- Ziehen mit Zurücklegen, mit Beachtung der Reihenfolge entspricht einer Variation mit Wiederholung
  FUNCTION VARIATION_MIT_WIEDERHOLUNG(R_POOL_TO_PICK_FROM IN INTEGER_ARRAY,
                                      N_NUMBER_OF_PICKS   IN NUMBER)
    RETURN INTEGER_MATRIX;

  -- Ziehen ohne Zurücklegen und ohne Beachtung der Reihenfolge entspricht einer Kombinatoin ohne Wiederholung
  FUNCTION KOMBINATION_OHNE_WIEDERHOLUNG(R_POOL_TO_PICK_FROM INTEGER_ARRAY,
                                         N_NUMBER_OF_PICKS   NUMBER)
    RETURN INTEGER_MATRIX;

END PERMUTATION;

/
--------------------------------------------------------
--  DDL for Package TEST_ASSORTMENT_SHIT
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_ASSORTMENT_SHIT" AUTHID DEFINER
  AS

  -- %suite(test all around assortment objects)

  -- %test(create an "ITEM")  PROCEDURE TEST_CREATE_ITEM;


  -- %test(create "ITEM_ASSORTMENT" and get total weight and value);  PROCEDURE TEST_ITEM_ASSORTMENT;

  -- %test("create "ITEM_ASSORTMENT_CONTAINER" and test its methods")  PROCEDURE TEST_ITEM_ASSORTMENT_CONTAINER;

END TEST_ASSORTMENT_SHIT;

/
--------------------------------------------------------
--  DDL for Package TEST_LIST_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_LIST_UTILS" AUTHID DEFINER
  AS

  -- %suite(test package for "LIST_UTILS" package)
  -- %test(test CREATE_INTEGER_ARRAY_FROM_TO - Passing 1,5; should create [1,2,3,4,5]
  PROCEDURE CREATE_INTEGER_ARRAY_FROM_TO;

END TEST_LIST_UTILS;

/
--------------------------------------------------------
--  DDL for Package TEST_SUBSTRING
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_SUBSTRING" AUTHID DEFINER AS 

  -- %suite(Test the substring function)
  -- %suitepath(substring)
  
  -- %test(Returns substring from start position to end position)
  procedure basic_usage;

END TEST_SUBSTRING;

/
--------------------------------------------------------
--  DDL for Package TEST_TO_LOWER_CASE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_TO_LOWER_CASE" AUTHID DEFINER AS 

    -- %suite(test to_lower_case function)
    -- %suitepath(upper.lower.case.suite)
    
    -- %test(first test for function "to_lower_case");    procedure first_test_to_lower_case;

END TEST_TO_LOWER_CASE;

/
--------------------------------------------------------
--  DDL for Package TEST_TO_UPPER_CASE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_TO_UPPER_CASE" AUTHID DEFINER AS 

    -- %suite(test to_upper_case function)
    -- %suitepath(upper.lower.case.suite)
    
    -- %test(first test)
    procedure first_test;

END TEST_TO_UPPER_CASE;

/
--------------------------------------------------------
--  DDL for Package Body KNAPSACK
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."KNAPSACK" 
  AS

  FUNCTION BUILD_ASSORTMENT_FROM_IDX_COMB(P_COMBINATION    IN PLAYGROUND.INTEGER_ARRAY,
                                          P_ITEMS_IN_STORE IN PLAYGROUND.ITEMS)
    RETURN PLAYGROUND.ITEM_ASSORTMENT
    IS
      N_CURRENT_INDEX_OF_COMB NUMBER(19);
      CURRENT_ITEM            PLAYGROUND.ITEM;
      R_ITEMS_FROM_COMB       PLAYGROUND.ITEMS := PLAYGROUND.ITEMS();
    BEGIN
      FOR IDX IN 1 .. P_COMBINATION.count
      LOOP
        N_CURRENT_INDEX_OF_COMB := P_COMBINATION(IDX);
        CURRENT_ITEM := P_ITEMS_IN_STORE(N_CURRENT_INDEX_OF_COMB);
        R_ITEMS_FROM_COMB.extend;
        R_ITEMS_FROM_COMB(R_ITEMS_FROM_COMB.last) := NEW PLAYGROUND.ITEM(CURRENT_ITEM.GET_WEIGHT(), CURRENT_ITEM.GET_VALUE());
      END LOOP;
      RETURN NEW PLAYGROUND.ITEM_ASSORTMENT(R_ITEMS_FROM_COMB);
    END BUILD_ASSORTMENT_FROM_IDX_COMB;


  PROCEDURE FILL_CONTAINER_FROM_IDX_MATRIX(P_IDX_MATRIX                IN            PLAYGROUND.INTEGER_MATRIX,
                                           P_ITEMS_IN_STORE            IN            PLAYGROUND.ITEMS,
                                           P_ITEM_ASSORTMENT_CONTAINER IN OUT NOCOPY PLAYGROUND.ITEM_ASSORTMENT_CONTAINER)
    IS
      R_CURRENT_COMBINATION   PLAYGROUND.INTEGER_ARRAY;
      CURRENT_ITEM_ASSORTMENT PLAYGROUND.ITEM_ASSORTMENT;
    BEGIN
      FOR ROW_IDX IN 1 .. P_IDX_MATRIX.count
      LOOP
        R_CURRENT_COMBINATION := P_IDX_MATRIX(ROW_IDX);
        CURRENT_ITEM_ASSORTMENT := BUILD_ASSORTMENT_FROM_IDX_COMB(R_CURRENT_COMBINATION, P_ITEMS_IN_STORE);
        P_ITEM_ASSORTMENT_CONTAINER.ADD_ASSORTMENT(CURRENT_ITEM_ASSORTMENT);
      END LOOP;

    END FILL_CONTAINER_FROM_IDX_MATRIX;

  FUNCTION FIND_ASSRTMNT_WITH_HIGHEST_VAL(P_ASSORTMENTS IN PLAYGROUND.ITEM_ASSORTMENTS)
    RETURN PLAYGROUND.ITEM_ASSORTMENT
    IS
      N_MAX_VALUE              NUMBER(19) := 0;
      CURRENT_ASSORTMENT       PLAYGROUND.ITEM_ASSORTMENT;
      ASSORTMENT_HIGHEST_VALUE PLAYGROUND.ITEM_ASSORTMENT;
    BEGIN
      FOR IDX IN P_ASSORTMENTS.first .. P_ASSORTMENTS.last
      LOOP
        CURRENT_ASSORTMENT := P_ASSORTMENTS(IDX);
        IF CURRENT_ASSORTMENT.GET_TOTAL_VALUE() > N_MAX_VALUE
        THEN
          N_MAX_VALUE := CURRENT_ASSORTMENT.GET_TOTAL_VALUE();
          ASSORTMENT_HIGHEST_VALUE := CURRENT_ASSORTMENT;
        END IF;
      END LOOP;
      RETURN ASSORTMENT_HIGHEST_VALUE;
    END FIND_ASSRTMNT_WITH_HIGHEST_VAL;



  FUNCTION GET_ITEMS_OPTIMIZING_VALUE(P_ITEMS_IN_STORE IN PLAYGROUND.ITEMS,
                                      P_N_MAX_WEIGHT   IN NUMBER)
    RETURN PLAYGROUND.ITEM_ASSORTMENT
    IS
      ASSORTMENT_CONTAINER       PLAYGROUND.ITEM_ASSORTMENT_CONTAINER := NEW PLAYGROUND.ITEM_ASSORTMENT_CONTAINER();

      R_SUBSCRIPTS               INTEGER_ARRAY                        := INTEGER_ARRAY();
      T_COMBINATIONS             INTEGER_MATRIX;

      N_MIN_PICKS                NUMBER(19)                           := 1;
      N_MAX_PICKS                NUMBER(19);

      ASSRTMENTS_BELOW_THRESHOLD PLAYGROUND.ITEM_ASSORTMENTS;
    BEGIN
      N_MAX_PICKS := P_ITEMS_IN_STORE.count;
      R_SUBSCRIPTS := LIST_UTILS.CREATE_INTEGER_ARRAY_FROM_TO(N_MIN_PICKS, N_MAX_PICKS);

      FOR IDX IN R_SUBSCRIPTS.first .. R_SUBSCRIPTS.last
      LOOP
        T_COMBINATIONS := PERMUTATION.KOMBINATION_OHNE_WIEDERHOLUNG(R_SUBSCRIPTS, R_SUBSCRIPTS(IDX));
        FILL_CONTAINER_FROM_IDX_MATRIX(T_COMBINATIONS, P_ITEMS_IN_STORE, ASSORTMENT_CONTAINER);
      END LOOP;
      ASSRTMENTS_BELOW_THRESHOLD := ASSORTMENT_CONTAINER.GET_ASSRTMNTS_WITH_WGHT_BELOW(P_N_MAX_WEIGHT);
    
      RETURN FIND_ASSRTMNT_WITH_HIGHEST_VAL(ASSRTMENTS_BELOW_THRESHOLD);

      
    END;

END KNAPSACK;

/
--------------------------------------------------------
--  DDL for Package Body LIST_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."LIST_UTILS" 
  AS

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

  PROCEDURE INITIALIZE_LIST(INIT_LIST IN OUT NOCOPY INTEGER_ARRAY,
                            INITSIZE  IN            NUMBER)
    IS
    BEGIN
      FOR I IN 1 .. INITSIZE
      LOOP
        INIT_LIST.extend();
      END LOOP;
    END INITIALIZE_LIST;


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

END LIST_UTILS;

/
--------------------------------------------------------
--  DDL for Package Body PERMUTATION
--------------------------------------------------------

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
--------------------------------------------------------
--  DDL for Package Body TEST_ASSORTMENT_SHIT
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_ASSORTMENT_SHIT" 
  AS


  PROCEDURE TEST_CREATE_ITEM
    AS
      N_WEIGHT  NUMBER(19) := 10;
      N_VALUE   NUMBER(19) := 5;
      TEST_ITEM PLAYGROUND.ITEM;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('test creation of ITEM');
      TEST_ITEM := NEW PLAYGROUND.ITEM(N_WEIGHT, N_VALUE);

      UT.EXPECT(TEST_ITEM.GET_WEIGHT()).to_equal(N_WEIGHT);
      UT.EXPECT(TEST_ITEM.GET_VALUE()).to_equal(N_VALUE);

    END TEST_CREATE_ITEM;

  PROCEDURE TEST_ITEM_ASSORTMENT
    AS
      N_WEIGHT_1           NUMBER(19)       := 10;
      N_VALUE_1            NUMBER(19)       := 5;
      N_WEIGHT_2           NUMBER(19)       := 15;
      N_VALUE_2            NUMBER(19)       := 10;
      TEST_ITEMS           PLAYGROUND.ITEMS := PLAYGROUND.ITEMS(NEW PLAYGROUND.ITEM(N_WEIGHT_1, N_VALUE_1), NEW PLAYGROUND.ITEM(N_WEIGHT_2, N_VALUE_2));

      TEST_ITEM_ASSORTMENT PLAYGROUND.ITEM_ASSORTMENT;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('test creation of ITEM_ASSORTMENT');
      TEST_ITEM_ASSORTMENT := NEW PLAYGROUND.ITEM_ASSORTMENT(TEST_ITEMS);

      UT.EXPECT(TEST_ITEM_ASSORTMENT.GET_TOTAL_WEIGHT()).to_equal(N_WEIGHT_1 + N_WEIGHT_2);
      UT.EXPECT(TEST_ITEM_ASSORTMENT.GET_TOTAL_VALUE()).to_equal(N_VALUE_1 + N_VALUE_2);

    END TEST_ITEM_ASSORTMENT;


  PROCEDURE TEST_ITEM_ASSORTMENT_CONTAINER
    AS
      TEST_ITEMS_1                   PLAYGROUND.ITEMS           := PLAYGROUND.ITEMS(NEW PLAYGROUND.ITEM(10, 10), NEW PLAYGROUND.ITEM(20, 20));
      TEST_ITEMS_2                   PLAYGROUND.ITEMS           := PLAYGROUND.ITEMS(NEW PLAYGROUND.ITEM(40, 40));
      TEST_ITEMS_3                   PLAYGROUND.ITEMS           := PLAYGROUND.ITEMS(NEW PLAYGROUND.ITEM(40, 40), NEW PLAYGROUND.ITEM(20, 40));
      TEST_ASSORTMENT_1              PLAYGROUND.ITEM_ASSORTMENT := NEW PLAYGROUND.ITEM_ASSORTMENT(TEST_ITEMS_1);
      TEST_ASSORTMENT_2              PLAYGROUND.ITEM_ASSORTMENT := NEW PLAYGROUND.ITEM_ASSORTMENT(TEST_ITEMS_2);
      TEST_ASSORTMENT_3              PLAYGROUND.ITEM_ASSORTMENT := NEW PLAYGROUND.ITEM_ASSORTMENT(TEST_ITEMS_3);

      ASSORTMENT_CONTAINER           PLAYGROUND.ITEM_ASSORTMENT_CONTAINER;
      ASSRTMNTS_TOTL_WGHT_BLOW_THRES PLAYGROUND.ITEM_ASSORTMENTS;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('test creation of ITEM_ASSORTMENT_CONTAINER');
      ASSORTMENT_CONTAINER := PLAYGROUND.ITEM_ASSORTMENT_CONTAINER();
      DBMS_OUTPUT.PUT_LINE('assortment-container successfully created');

      ASSORTMENT_CONTAINER.ADD_ASSORTMENT(TEST_ASSORTMENT_1);
      ASSORTMENT_CONTAINER.ADD_ASSORTMENT(TEST_ASSORTMENT_2);
      ASSORTMENT_CONTAINER.ADD_ASSORTMENT(TEST_ASSORTMENT_3);

      UT.EXPECT(ASSORTMENT_CONTAINER.GET_TOTAL_ASSORTMENTS()).to_equal(3);

      ASSRTMNTS_TOTL_WGHT_BLOW_THRES := ASSORTMENT_CONTAINER.GET_ASSRTMNTS_WITH_WGHT_BELOW(50);
      UT.EXPECT(ASSRTMNTS_TOTL_WGHT_BLOW_THRES.count).to_equal(2);

      ASSRTMNTS_TOTL_WGHT_BLOW_THRES := ASSORTMENT_CONTAINER.GET_ASSRTMNTS_WITH_WGHT_BELOW(60);
      UT.EXPECT(ASSRTMNTS_TOTL_WGHT_BLOW_THRES.count).to_equal(3);

    END TEST_ITEM_ASSORTMENT_CONTAINER;

END TEST_ASSORTMENT_SHIT;

/
--------------------------------------------------------
--  DDL for Package Body TEST_LIST_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_LIST_UTILS" 
  AS


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


END TEST_LIST_UTILS;

/
--------------------------------------------------------
--  DDL for Package Body TEST_SUBSTRING
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_SUBSTRING" AS

  procedure basic_usage AS
  BEGIN
    ut.expect( substring('1234567',2,5)).to_equal('4567');
    
  END basic_usage;

END TEST_SUBSTRING;

/
--------------------------------------------------------
--  DDL for Package Body TEST_TO_LOWER_CASE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_TO_LOWER_CASE" AS

    PROCEDURE first_test_to_lower_case AS
    BEGIN
        ut.expect(to_lower_case('ABC')).to_equal('abc');
    END first_test_to_lower_case;

END test_to_lower_case;

/
--------------------------------------------------------
--  DDL for Package Body TEST_TO_UPPER_CASE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_TO_UPPER_CASE" AS
    PROCEDURE first_test AS
    BEGIN
        ut.expect(TO_UPPER_CASE('abc')).to_equal('ABC');
    END first_test;

END test_to_upper_case;

/
