package body KartenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin

      Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (9, ID)));
      
   end Beschreibung;

end KartenDatenbank;
