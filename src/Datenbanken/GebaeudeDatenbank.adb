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
   
   

   procedure GebäudeProduktionBeenden (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord; ID : in Positive) is
   begin     
      
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).GebäudeVorhanden (ID) := GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse, ID).Anzeige;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
