pragma SPARK_Mode (On);

with EinheitStadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with GebaeudeAllgemein;

package body StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   IDExtern               => EinheitStadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer));
            
      if
        GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.SpielerMenschKonstante
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Keine_Aufgabe);
               
      else
         -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
         --                                      TextZeileExtern => 29);
         null;
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauen;
