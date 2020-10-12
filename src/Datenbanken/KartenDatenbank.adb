package body KartenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (9, ID)));
      Put (Item => "    ");
      
   end Beschreibung;

end KartenDatenbank;
