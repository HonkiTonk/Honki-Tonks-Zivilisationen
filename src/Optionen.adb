package body Optionen is

   procedure Optionen is
   begin
      
      Put_Line ("Gibt keine Optionen.");
      Put_Line ("Taste drücken um zurück ins Hauptmenü zu kommen.");
      
      Get_Immediate (Taste);
      
   end Optionen;



   procedure SteuerungBelegen is
   begin
      
      null;
      
   end SteuerungBelegen;

end Optionen;
