package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (14, ID)));
      
   end Beschreibung;

end GebaeudeDatenbank;
