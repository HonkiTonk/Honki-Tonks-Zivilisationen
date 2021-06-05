pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, Anzeige, StadtBauen, StadtEinheitenBauen;

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

            if
              GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleForschungsrate)
              > GlobaleDatentypen.KostenLager'Last
            then
               null;
               
            else
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).AktuelleForschungsrate
                 + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleForschungsrate);
            end if;
            
            if
              GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleGeldgewinnung)
              > GlobaleDatentypen.KostenLager'Last
            then
               null;
               
            else
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde
                 + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).AktuelleGeldgewinnung);
            end if;

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
         
         if
           GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleGeldmenge + Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde)
           > Integer'Last
         then
            null;
            
         else
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleGeldmenge
              := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleGeldmenge + Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde);
         end if;
         
         if
           GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsrate
           > GlobaleDatentypen.KostenLager'Last
         then
            null;
            
         else
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsmenge
              := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).AktuelleForschungsrate;
         end if;
         
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

         if
           GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleForschungsrate)
           > GlobaleDatentypen.KostenLager'Last
         then
            null;
            
         else
            GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate
              := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleForschungsrate);
         end if;

         if
           GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleGeldgewinnung)
           > GlobaleDatentypen.KostenLager'Last
         then
            null;
            
         else
            GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AktuelleGeldgewinnung);
         end if;           
            
      end loop StadtSchleife;
      
   end WachstumBeiStadtGründung;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsproduktion
        > GlobaleDatentypen.GesamtproduktionStadt'Last
      then
         null;
         
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsmittel
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleNahrungsproduktion;
      end if;

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
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner - 1;
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
         is
            when 0 =>
               StadtBauen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               null;
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
         if
           GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate / 5)
           > Integer'Last
         then
            null;
            
         else
            GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
              := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate / 5);
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
         end if;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt
      in
        1_001 .. 9_999 -- Gebäude
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.GebäudeAufschlag)).PreisRessourcen
         then
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
            
         else
            null;
         end if;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt
      in
        10_001 .. 99_999 -- Einheiten
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                 StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.EinheitAufschlag)).PreisRessourcen
         then
            StadtEinheitenBauen.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);            

         else
            null;
         end if;

      else
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate
           > GlobaleDatentypen.KostenLager'Last
         then
            null;
         
         else
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen
              + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate;
         end if;
      end if;
      
   end WachstumProduktion;

end Wachstum;
