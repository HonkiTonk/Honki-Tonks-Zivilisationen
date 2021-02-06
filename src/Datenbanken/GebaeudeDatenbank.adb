pragma SPARK_Mode (On);

with Anzeige;

package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Positive) is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 16,
                          ErsteZeile         => ID,
                          LetzteZeile        => ID);
      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer, ID : in Positive) is
   begin     
      
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).GebäudeVorhanden (ID) := GebaeudeDatenbank.GebäudeListe (RasseExtern, ID).Anzeige;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).VerbleibendeBauzeit := 0;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleRessourcen := 0;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
