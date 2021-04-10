pragma SPARK_Mode (On);

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, Anzeige, StadtBauen;

package body Wachstum is

   procedure Wachstum
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            case
              StadtNummerSchleifenwert
            is
               when 1 =>
                  GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate := 0;
                  GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := 0;
                  
               when others =>
                  null;
            end case;
            
            case
              GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).ID
            is
               when 0 =>
                  null;
               
               when others =>
                  WachstumEinwohner (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
            end case;

            GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleForschungsrate);
            GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleGeldgewinnung);

            case
              GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleProduktionrate
            is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
            end case;              
            
         end loop StadtSchleife;
      end loop RassenEinsSchleife;

      RassenZweiSchleife:
      for RasseZweiSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleGeldmenge
           := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleGeldmenge + Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde);
         GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsmenge
           := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsrate;
         
      end loop RassenZweiSchleife;
      
   end Wachstum;



   procedure WachstumBeiStadtGründung
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         case
           StadtNummerSchleifenwert
         is
            when 1 =>
               GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := 0;
                  
            when others =>
               null;
         end case;

         GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate
           := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleForschungsrate);
         GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde
           := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleGeldgewinnung);                      
            
      end loop StadtSchleife;
      
   end WachstumBeiStadtGründung;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin      
                     
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsproduktion;

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner * 5)
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel < 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel := 0;
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
         is
            when 0 =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner := 0;
               
            when others =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner - 1;
         end case;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
         is
            when 0 =>
               StadtBauen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when others =>
               null;
         end case;
                  
      else
         null;
      end if;

      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
      is
         when 9 | 10 | 19 | 20 =>
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when others =>
            return;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0
      then
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
           := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate / 5);
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt
      in
        1_001 .. 9_999
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 1_000)).PreisRessourcen
         then
            GebaeudeDatenbank.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         IDExtern               => GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                           StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 1_000));
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                                  TextZeileExtern => 29);
            
         else
            null;
         end if;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt
      in
        10_001 .. 99_999
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                 StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen
         then
            EinheitenDatenbank.EinheitErzeugen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                IDExtern               => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                  StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000));
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000 > 0
            then
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
