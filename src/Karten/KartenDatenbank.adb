package body KartenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin

      Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (9, ID)));
      Put ("    ");
      
   end Beschreibung;

end KartenDatenbank;
