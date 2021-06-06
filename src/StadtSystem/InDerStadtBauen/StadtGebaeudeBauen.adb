pragma SPARK_Mode (On);

with GlobaleKonstanten;

with GebaeudeDatenbank;

with Anzeige;

package body StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeDatenbank.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   IDExtern               => GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                     StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.GebäudeAufschlag));
            
      if
        StadtRasseNummerExtern.Rasse /= 1
      then   
         null;
               
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                               TextZeileExtern => 29);
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauen;
