package body Optionen is

   procedure Optionen is
   begin
      
      Put_Line (Item => "Gibt keine Optionen.");
      Put_Line (Item => "Taste drücken um zurück ins Hauptmenü zu kommen.");
      
      Get_Immediate (Item => Taste);
      
   end Optionen;



   procedure SteuerungBelegen is
   begin
      
      null;
      
   end SteuerungBelegen;

end Optionen;
