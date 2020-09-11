package body GebaeudeDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (14, ID)));
      
   end Beschreibung;



   procedure ProduktionFestlegen (Rasse, Stadtnummer, Produktionsnummer : in Integer) is
   begin
      
      GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt := Produktionsnummer;
      GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
      case GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate is
         when 0 =>
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := 10_000;
            
         when others => -- Den Teil als verallgemeinerte Form auslagern und entsprechend zur Neubestimmung der Produktionszeit überall einbauen wo es nötig ist
            if Produktionsnummer < 10_000 then
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000).PreisRessourcen / GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
               
            else
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := EinheitenDatenbank.EinheitenListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000).PreisRessourcen / GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
            end if;
      end case;
      
   end ProduktionFestlegen;



   procedure ProduktionDurchführen is
   begin
      
      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
            if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
               exit StadtSchleife;

            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate = 0 then
               null;
               
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt = 0 then
               GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate / 5;
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
                  
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt >= 1_001 and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt <= 9_999 then
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
               if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen >= GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000).PreisRessourcen then
                  ProduktionBeenden (GebäudeOderEinheit => True,
                                     Rasse              => Rasse,
                                     Stadtnummer        => Stadtnummer,
                                     Wert => GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000);

               else
                  null;
               end if;
                  
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt >= 10_001 and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt <= 99_999 then
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
               if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen >= EinheitenDatenbank.EinheitenListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000).PreisRessourcen then
                  ProduktionBeenden (GebäudeOderEinheit => True,
                                     Rasse              => Rasse,
                                     Stadtnummer        => Stadtnummer,
                                     Wert => GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000);

               else
                  null;
               end if;

            else
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
            end if;
         
         end loop StadtSchleife;
      end loop RasseSchleife;
      
   end ProduktionDurchführen;

   

   procedure ProduktionBeenden (GebäudeOderEinheit : in Boolean; Rasse, Stadtnummer, Wert : in Integer) is
   begin     

      case GebäudeOderEinheit is
         when True =>
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).GebäudeVorhanden (Wert) := GebaeudeDatenbank.GebäudeListe (Wert).Anzeige;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt := 0;
            
         when False =>
            EinheitenDatenbank.EinheitErzeugen (Rasse       => Rasse,
                                                Stadtnummer => Stadtnummer,
                                                ID          => Wert);
      end case;
      
   end ProduktionBeenden;

end GebaeudeDatenbank;
