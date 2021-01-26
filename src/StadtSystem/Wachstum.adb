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
                  WachstumEinwohner (RasseExtern => RasseIntern,
                                     StadtNummer => StadtNummer);
            end case;

            GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate
              := GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleForschungsrate);
            GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleGeldgewinnung);

            case GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AktuelleProduktionrate is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (RasseExtern => RasseIntern,
                                      StadtNummer => StadtNummer);
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



   procedure WachstumEinwohner (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin      
                     
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsproduktion);

      if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel >= GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner * 5) then
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (RasseExtern        => RasseExtern,
                                                            StadtNummer        => StadtNummer,
                                                            ZuwachsOderSchwund => True);

      elsif GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel < 0 then
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner - 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (RasseExtern        => RasseExtern,
                                                            StadtNummer        => StadtNummer,
                                                            ZuwachsOderSchwund => False);
                  
      else
         null;
      end if;

      case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner is
         when 9 | 10 | 19 | 20 =>
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (RasseExtern => RasseExtern,
                                                             StadtNummer => StadtNummer);
            
         when others =>
            return;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin
      
      if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleProduktionrate / 5);
         GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen := 0;
                  
      elsif GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt >= 1_001 and GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt <= 9_999 then
         GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen >= GebaeudeDatenbank.GebäudeListe (RasseExtern, GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt - 1_000).PreisRessourcen then
            GebaeudeDatenbank.GebäudeProduktionBeenden (RasseExtern        => RasseExtern,
                                                        Stadtnummer        => Stadtnummer,
                                                        ID                 => GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt - 1_000);
            Anzeige.EinfacheAnzeige (Mit_Line => True,
                                     Datei    => 1,
                                     Eintrag  => 1);

         else
            null;
         end if;
                  
      elsif GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt >= 10_001 and GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt <= 99_999 then
         GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt - 10_000)).PreisRessourcen then
            EinheitenDatenbank.EinheitErzeugen (RasseExtern        => RasseExtern,
                                                Stadtnummer        => Stadtnummer,
                                                ID                 => GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt - 10_000);
            if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuellesBauprojekt - 10_000 > 0 then
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
         GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleRessourcen + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AktuelleProduktionrate);
      end if;
      
   end WachstumProduktion;

end Wachstum;
