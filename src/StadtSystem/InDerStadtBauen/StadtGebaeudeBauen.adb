pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with Anzeige, GebaeudeAllgemein;

package body StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   IDExtern               => GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                     StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.GebäudeAufschlag));
            
      if
        StadtRasseNummerExtern.Rasse /= 1
      then   
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Keine_Aufgabe;
               
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                               TextZeileExtern => 29);
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauen;
