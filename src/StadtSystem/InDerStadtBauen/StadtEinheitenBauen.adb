pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with Anzeige;

package body StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).ID = 0
         then
            EinheitNummer := EinheitNummerSchleifenwert;
            exit EinheitenSchleife;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;
      
      -- Hier noch Prüfung für die Stadtumgebung einbauen

      case
        EinheitNummer
      is
         when 0 =>
            null;
            
         when others =>
            EinheitenDatenbank.EinheitErzeugen (KoordinatenExtern            => KartenWert,
                                                EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummer),
                                                IDExtern                     => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                  StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.EinheitAufschlag));
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 0;
            return;
      end case;
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.EinheitAufschlag > 0
        and
          StadtRasseNummerExtern.Rasse = 1
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 11);
               
      elsif
        StadtRasseNummerExtern.Rasse = 1
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                               TextZeileExtern => 29);
         
      else
         null;
      end if;
      
   end EinheitFertiggestellt;

end StadtEinheitenBauen;
