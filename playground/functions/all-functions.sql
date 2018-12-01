--------------------------------------------------------
--  File created - Saturday-December-01-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function SUBSTRING
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "PLAYGROUND"."SUBSTRING" (
    a_string      IN            VARCHAR2,
    a_start_pos   IN            NUMBER,
    a_end_pos     IN            NUMBER
) RETURN VARCHAR2 AS
BEGIN
    RETURN substr(a_string, a_end_pos - a_start_pos + 1);
END substring;

/
--------------------------------------------------------
--  DDL for Function TO_LOWER_CASE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "PLAYGROUND"."TO_LOWER_CASE" (
    p_v_input IN   VARCHAR2
) RETURN VARCHAR2 AS
BEGIN
    RETURN LOWER(p_v_input);
END to_lower_case;

/
--------------------------------------------------------
--  DDL for Function TO_UPPER_CASE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "PLAYGROUND"."TO_UPPER_CASE" (
    p_v_input IN   VARCHAR2
) RETURN VARCHAR2 AS
BEGIN
    RETURN UPPER(p_v_input);
END to_upper_case;

/
