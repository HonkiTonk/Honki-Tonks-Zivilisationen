package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (14, ID)));
      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer, ID : in Integer) is
   begin     
      
            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).GebäudeVorhanden (ID) := GebaeudeDatenbank.GebäudeListe (RasseExtern, ID).Anzeige;
            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
