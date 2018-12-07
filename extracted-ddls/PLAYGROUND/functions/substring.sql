CREATE OR REPLACE FUNCTION "PLAYGROUND"."SUBSTRING" (
    a_string      IN            VARCHAR2,
    a_start_pos   IN            NUMBER,
    a_end_pos     IN            NUMBER
) RETURN VARCHAR2 AS
BEGIN
    RETURN substr(a_string, a_end_pos - a_start_pos + 1);
END substring;
/
