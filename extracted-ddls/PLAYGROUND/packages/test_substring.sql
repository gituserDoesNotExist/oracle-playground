CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_SUBSTRING" AUTHID DEFINER AS 

  -- %suite(Test the substring function)
  -- %suitepath(substring)
  
  -- %test(Returns substring from start position to end position)
  procedure basic_usage;

END TEST_SUBSTRING;
/
