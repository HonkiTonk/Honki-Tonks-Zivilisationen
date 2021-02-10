pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GebaeudeDatenbank, EinheitenDatenbank, Anzeige;

package body Bauen is

   procedure Bauen (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin

      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := AuswahlStadt (StadtRasseUndNummer => StadtRasseUndNummer);

         case WasGebautWerdenSoll is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen := 0;
               BauzeitEinzeln (StadtRasseUndNummer => StadtRasseUndNummer);
               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure BauzeitEinzeln (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin

      if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit := 10_000;

      elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit := 0;
            
      elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt < 10_000 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit
           := (GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse, GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 1_000).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit
           := (EinheitenDatenbank.EinheitenListe (StadtRasseUndNummer.Rasse,
               GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate);
      end if;
               
   end BauzeitEinzeln;



   procedure BauzeitAlle is
   begin
         
      RassenSchleife:
      for RasseIntern in GlobaleVariablen.RassenImSpiel'Range loop

         case GlobaleVariablen.RassenImSpiel (RasseIntern) is
            when 0 =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
      
                  case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                        
                     when others =>
                        BauzeitEinzeln (StadtRasseUndNummer => (RasseIntern, StadtNummer));
                  end case;
      
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end BauzeitAlle;
   
   
   
   function AuswahlStadt (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) return Integer is
   begin

      Ende := 1;
      AktuelleAuswahl := 1;
      Anzeige.TextBauen := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      GebäudeSchleife:
      for G in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (16, G)) = "|" then
            exit GebäudeSchleife;

         elsif G > GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).GebäudeVorhanden'Last then
            exit GebäudeSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).GebäudeVorhanden (G) /= '0' then
            null;

         elsif GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse, G).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse, G).Anforderungen) = 0 then 
               null;

            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (16, G);
               Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (16, G);
            Anzeige.TextBauen (Ende).Nummer := 1_000 + G;
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for E in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (12, E)) = "|" then
            exit EinheitenSchleife;

         elsif E > Integer (EinheitenDatenbank.EinheitenListe'Last) then
            exit EinheitenSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AmWasser = False
           and EinheitenDatenbank.EinheitenListe (StadtRasseUndNummer.Rasse, GlobaleDatentypen.EinheitenID (E)).Passierbarkeit = 2 then
            null;

         elsif EinheitenDatenbank.EinheitenListe (StadtRasseUndNummer.Rasse, GlobaleDatentypen.EinheitenID (E)).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (StadtRasseUndNummer.Rasse, GlobaleDatentypen.EinheitenID (E)).Anforderungen) = 0 then
               null;
               
            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (12, E);
               Anzeige.TextBauen (Ende).Nummer := 10_000 + E;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (12, E);
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
         Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (9, 27);
      end if;

      AuswahlSchleife:
      loop

         Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (10, 13)));  
         Anzeige.AnzeigeStadt (AktuelleAuswahl => AktuelleAuswahl);
         
         if AktuelleAuswahl = Ende then
            null;
                  
         elsif Anzeige.TextBauen (AktuelleAuswahl).Nummer > 10_000 then
            Anzeige.AnzeigeLangerText (WelcherText => 13,
                                       WelcheZeile => Anzeige.TextBauen (AktuelleAuswahl).Nummer - 10_000);
            
         else
            Anzeige.AnzeigeLangerText (WelcherText => 17,
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
