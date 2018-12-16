
DECLARE
  SHIT_1        SHIT        := NEW SHIT('hello');

  TEST_OBJECT_1 TEST_OBJECT := NEW TEST_OBJECT(SHIT_1);

  TMP_SHIT      SHIT;
BEGIN
  DBMS_OUTPUT.PUT_LINE('initial value of shit1: ' || SHIT_1.SOME_TEXT);
  SHIT_1.SET_SOME_TEXT('new text');
  DBMS_OUTPUT.PUT_LINE('new value set for shit1: ' || SHIT_1.SOME_TEXT);

  DBMS_OUTPUT.PUT_LINE('value of shit1 in test-object-1: ' || TEST_OBJECT_1.GET_SOME_SHIT().SOME_TEXT);
  DBMS_OUTPUT.PUT_LINE('value of shit1 in test-object-1: ' || TEST_OBJECT_1.SOME_SHIT.SOME_TEXT);


  TMP_SHIT := TEST_OBJECT_1.GET_SOME_SHIT();
  DBMS_OUTPUT.PUT_LINE('assigned shit1 to tmp-shit. value of tmp-shit: ' || TMP_SHIT.SOME_TEXT);
  TMP_SHIT.SET_SOME_TEXT('new tmp shit value');
  DBMS_OUTPUT.PUT_LINE('changed value of tmp-shit. new value: ' || TMP_SHIT.SOME_TEXT);

  DBMS_OUTPUT.PUT_LINE('shit value of test-object-1 is ' || TEST_OBJECT_1.GET_SOME_SHIT().SOME_TEXT);

END;