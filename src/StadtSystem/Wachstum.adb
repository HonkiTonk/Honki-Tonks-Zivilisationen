pragma SPARK_Mode (On);

with StadtWerteFestlegen, GebaeudeDatenbank, EinheitenDatenbank, Anzeige;

package body Wachstum is

   procedure Wachstum is
   begin
      
      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
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
                  WachstumEinwohner (StadtRasseNummer => (RasseIntern, StadtNummer));
            end case;

            GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate
              := GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsrate + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleForschungsrate);
            GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde
              := GlobaleVariablen.Wichtiges (RasseIntern).GeldZugewinnProRunde + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AktuelleGeldgewinnung);

            case GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AktuelleProduktionrate is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (StadtRasseNummer => (RasseIntern, StadtNummer));
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



   procedure WachstumEinwohner (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin      
                     
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel
        + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion);

      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel
        >= GlobaleDatentypen.KostenLager (10 + GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner * 5) then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwund  => True,
                                                            StadtRasseNummer => StadtRasseNummer);

      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel < 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner - 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwund  => False,
                                                            StadtRasseNummer => StadtRasseNummer);
                  
      else
         null;
      end if;

      case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner is
         when 9 | 10 | 19 | 20 =>
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummer => StadtRasseNummer);
            
         when others =>
            return;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
           := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge + Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate / 5);
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen := 0;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt in 1_001 .. 9_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           >= GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse,
                                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 1_000)).PreisRessourcen then
            GebaeudeDatenbank.GebäudeProduktionBeenden (StadtRasseNummer => StadtRasseNummer,
                                                         ID               => GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 1_000));
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Zeug,
                                                  TextZeile => 29);
            
         else
            null;
         end if;
                  
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt in 10_001 .. 99_999 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate);
         if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           >= EinheitenDatenbank.EinheitenListe (StadtRasseNummer.Rasse,
                                                 GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen then
            EinheitenDatenbank.EinheitErzeugen (StadtRasseNummer => StadtRasseNummer,
                                                ID                  => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 10_000);
            if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 10_000 > 0 then
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fehlermeldungen,
                                                     TextZeile => 11);
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Zeug,
                                                     TextZeile => 29);
            end if;

         else
            null;
         end if;

      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen
           + GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate);
      end if;
      
   end WachstumProduktion;

end Wachstum;
