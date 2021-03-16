pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige;

package body ForschungsDatenbank is

   procedure Beschreibung (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert) is
   begin
      
      case IDExtern is
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Forschung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => Positive (IDExtern),
                                           LetzteZeileExtern      => Positive (IDExtern),
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
      end case;
      
   end Beschreibung;



   procedure Forschung (RasseExtern : in GlobaleDatentypen.Rassen) is -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   begin
      
      ForschungSchleife:
      loop
         
         WasErforschtWerdenSoll := AuswahlForschungNeu (RasseExtern => RasseExtern);

         case WasErforschtWerdenSoll is
            when 0 =>
               return;
               
            when GlobaleDatentypen.ForschungID'Range =>
               GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt := WasErforschtWerdenSoll;
               ForschungZeit (RasseExtern => RasseExtern);
               return;
         end case;
         
      end loop ForschungSchleife;
      
   end Forschung;



   procedure ForschungZeit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      if GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt = 0 then
         null;
         
      elsif GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate = 0 then
         null;

      else
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (ForschungListe (RasseExtern, GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt).PreisForschung
               - GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge) / GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate;
         return;
      end if;      
      
      GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := 10_000;
      
   end ForschungZeit;



   function AuswahlForschungNeu (RasseExtern : in GlobaleDatentypen.Rassen) return GlobaleDatentypen.ForschungIDMitNullWert is
   begin
      
      Anzeige.TextForschungNeu := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Ende := 1;

      ForschungSchleife:
      for Forschungen in GlobaleDatentypen.ForschungID loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Forschung_Kurz), Positive (Forschungen) + RassenAufschlagForschung (RasseExtern))) = "|" then
            exit ForschungSchleife;

         elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (Forschungen) = True then
            null;

         else
            AnforderungenErfüllt := True;
            AnforderungSchleife:
            for Anforderung in AnforderungForschungArray'Range loop
            
               if ForschungListe (RasseExtern, Forschungen).AnforderungForschung (Anforderung) = 0 then
                  null;
                  
               elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungListe (RasseExtern, Forschungen).AnforderungForschung (Anforderung)) = True then                  
                  null;
                  
               else
                  AnforderungenErfüllt := False;
                  exit AnforderungSchleife;
               end if;
               
            end loop AnforderungSchleife;

            case AnforderungenErfüllt is
               when True =>
                  Anzeige.TextForschungNeu (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Forschung_Kurz),
                                                                                             Positive (Forschungen) + RassenAufschlagForschung (RasseExtern));
                  Anzeige.TextForschungNeu (Ende).Nummer := Forschungen;
                  Ende := Ende + 1;
                  
               when False =>
                  null;
            end case;
         end if;
                  
      end loop ForschungSchleife;

      if Anzeige.TextForschungNeu (Ende).Nummer = 0 and Ende > 1 then
         Anzeige.TextForschungNeu (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Feste_Abfragen), 3);

      elsif Anzeige.TextForschungNeu (Ende).Nummer = 0 and Ende = 1 then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.TextForschungNeu (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Feste_Abfragen), 3);
      end if;

      AktuelleAuswahl := 1;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fragen,
                                               TextZeileExtern => 16);

         Anzeige.AnzeigeForschungNeu (AktuelleAuswahlExtern => AktuelleAuswahl);
         
         if AktuelleAuswahl = Ende then
            null;
                  
         else
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                          TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Forschung_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Positive (Anzeige.TextForschungNeu (AktuelleAuswahl).Nummer),
                                          LetzteZeileExtern      => Positive (Anzeige.TextForschungNeu (AktuelleAuswahl).Nummer),
                                          AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleDatentypen.Keiner);
         end if;
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Anzeige.TextForschungNeu'First then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Anzeige.TextForschungNeu'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
            when 'e' | '5' =>
               return Anzeige.TextForschungNeu (AktuelleAuswahl).Nummer;

            when 'q' =>
               return 0;
                     
            when others =>
               null;                    
         end case;
         
      end loop AuswahlSchleife;

   end AuswahlForschungNeu;



   procedure ForschungFortschritt is
   begin
      
      RasseSchleife:
      for RasseIntern in GlobaleDatentypen.Rassen loop
         
         case GlobaleVariablen.RassenImSpiel (RasseIntern) is
            when 0 =>
               null;
               
            when others =>
               if GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt = 0 then
                  null;
         
               elsif GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsmenge >= ForschungListe (RasseIntern, GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt).PreisForschung then
                  GlobaleVariablen.Wichtiges (RasseIntern).Erforscht (GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt) := True;
                  GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt := AuswahlForschungNeu (RasseExtern => RasseIntern);
                  GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsmenge := 0;
            
               else
                  null;
               end if;

               ForschungZeit (RasseExtern => RasseIntern);
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;

end ForschungsDatenbank;
