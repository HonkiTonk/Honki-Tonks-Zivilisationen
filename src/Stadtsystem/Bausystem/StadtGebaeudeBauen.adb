pragma SPARK_Mode (On);

with GlobaleTexte, StadtKonstanten, EinheitStadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Anzeige, GebaeudeAllgemein;

package body StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   IDExtern               =>
                                                     EinheitStadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - StadtKonstanten.GebäudeAufschlag));
            
      if
        GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Spieler_Mensch
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Keine_Aufgabe);
               
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                               TextZeileExtern => 29);
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauen;
