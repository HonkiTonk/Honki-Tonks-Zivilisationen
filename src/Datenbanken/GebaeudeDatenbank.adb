package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (14, ID)));
      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden (Rasse, StadtNummer, ID : in Integer) is
   begin     
      
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).GebäudeVorhanden (ID) := GebaeudeDatenbank.GebäudeListe (Rasse, ID).Anzeige;
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
