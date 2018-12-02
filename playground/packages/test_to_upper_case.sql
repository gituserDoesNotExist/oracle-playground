CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_TO_UPPER_CASE" AUTHID DEFINER AS 

    -- %suite(test to_upper_case function)
    -- %suitepath(upper.lower.case.suite)
    
    -- %test(first test)
    procedure first_test;

END TEST_TO_UPPER_CASE;
/


CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_TO_UPPER_CASE" AS
    PROCEDURE first_test AS
    BEGIN
        ut.expect(TO_UPPER_CASE('abc')).to_equal('ABC');
    END first_test;

END test_to_upper_case;
/
