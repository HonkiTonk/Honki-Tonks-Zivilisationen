package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (14, ID)));
      
   end Beschreibung;

end GebaeudeDatenbank;
