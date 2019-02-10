create or replace type cla as object    -- class (would be very complex)
(
  name  varchar2(50)
);
/

declare
    o1 cla;
    o2 cla;
begin
    o1 := cla('hi cloning world!');
    o2 := o1;
    o1.name := 'goodbye cloning world';

    dbms_output.put_line('o1.name: ' || o1.name);
    dbms_output.put_line('o2.name: ' || o2.name);
end;
