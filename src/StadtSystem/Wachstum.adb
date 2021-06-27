pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, StadtBauen, StadtEinheitenBauen, StadtGebaeudeBauen, LesenGlobaleVariablen, EintragenGlobaleVariablen, ZugriffGebaeudeDatenbank;

package body Wachstum is

   procedure Wachstum
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            case
              StadtNummerSchleifenwert
            is
               when 1 =>
                  EintragenGlobaleVariablen.WichtigesGesamteForschungsrate (RasseExtern                 => RasseEinsSchleifenwert,
                                                                            GesamteForschungsrateExtern => 0);
                  GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := 0;
                  
               when others =>
                  null;
            end case;
            
            case
              LesenGlobaleVariablen.StadtID (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert))
            is
               when 0 =>
                  null;
               
               when others =>
                  WachstumEinwohner (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
            end case;
            
            -- Wird auch dann ausgeführt wenn die ID = 0 ist, mal auslagern
            if
              GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GesamteForschungsrate
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).Forschungsrate)
              > GlobaleDatentypen.KostenLager'Last
            then
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GesamteForschungsrate := GlobaleDatentypen.KostenLager'Last;
               
            else
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GesamteForschungsrate := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GesamteForschungsrate
                 + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).Forschungsrate);
            end if;
            
            if
              GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde
              + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).Geldgewinnung)
              > GlobaleDatentypen.KostenLager'Last
            then
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := GlobaleDatentypen.KostenLager'Last;
               
            else
               GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde
                 + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).Geldgewinnung);
            end if;

            case
              GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).Produktionrate
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
           GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Geldmenge + Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde)
           > Integer'Last
         then
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Geldmenge := Integer'Last;
            
         else
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Geldmenge
              := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Geldmenge + Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde);
         end if;
         
         if
           GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Forschungsmenge + GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate
           > GlobaleDatentypen.KostenLager'Last
         then
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Forschungsmenge := GlobaleDatentypen.KostenLager'Last;
            
         else
            GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Forschungsmenge
              := GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).Forschungsmenge + GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate;
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
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := 0;
                  
            when others =>
               null;
         end case;

         if
           GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Forschungsrate)
           > GlobaleDatentypen.KostenLager'Last
         then
            GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleDatentypen.KostenLager'Last;
            
         else
            GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate
              := GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Forschungsrate);
         end if;

         if
           GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Geldgewinnung)
           > GlobaleDatentypen.KostenLager'Last
         then
            GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleDatentypen.KostenLager'Last;
            
         else
            GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Geldgewinnung);
         end if;           
            
      end loop StadtSchleife;
      
   end WachstumBeiStadtGründung;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
        > GlobaleDatentypen.GesamtproduktionStadt'Last
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := GlobaleDatentypen.GesamtproduktionStadt'Last;
         
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion;
      end if;

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * 5)
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (3) = True
        and
          StadtRasseNummerExtern.Rasse = 1
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel / 2;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * 5)
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel < 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) - 1;
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
         is
            when 0 =>
               StadtBauen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               null;
         end case;
         
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         
      else
         null;
      end if;

      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
        > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := GlobaleDatentypen.KostenLager'Last;
              
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      end if;
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt = 0
      then
         if
           GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate / 5)
           > Integer'Last
         then
            GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge := Integer'Last;
            
         else
            GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
              := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
              + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate / 5);
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
         end if;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
      in
        1_001 .. 9_999 -- Gebäude
      then         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                 StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.GebäudeAufschlag)).PreisRessourcen
         then
            StadtGebaeudeBauen.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            null;
         end if;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
      in
        10_001 .. 99_999 -- Einheiten
      then
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                 StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.EinheitAufschlag)).PreisRessourcen
         then
            StadtEinheitenBauen.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);            

         else
            null;
         end if;

      else
         null;
      end if;
      
   end WachstumProduktion;

end Wachstum;
