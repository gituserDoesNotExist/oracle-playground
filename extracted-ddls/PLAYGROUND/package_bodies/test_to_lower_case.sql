CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_TO_LOWER_CASE" AS

    PROCEDURE first_test_to_lower_case AS
    BEGIN
        ut.expect(to_lower_case('ABC')).to_equal('abc');
    END first_test_to_lower_case;

END test_to_lower_case;
/
