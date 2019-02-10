SET SERVEROUTPUT ON;

DECLARE
    food_id   food.id%TYPE;
    vitamin_id   vitamine.id%TYPE;
    vitamin_food_id   vitamine.food_id%TYPE;
BEGIN
 --dbms_output.put_line('next val ' || seq_food.nextval);
    create_food(food_id, 'name',vitamin_id,1,1,1,1,1,1,1,1,1,1,vitamin_food_id);
    
    dbms_output.put_line('food_id=' || food_id);
    dbms_output.put_line('vitamin_id=' || vitamin_id);
    dbms_output.put_line('vitamin_food_id=' || vitamin_food_id);
END;