pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, EinheitenDatenbank, NaechstesObjekt, Verbesserungen,
     Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen;

package body BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer is
   begin
            
      Get_Immediate (Item => Taste);

      case To_Lower (Item => Taste) is
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' | '+' | '-' =>
            BewegungssystemCursor.BewegungCursorRichtung (Karte       => True,
                                                          Richtung    => To_Lower (Item => Taste),
                                                          RasseExtern => RasseExtern);
            return 1;
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern => RasseExtern,
                                                                             Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern => RasseExtern,
                                                                       Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

            if EinheitNummer /= 0 and StadtNummer /= 0 then
               StadtOderEinheit := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                       FrageDatei         => 10,
                                                       FrageZeile         => 15,
                                                       TextDatei          => 5,
                                                       ErsteZeile         => 10,
                                                       LetzteZeile        => 11);

               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => StadtOderEinheit,
                                 Stadtnummer         => StadtNummer,
                                 EinheitNummer       => EinheitNummer);
               
               
            elsif StadtNummer /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => -3,
                                 Stadtnummer         => StadtNummer,
                                 EinheitNummer       => EinheitNummer);
               
            elsif EinheitNummer /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => -1_000, -- Hauptsache ungleich -3
                                 Stadtnummer         => StadtNummer,
                                 EinheitNummer       => EinheitNummer);
               
            else
               null;
            end if;
            return 1;
            
         when 'q' => -- Menüaufruf
            return Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                       FrageDatei         => 0,
                                       FrageZeile         => 0,
                                       TextDatei          => 5,
                                       ErsteZeile         => 2,
                                       LetzteZeile        => 7);

         when 'b' => -- Baue Stadt
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern => RasseExtern,
                                                                             Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            case EinheitNummer is
               when 0 =>
                  null;
                  
               when others =>
                  if 
                    EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).EinheitTyp = 1
                    and GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte > 0.00
                  then
                     Nullwert := StadtBauen.StadtBauen (EinheitRasseNummer => (RasseExtern, EinheitNummer));
                     
                  else
                     null;
                  end if;
            end case;               
            return 1;
            
         when 't' => -- Technologie/Forschung
            case GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt is
               when 0 =>
                  ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
               when others =>
                  WahlForschung := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                       FrageDatei         => 10,
                                                       FrageZeile         => 17,
                                                       TextDatei          => 5,
                                                       ErsteZeile         => 10,
                                                       LetzteZeile        => 11);
                  case WahlForschung is
                     when -3 =>
                        ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
                     when others =>
                        null;
                  end case;
            end case;            
            return 1;
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            return 1;
            
         when '.' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten (RasseExtern => RasseExtern);
            return 1;
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit (RasseExtern => RasseExtern);
            return 1;
            
         when ',' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheitOhneBewegungspunkte (RasseExtern => RasseExtern);
            return 1;
            
         when 'l' | 'm' | 'f' | 'u' | 'z' | 'p' | 'h' | 'v' | Space | DEL | 'j' => -- l/1 = Straße, m/2 = Mine, f/3 = Farm, u/4 = Festung, z/5 = Wald aufforsten, p/6 = /Roden-Trockenlegen,
            -- h/7 = Heilen, v/8 = Verschanzen, Space/9 = Runde aussetzen, DEL/10 = Einheit auflösen, j/11 = Plündern
            case To_Lower (Taste) is
               when 'l' =>
                  WelcherBefehl := 1;
                  
               when 'm' =>
                  WelcherBefehl := 2;
                  
               when 'f' =>
                  WelcherBefehl := 3;
                  
               when 'u' =>
                  WelcherBefehl := 4;
                  
               when 'z' =>
                  WelcherBefehl := 5;
                  
               when 'p' =>
                  WelcherBefehl := 6;
                  
               when 'h' =>
                  WelcherBefehl := 7;
                  
               when 'v' =>
                  WelcherBefehl := 8;

               when Space =>
                  WelcherBefehl := 9;
                  
               when DEL =>
                  WelcherBefehl := 10;

               when 'j' =>
                  WelcherBefehl := 11;
                  
               when others =>
                  WelcherBefehl := 0;
            end case;
               
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern => RasseExtern,
                                                                             Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            case EinheitNummer is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID /= 1 and WelcherBefehl > 0 and WelcherBefehl <= 6 then
                     Anzeige.AnzeigeOhneAuswahl (ÜberschriftDatei      => 0,
                                                 ÜberschriftZeile      => 0,
                                                 TextDatei             => 8,
                                                 ErsteZeile            => 3,
                                                 LetzteZeile           => 3,
                                                 MitNew_LineMittendrin => 0,
                                                 MitNew_LineAmEnde     => 0);
                     delay 1.00;

                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 1 and WelcherBefehl = 11 then
                     Anzeige.AnzeigeOhneAuswahl (ÜberschriftDatei      => 0,
                                                 ÜberschriftZeile      => 0,
                                                 TextDatei             => 8,
                                                 ErsteZeile            => 3,
                                                 LetzteZeile           => 3,
                                                 MitNew_LineMittendrin => 0,
                                                 MitNew_LineAmEnde     => 0);
                     delay 1.00;
                     
                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
                     Anzeige.AnzeigeOhneAuswahl (ÜberschriftDatei      => 0,
                                                 ÜberschriftZeile      => 0,
                                                 TextDatei             => 8,
                                                 ErsteZeile            => 8,
                                                 LetzteZeile           => 8,
                                                 MitNew_LineMittendrin => 0,
                                                 MitNew_LineAmEnde     => 0);
                     delay 1.00;
                     
                  else
                     Verbesserungen.Verbesserung (EinheitRasseNummer => (RasseExtern, EinheitNummer),
                                                  Befehl             => Verbesserungen.Befehle_Enum'Val (WelcherBefehl));
                  end if;
            end case;               
            return 1;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            return 1;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;            
            return 1;

         when 'g' => -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);
            return 1;
            
         when 'r' => -- Runde beenden            
            return -1_000;
            
         when 'c' => -- Kleine Cheattaste
            Cheat.Menü (RasseExtern => RasseExtern);         
            return 1;
            
         when others =>            
            return 1;
      end case;
      
   end Befehle;



   procedure EinheitOderStadt (RasseExtern : in GlobaleDatentypen.Rassen; Auswahl, StadtNummer, EinheitNummer : in Integer) is
   begin
      
      case Auswahl is
         when -3 =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (StadtRasseNummer => (RasseExtern, StadtNummer));
            
         when others =>
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= 0 then
               Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
               case Wahl is
                  when True =>
                     GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 0;
                           
                  when others =>
                     null;
               end case;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
               null;
                     
            else
               BewegungssystemEinheiten.BewegungEinheitenRichtung (EinheitRasseNummer => (RasseExtern, EinheitNummer));
            end if;
      end case;
      
   end EinheitOderStadt;   

end BefehleImSpiel;
