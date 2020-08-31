package body Fehlermeldungen is

   procedure Fehlermeldungen (WelcheFehlermeldung : in Integer) is
   begin
      
      Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (20, WelcheFehlermeldung)));
      -- while
      delay 1.0;
      
   end Fehlermeldungen;

end Fehlermeldungen;
