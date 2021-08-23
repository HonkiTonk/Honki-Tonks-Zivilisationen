pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with Anzeige, GebaeudeAllgemein, LeseStadtGebaut, SchreibeStadtGebaut;

package body StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   IDExtern               =>
                                                     GlobaleDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.GebäudeAufschlag));
            
      if
        GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Spieler_Mensch
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Keine_Aufgabe);
               
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                               TextZeileExtern => 29);
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauen;
