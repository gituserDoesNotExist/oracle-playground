CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_TO_UPPER_CASE" AS
    PROCEDURE first_test AS
    BEGIN
        ut.expect(TO_UPPER_CASE('abc')).to_equal('ABC');
    END first_test;

END test_to_upper_case;
/
