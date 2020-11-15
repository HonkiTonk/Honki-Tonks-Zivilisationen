package body KartenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenGrund) is
   begin

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (9, Integer (ID))));
      Put (Item => "    ");
      
   end Beschreibung;

end KartenDatenbank;
