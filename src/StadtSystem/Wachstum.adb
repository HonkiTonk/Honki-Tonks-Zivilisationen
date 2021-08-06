pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, StadtEinheitenBauen, StadtGebaeudeBauen, StadtEntfernen, WichtigesSetzen, StadtWerteTesten, Sichtbarkeit, StadtMeldungenSetzen;

package body Wachstum is

   procedure Wachstum
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseEinsSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseEinsSchleifenwert).Städtegrenze loop
            
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
                        WachstumStadtExistiert (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert),
                                                StadtGegründetExtern  => False);
                  end case;               
            
               end loop StadtSchleife;
         end case;
         
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
            
            if
              GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate < 0
            then
               GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate := 0;
         
            else
               null;
            end if;
         
            WichtigesSetzen.ForschungsmengeFestlegen (RasseExtern             => RasseZweiSchleifenwert,
                                                      ForschungZugewinnExtern => GlobaleVariablen.Wichtiges (RasseZweiSchleifenwert).GesamteForschungsrate);
         end if;
         
      end loop RassenZweiSchleife;
      
   end Wachstum;
   
   
   
   procedure WachstumStadtExistiert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtGegründetExtern : in Boolean)
   is begin
      
      WichtigesSetzen.ForschungsrateFestlegen (RasseExtern                  => StadtRasseNummerExtern.Rasse,
                                               ForschungsrateZugewinnExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate);
      
      WichtigesSetzen.GeldZugewinnFestlegen (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                             GeldZugewinnExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung);
                  
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate > 0
        and
          StadtGegründetExtern = False
      then
         WachstumProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;        
   
   end WachstumStadtExistiert;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtWerteTesten.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * 5)
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (3) = True
        and
          StadtRasseNummerExtern.Rasse = GlobaleDatentypen.Menschen
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel / 2;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         WachstumSchrumpfung := True;
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        > GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * 5)
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         WachstumSchrumpfung := True;

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel < 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := 0;
         
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
         is
            when 1 =>
               StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                                  StadtRasseNummerExtern   => StadtRasseNummerExtern);
               WachstumSchrumpfung := False;
         end case;
                  
      else
         return;
      end if;

      case
        WachstumSchrumpfung
      is
         when True =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => GlobaleDatentypen.Einwohner_Wachstum);
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) = StadtWerteFestlegen.EinwohnerErstesWachstum
              or
                GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) = StadtWerteFestlegen.EinwohnerZweitesWachstum
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => GlobaleDatentypen.Einwohner_Reduktion);
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) = StadtWerteFestlegen.EinwohnerErstesWachstum - 1
              or
                GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) = StadtWerteFestlegen.EinwohnerZweitesWachstum - 1
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtWerteTesten.Produktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
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
