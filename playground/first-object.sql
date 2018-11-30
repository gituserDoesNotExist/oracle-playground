DROP TYPE TEST_OBJECT;

CREATE TYPE TEST_OBJECT
  AUTHID DEFINER
  AS
  OBJECT (V_TXT VARCHAR2(100),
          CONSTRUCTOR FUNCTION TEST_OBJECT(P_V_TXT  VARCHAR2,
                                           P_V_TXT2 VARCHAR2)
            RETURN SELF AS RESULT);
/
CREATE TYPE BODY TEST_OBJECT
  AS

    CONSTRUCTOR FUNCTION TEST_OBJECT(P_V_TXT  VARCHAR2,
                                     P_V_TXT2 VARCHAR2)
      RETURN SELF AS RESULT
      IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('constructor called');
        DBMS_OUTPUT.PUT_LINE('second parameter is: ' || P_V_TXT2);
        SELF.V_TXT := P_V_TXT;
        RETURN;
      END;

  END;
/