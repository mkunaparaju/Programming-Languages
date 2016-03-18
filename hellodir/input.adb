--ADA Program example
with Ada.Text_IO;
use Ada.Text_IO;

procedure input is
Name : String (1 .. 5);

begin
	Put_Line("what is your name");
	Get(Name);
	if ( Name = "Apple") then 
		Put_Line("Hallo" & Name);
	else 
		Put_Line("Idont know you!");

	end if;	
end input;

