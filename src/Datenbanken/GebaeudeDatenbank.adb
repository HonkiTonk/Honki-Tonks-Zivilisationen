package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (14, ID)));
      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden (Rasse, Stadtnummer, ID : in Integer) is
   begin     
      
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).GebäudeVorhanden (ID) := GebaeudeDatenbank.GebäudeListe (ID).Anzeige;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
