package body Fehlermeldungen is

   procedure Fehlermeldungen (WelcheFehlermeldung : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (20, WelcheFehlermeldung)));
      delay 1.0;
      
   end Fehlermeldungen;

end Fehlermeldungen;
