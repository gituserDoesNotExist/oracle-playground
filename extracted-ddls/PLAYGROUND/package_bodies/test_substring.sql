CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_SUBSTRING" AS

  procedure basic_usage AS
  BEGIN
    ut.expect( substring('1234567',2,5)).to_equal('4567');
    
  END basic_usage;

END TEST_SUBSTRING;
/
