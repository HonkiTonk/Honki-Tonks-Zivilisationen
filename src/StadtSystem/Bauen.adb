package body Bauen is

   procedure Bauen (Rasse, StadtNummer : in Integer) is
   begin

      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := AuswahlStadt (Rasse       => Rasse,
                                              StadtNummer => StadtNummer);

         case WasGebautWerdenSoll is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen := 0;
               BauzeitEinzeln (Rasse       => Rasse,
                               StadtNummer => StadtNummer);
               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure BauzeitEinzeln (Rasse, StadtNummer : in Integer) is
   begin

      if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate = 0 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit := 10_000;

      elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit := 0;
            
      elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt < 10_000 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit
           := (GebaeudeDatenbank.GebäudeListe (Rasse, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt - 1_000).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen) / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit
           := (EinheitenDatenbank.EinheitenListe (Rasse, GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt - 10_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen) / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate);
      end if;
               
   end BauzeitEinzeln;



   procedure BauzeitAlle is
   begin
         
      RassenSchleife:
      for Rasse in GlobaleVariablen.RassenImSpiel'Range loop

         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
      
                  case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                        
                     when others =>
                        BauzeitEinzeln (Rasse       => Rasse,
                                        StadtNummer => StadtNummer);
                  end case;
      
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end BauzeitAlle;
   
   
   
   function AuswahlStadt (Rasse, StadtNummer : in Integer) return Integer is
   begin

      Ende := 1;
      AktuelleAuswahl := 1;
      Anzeige.TextBauen := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      GebäudeSchleife:
      for G in GlobaleVariablen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (14, G)) = "|" then
            exit GebäudeSchleife;

         elsif G > GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).GebäudeVorhanden'Last then
            exit GebäudeSchleife;

         elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).GebäudeVorhanden (G) /= '0' then
            null;

         elsif GebaeudeDatenbank.GebäudeListe (Rasse, G).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (Rasse, G).Anforderungen) = 0 then 
               null;

            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesen (14, G);
               Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesen (14, G);
            Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for E in GlobaleVariablen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (10, E)) = "|" then
            exit EinheitenSchleife;

         elsif E > EinheitenDatenbank.EinheitenListe'Last then
            exit EinheitenSchleife;

         elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AmWasser = False and EinheitenDatenbank.EinheitenListe (Rasse, GlobaleDatentypen.EinheitenID (E)).Passierbarkeit = 2 then
            null;

         elsif EinheitenDatenbank.EinheitenListe (Rasse, GlobaleDatentypen.EinheitenID (E)).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (Rasse, GlobaleDatentypen.EinheitenID (E)).Anforderungen) = 0 then
               null;
               
            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesen (10, E);
               Anzeige.TextBauen (Ende).Nummer := 10_000 + E;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesen (10, E);
            Anzeige.TextBauen (Ende).Nummer := 10_000 + E;
            Ende := Ende + 1;
         end if;
         
      end loop EinheitenSchleife;

      if Anzeige.TextBauen (Ende).Nummer = 0 and Ende > 1 then
         Anzeige.TextBauen (Ende).Text := To_Unbounded_Wide_Wide_String (Source => "Zurück");

      elsif Anzeige.TextBauen (Ende).Nummer = 0 and Ende = 1 then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesen (19, 27);
      end if;

      AuswahlSchleife:
      loop

         Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (21, 13)));  
         Anzeige.AnzeigeStadt (AktuelleAuswahl => AktuelleAuswahl);
         
         if AktuelleAuswahl = Ende then
            null;
                  
         elsif Anzeige.TextBauen (AktuelleAuswahl).Nummer > 10_000 then
            Anzeige.AnzeigeLangerText (WelcherText => 11,
                                       WelcheZeile => Anzeige.TextBauen (AktuelleAuswahl).Nummer - 10_000);
            
         else
            Anzeige.AnzeigeLangerText (WelcherText => 15,
                                       WelcheZeile => Anzeige.TextBauen (AktuelleAuswahl).Nummer - 1_000);
         end if;
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Anzeige.TextBauen'First then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Anzeige.TextBauen'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return Anzeige.TextBauen (AktuelleAuswahl).Nummer;

            when 'q' =>
               return 0;
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end AuswahlStadt;

end Bauen;
