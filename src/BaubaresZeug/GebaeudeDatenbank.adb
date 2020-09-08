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
            
         when others =>
            if Produktionsnummer < 10_000 then
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 1_000).PreisRessourcen / GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
               
            else
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt - 10_000).PreisRessourcen / GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleProduktionrate;
            end if;
      end case;
      
   end ProduktionFestlegen;



   procedure ProduktionDurchführen (Rasse : Integer) is
   begin
      
      StadtSchleife:
      for A in GlobaleVariablen.StadtGebaut'Range (2) loop -- Hier das Überarbeiten anfangen
         
         if GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt = 0 then
            GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge + GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate / 5;

         else
            GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen := GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen + GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate;
            if GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt < 10_000
              and GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen >= GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt - 1_000).PreisRessourcen then
               ProduktionBeenden (Rasse       => Rasse,
                                  Stadtnummer => A);
               
            elsif GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt > 10_000
              and GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen >= EinheitenDatenbank.EinheitenListe (GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt - 10_000).PreisRessourcen then
               ProduktionBeenden (Rasse       => Rasse,
                                  Stadtnummer => A);
      
            else
               if GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate = 0 then
                  null;
                  
               else
                  if GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt < 10_000 then
                  GlobaleVariablen.StadtGebaut (Rasse, A).VerbleibendeBauzeit := (GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt - 1_000).PreisRessourcen - GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen) / GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate;

                  else
                     GlobaleVariablen.StadtGebaut (Rasse, A).VerbleibendeBauzeit := (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.StadtGebaut (Rasse, A).AktuellesBauprojekt - 10_000).PreisRessourcen - GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleRessourcen) / GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate;
                  end if;
                 end if;
            end if;
         end if;
         
      end loop StadtSchleife;
      
   end ProduktionDurchführen;

   

   procedure ProduktionBeenden (Rasse, Stadtnummer : in Integer) is
   begin      
      
      -- Hier noch Gebäude oder Einheiten setzen, dabei abfragen ob sich hier bereits eine Einheit befindet und entsprechend platzieren/Meldung ausgeben.

      GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := 0;
      GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
      GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt := 0;
      
   end ProduktionBeenden;

end GebaeudeDatenbank;
