pragma SPARK_Mode (On);

with Anzeige;

package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in GebäudeID) is
   begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                            TextZeile => Positive (ID));

      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord; ID : in GebäudeID) is
   begin     
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden (ID) := True;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
