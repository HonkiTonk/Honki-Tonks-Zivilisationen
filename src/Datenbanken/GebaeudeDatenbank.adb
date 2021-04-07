pragma SPARK_Mode (On);

with Anzeige;

package body GebaeudeDatenbank is

   procedure Beschreibung
     (IDExtern : in GebäudeID)
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                            TextZeileExtern => Positive (IDExtern));

      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GebäudeID)
   is begin     
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (IDExtern) := True;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 0;
                  
   end GebäudeProduktionBeenden;

end GebaeudeDatenbank;
