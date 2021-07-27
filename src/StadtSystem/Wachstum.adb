pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, StadtEinheitenBauen, StadtGebaeudeBauen, StadtEntfernen, WichtigesSetzen;

package body Wachstum is

   procedure Wachstum
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            exit StadtSchleife when GlobaleVariablen.RassenImSpiel (RasseEinsSchleifenwert) = GlobaleDatentypen.Leer;
            
            case
              StadtNummerSchleifenwert
            is
               when 1 =>
                  GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GesamteForschungsrate := 0;
                  GlobaleVariablen.Wichtiges (RasseEinsSchleifenwert).GeldZugewinnProRunde := 0;
                  
               when others =>
                  null;
            end case;
            
            case
              GlobaleVariablen.StadtGebaut (RasseEinsSchleifenwert, StadtNummerSchleifenwert).ID
            is
               when GlobaleDatentypen.Leer =>
                  null;
               
               when others =>
                  WachstumEinwohner (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
                  WachstumStadtExistiert (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
            end case;               
            
         end loop StadtSchleife;
      end loop RassenEinsSchleife;

      RassenZweiSchleife:
      for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseZweiSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            WichtigesSetzen.GeldFestlegen (RasseExtern        => RasseZweiSchleifenwert,
                                           GeldZugewinnExtern => Integer (GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GeldZugewinnProRunde));
         
            WichtigesSetzen.ForschungsmengeFestlegen (RasseExtern             => RasseZweiSchleifenwert,
                                                      ForschungZugewinnExtern => GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate);
         end if;
         
      end loop RassenZweiSchleife;
      
   end Wachstum;
   
   
   
   procedure WachstumStadtExistiert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GesamteForschungsrate
        + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate)
        > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GesamteForschungsrate := GlobaleDatentypen.KostenLager'Last;
               
      else
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GesamteForschungsrate := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GesamteForschungsrate
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate);
      end if;
            
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GeldZugewinnProRunde
        + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung)
        > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GeldZugewinnProRunde := GlobaleDatentypen.KostenLager'Last;
               
      else
         GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GeldZugewinnProRunde
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung);
      end if;

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate = 0
      then
         null;
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate > 0
      then
         WachstumProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;        
      
   end WachstumStadtExistiert;



   procedure WachstumBeiStadtGründung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
          StadtRasseNummerExtern.Rasse = GlobaleDatentypen.Rasse_1
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel / 2;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         EinwohnerÄnderung := True;
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * 5)
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         EinwohnerÄnderung := True;

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
               StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                                  StadtRasseNummerExtern   => StadtRasseNummerExtern);
               EinwohnerÄnderung := True;
         end case;
                  
      else
         null;
      end if;

      if
        EinwohnerÄnderung
        and
          (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           in
             9 .. 10
           or
             GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           in 19 .. 20)
      then
         StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         EinwohnerÄnderung := False;
            
      else
         null;
      end if;
      
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
         WichtigesSetzen.GeldFestlegen (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                        GeldZugewinnExtern => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate / 5));
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
                  
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
      in
        -- Gebäude
        1_001 .. 9_999
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
        -- Einheiten
        10_001 .. 99_999
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
