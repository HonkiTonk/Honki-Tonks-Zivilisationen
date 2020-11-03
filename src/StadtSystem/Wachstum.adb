package body Wachstum is

   procedure Wachstum is
   begin
      
      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            case StadtNummer is
               when 1 =>
                  GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := 0;
                  GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := 0;
                  
               when others =>
                  null;
            end case;
            
            case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID is
               when 0 =>
                  exit StadtSchleife;
               
               when others =>
                  WachstumEinwohner (Rasse       => Rasse,
                                     StadtNummer => StadtNummer);
            end case;

            GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate;
            GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung;

            case GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate is
               when 0 =>
                  null;
                  
               when others =>
                  WachstumProduktion (Rasse       => Rasse,
                                      StadtNummer => StadtNummer);
            end case;              
            
         end loop StadtSchleife;
      end loop RasseSchleife;

      for RasseZwei in GlobaleVariablen.StadtGebaut'Range (1) loop
         
         GlobaleVariablen.Wichtiges (RasseZwei).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (RasseZwei).AktuelleGeldmenge + GlobaleVariablen.Wichtiges (RasseZwei).GeldZugewinnProRunde;
         GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsmenge := GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsrate;
         
      end loop;
      
   end Wachstum;



   procedure WachstumBeiStadtGründung (Rasse : in Integer) is
   begin
      
      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
         case StadtNummer is
            when 1 =>
               GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := 0;
               GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := 0;
                  
            when others =>
               null;
         end case;

         GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate;
         GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung;                      
            
      end loop StadtSchleife;
      
   end WachstumBeiStadtGründung;



   procedure WachstumEinwohner (Rasse, StadtNummer : in Integer) is
   begin      
                     
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel
        := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion;

      if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel >= 10 + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner * 5 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner + 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (Rasse              => Rasse,
                                                            StadtNummer        => StadtNummer,
                                                            ZuwachsOderSchwund => True);

      elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel < 0 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel := 0;
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner - 1;
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (Rasse              => Rasse,
                                                            StadtNummer        => StadtNummer,
                                                            ZuwachsOderSchwund => False);
                  
      else
         null;
      end if;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion (Rasse, StadtNummer : in Integer) is
   begin
      
      if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate / 5;
         GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
                  
      elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt >= 1_001 and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt <= 9_999 then
         GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
         if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen >= GebaeudeDatenbank.GebäudeListe (Rasse, GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000).PreisRessourcen then
            GebaeudeDatenbank.GebäudeProduktionBeenden (Rasse              => Rasse,
                                                         Stadtnummer        => Stadtnummer,
                                                         ID                 => GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000);
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 29)));

         else
            null;
         end if;
                  
      elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt >= 10_001 and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt <= 99_999 then
         GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
         if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen >= EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000).PreisRessourcen then
            EinheitenDatenbank.EinheitErzeugen (Rasse              => Rasse,
                                                Stadtnummer        => Stadtnummer,
                                                ID                 => GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000);
            if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000 > 0 then
               Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (20, 11)));
                               
            else
               Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 29)));
            end if;

         else
            null;
         end if;

      else
         GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
      end if;
      
   end WachstumProduktion;

end Wachstum;
