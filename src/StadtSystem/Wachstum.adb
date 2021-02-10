pragma SPARK_Mode (On);

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, Anzeige;

package body Wachstum is

   procedure Wachstum is
   begin
      
      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
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
                  WachstumEinwohner (StadtRasseUndNummer => (RasseIntern, StadtNummer));
            end case;

            GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate
              := GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleForschungsrate);
            GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleGeldgewinnung);

            case GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AktuelleProduktionrate is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (StadtRasseUndNummer => (RasseIntern, StadtNummer));
            end case;              
            
         end loop StadtSchleife;
      end loop RasseSchleife;

      for RasseInternZwei in GlobaleVariablen.StadtGebaut'Range (1) loop
         
         GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleGeldmenge + Integer (GlobaleVariablen.Wichtiges (RasseInternZwei).GeldZugewinnProRunde);
         GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsmenge := GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseInternZwei).AktuelleForschungsrate;
         
      end loop;
      
   end Wachstum;



   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
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



   procedure WachstumEinwohner (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin      
                     
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel
        + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsproduktion);

      if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel
        >= GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner * 5) then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwund  => True,
                                                            StadtRasseUndNummer => StadtRasseUndNummer);

      elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel < 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner - 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwund  => False,
                                                            StadtRasseUndNummer => StadtRasseUndNummer);
                  
      else
         null;
      end if;

      case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner is
         when 9 | 10 | 19 | 20 =>
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseUndNummer => StadtRasseUndNummer);
            
         when others =>
            return;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge
           := GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate / 5);
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen := 0;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt in 1_001 .. 9_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse, GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 1_000).PreisRessourcen then
            GebaeudeDatenbank.GebäudeProduktionBeenden (StadtRasseUndNummer => StadtRasseUndNummer,
                                                        ID                  => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 1_000);
            Anzeige.EinfacheAnzeige (Mit_Line => True,
                                     Datei    => 1,
                                     Eintrag  => 1);

         else
            null;
         end if;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt in 10_001 .. 99_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseUndNummer.Rasse,
                                                 GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen then
            EinheitenDatenbank.EinheitErzeugen (StadtRasseUndNummer => StadtRasseUndNummer,
                                                ID                  => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 10_000);
            if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 10_000 > 0 then
               Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                   AktuelleAuswahl    => 0,
                                   FrageDatei         => 0,
                                   FrageZeile         => 0,
                                   TextDatei          => 8,
                                   ErsteZeile         => 11,
                                   LetzteZeile        => 11);
                               
            else
               Anzeige.EinfacheAnzeige (Mit_Line => True,
                                        Datei    => 1,
                                        Eintrag  => 1);
            end if;

         else
            null;
         end if;

      else
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate);
      end if;
      
   end WachstumProduktion;

end Wachstum;
