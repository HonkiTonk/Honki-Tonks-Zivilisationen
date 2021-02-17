pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GebaeudeDatenbank, EinheitenDatenbank, Anzeige;

package body InDerStadtBauen is

   procedure Bauen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin

      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := AuswahlStadt (StadtRasseNummer => StadtRasseNummer);

         case WasGebautWerdenSoll is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen := 0;
               BauzeitEinzeln (StadtRasseNummer => StadtRasseNummer);
               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure BauzeitEinzeln (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin

      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit := 10_000;

      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit := 0;
            
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt < 10_000 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit
           := (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse,
               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 1_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit
           := (EinheitenDatenbank.EinheitenListe (StadtRasseNummer.Rasse,
               GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate);
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
                        BauzeitEinzeln (StadtRasseNummer => (RasseIntern, StadtNummer));
                  end case;
      
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end BauzeitAlle;
   
   
   
   function AuswahlStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) return Integer is
   begin

      Ende := 1;
      AktuelleAuswahl := 1;
      Anzeige.TextBauen := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      GebäudeSchleife:
      for Gebäude in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (16, Gebäude)) = "|" then
            exit GebäudeSchleife;

         elsif Gebäude > Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden'Last) then
            exit GebäudeSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (Gebäude)) = True then
            null;

         elsif GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (Gebäude)).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (Gebäude)).Anforderungen) = 0 then 
               null;

            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (16, Gebäude);
               Anzeige.TextBauen (Ende).Nummer := 1_000 + Gebäude;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (16, Gebäude);
            Anzeige.TextBauen (Ende).Nummer := 1_000 + Gebäude;
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for Einheit in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (12, Einheit)) = "|" then
            exit EinheitenSchleife;

         elsif Einheit > Integer (EinheitenDatenbank.EinheitenListeArry'Last (2)) then
            exit EinheitenSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AmWasser = False
           and EinheitenDatenbank.EinheitenListe (StadtRasseNummer.Rasse, GlobaleDatentypen.EinheitenID (Einheit)).Passierbarkeit = 2 then
            null;

         elsif EinheitenDatenbank.EinheitenListe (StadtRasseNummer.Rasse, GlobaleDatentypen.EinheitenID (Einheit)).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (StadtRasseNummer.Rasse, GlobaleDatentypen.EinheitenID (Einheit)).Anforderungen) = 0 then
               null;
               
            else
               Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (12, Einheit);
               Anzeige.TextBauen (Ende).Nummer := 10_000 + Einheit;
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauen (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (12, Einheit);
            Anzeige.TextBauen (Ende).Nummer := 10_000 + Einheit;
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

end InDerStadtBauen;
