package body VerbesserungenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenVerbesserung) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (12, Integer (ID))));
      Put (Item => "    ");
      
   end Beschreibung;

end VerbesserungenDatenbank;
