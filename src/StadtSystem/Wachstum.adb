pragma SPARK_Mode (On);

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, Anzeige, StadtBauen;

package body Wachstum is

   procedure Wachstum is
   begin
      
      RasseSchleife:
      for RasseIntern in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            case StadtNummer is
               when 1 =>
                  GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate := 0;
                  GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde := 0;
                  
               when others =>
                  null;
            end case;
            
            case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID is
               when 0 =>
                  exit StadtSchleife;
               
               when others =>
                  WachstumEinwohner (StadtRasseNummerExtern => (RasseIntern, StadtNummer));
            end case;

            GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate
              := GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleForschungsrate);
            GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleGeldgewinnung);

            case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleProduktionrate is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (StadtRasseNummerExtern => (RasseIntern, StadtNummer));
            end case;              
            
         end loop StadtSchleife;
      end loop RasseSchleife;

      for RasseInternZwei in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleGeldmenge + Integer (GlobaleVariablen.Wichtiges (RasseInternZwei).GeldZugewinnProRunde);
         GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsmenge := GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsrate;
         
      end loop;
      
   end Wachstum;



   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         case StadtNummer is
            when 1 =>
               GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := 0;
                  
            when others =>
               null;
         end case;

         GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate
           := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleForschungsrate);
         GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde
           := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleGeldgewinnung);                      
            
      end loop StadtSchleife;
      
   end WachstumBeiStadtGründung;



   procedure WachstumEinwohner (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin      
                     
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsproduktion;

      if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner * 5) then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);

      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel < 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel := 0;
         case GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner is
            when 0 =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner := 0;
               
            when others =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner - 1;
         end case;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         case GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner is
            when 0 =>
               StadtBauen.StadtEntfernenMitSortieren (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when others =>
               null;
         end case;
                  
      else
         null;
      end if;

      case GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner is
         when 9 | 10 | 19 | 20 =>
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when others =>
            return;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
           := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate / 5);
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt in 1_001 .. 9_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 1_000)).PreisRessourcen then
            GebaeudeDatenbank.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         IDExtern               => GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                           StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 1_000));
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                                  TextZeileExtern => 29);
            
         else
            null;
         end if;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt in 10_001 .. 99_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                 StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen then
            EinheitenDatenbank.EinheitErzeugen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                IDExtern               => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                  StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000));
            if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000 > 0 then
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                     TextZeileExtern => 11);
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                                     TextZeileExtern => 29);
            end if;

         else
            null;
         end if;

      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
      end if;
      
   end WachstumProduktion;

end Wachstum;
