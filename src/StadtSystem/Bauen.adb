package body Bauen is

   procedure Bauen (Rasse, StadtPositionInListe : in Integer) is
   begin

      GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := AuswahlStadt (Rasse => Rasse,
                                              WelcheStadt => StadtPositionInListe);

         case WasGebautWerdenSoll is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleRessourcen := 0;
               Bauzeit (Rasse => Rasse);

               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure Bauzeit (Rasse : in Integer) is
   begin
      
      for StadtPositionInListe in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         if GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).ID = 0 then
            exit;
            
         elsif GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleProduktionrate = 0 then
            GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).VerbleibendeBauzeit := 10_000;

         elsif GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt = 0 then
            GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).VerbleibendeBauzeit := 0;
            
         elsif GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt < 10_000 then
            GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).VerbleibendeBauzeit := (GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt - 1_000).PreisRessourcen - GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleRessourcen) / GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleProduktionrate;
               
         else
            GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).VerbleibendeBauzeit := (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt - 10_000).PreisRessourcen - GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleRessourcen) / GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleProduktionrate;
         end if;
         
      end loop;
      
   end Bauzeit;
   
   
   
   function AuswahlStadt (Rasse, WelcheStadt : in Integer) return Integer is
   begin

      Ende := 1;
      AktuelleAuswahl := 1;
      Anzeige.TextBauen := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      GebäudeSchleife:
      for G in Einlesen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (14, G)) = "|" then
            exit GebäudeSchleife;

         elsif G > GlobaleVariablen.StadtGebaut (Rasse, WelcheStadt).GebäudeVorhanden'Last then
            exit GebäudeSchleife;

         elsif GlobaleVariablen.StadtGebaut (Rasse, WelcheStadt).GebäudeVorhanden (G) /= '0' then
            null;

         elsif GebaeudeDatenbank.GebäudeListe (G).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (G).Anforderungen) = '0' then 
               null;

            else
               Anzeige.TextBauen (Ende).Text := Einlesen.TexteEinlesen (14, G);
               Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := Einlesen.TexteEinlesen (14, G);
            Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for E in Einlesen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (10, E)) = "|" then
            exit EinheitenSchleife;

         elsif E > EinheitenDatenbank.EinheitenListe'Last then
            exit EinheitenSchleife;

         elsif GlobaleVariablen.StadtGebaut (Rasse, WelcheStadt).AmWasser = False and EinheitenDatenbank.EinheitenListe (E).Passierbarkeit = 2 then
            null;

         elsif EinheitenDatenbank.EinheitenListe (E).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (E).Anforderungen) = '0' then
               null;
               
            else
               Anzeige.TextBauen (Ende).Text := Einlesen.TexteEinlesen (10, E);
               Anzeige.TextBauen (Ende).Nummer := 10_000 + E;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := Einlesen.TexteEinlesen (10, E);
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
         Anzeige.TextBauen (Ende).Text := Einlesen.TexteEinlesen (19, 27);
      end if;

      loop

         AuswahlSchleife:
         loop

            Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (21, 13)));  
            Anzeige.AnzeigeStadt (AktuelleAuswahl => AktuelleAuswahl);         
         
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

      end loop;
      
   end AuswahlStadt;

end Bauen;
