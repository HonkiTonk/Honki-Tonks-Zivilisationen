pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, EinheitenDatenbank, NaechstesObjekt, Verbesserungen,
     Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen, Eingabe;

package body BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer is
   begin 
            
      Get_Immediate (Item => Taste);

      case To_Lower (Item => Taste) is -- Cursor bewegen
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' | '+' | '-' =>
            BewegungssystemCursor.BewegungCursorRichtung (KarteExtern       => True,
                                                          RichtungExtern    => To_Lower (Item => Taste),
                                                          RasseExtern => RasseExtern);
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                             KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

            if EinheitNummer /= 0 and StadtNummer /= 0 then
               StadtOderEinheit := Auswahl.AuswahlJaNein (FrageZeileExtern => 15);

               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 AuswahlExtern       => StadtOderEinheit,
                                 StadtNummerExtern   => StadtNummer,
                                 EinheitNummerExtern => EinheitNummer);
               
               
            elsif StadtNummer /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 AuswahlExtern       => GlobaleKonstanten.JaKonstante,
                                 StadtNummerExtern   => StadtNummer,
                                 EinheitNummerExtern => EinheitNummer);
               
            elsif EinheitNummer /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 AuswahlExtern       => GlobaleKonstanten.NeinKonstante,
                                 StadtNummerExtern   => StadtNummer,
                                 EinheitNummerExtern => EinheitNummer);
               
            else
               null;
            end if;
            
         when 'q' => -- Menüaufruf
            return Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                    TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                    FrageZeileExtern  => 0,
                                    ErsteZeileExtern  => 2,
                                    LetzteZeileExtern => 7);

         when 'b' => -- Baue Stadt
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                             KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            case EinheitNummer is
               when 0 =>
                  null;
                  
               when others =>
                  if 
                    EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).EinheitTyp = 1
                    and GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte > 0.00
                  then
                     Nullwert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
                  else
                     null;
                  end if;
            end case;
            
         when 't' => -- Technologie/Forschung
            case GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt is
               when 0 =>
                  ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
               when others =>
                  WahlForschung := Auswahl.AuswahlJaNein (FrageZeileExtern => 17);
                  case WahlForschung is
                     when GlobaleKonstanten.JaKonstante =>
                        ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
                     when others =>
                        null;
                  end case;
            end case;
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when '.' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten (RasseExtern => RasseExtern);
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit (RasseExtern => RasseExtern);
            
         when ',' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheitOhneBewegungspunkte (RasseExtern => RasseExtern);
            
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
               
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                             KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            case EinheitNummer is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID /= 1 and WelcherBefehl > 0 and WelcherBefehl <= 6 then
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                           TextZeileExtern => 3);

                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 1 and WelcherBefehl = 11 then
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                           TextZeileExtern => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                           TextZeileExtern => 8);
                     
                  else
                     Verbesserungen.Verbesserung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                  BefehlExtern             => Verbesserungen.Befehle_Enum'Val (WelcherBefehl));
                  end if;
            end case;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            null;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;

         when 'g' => -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when 'n' => -- Stadt umbenennen
            StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            case StadtNummer is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  null;
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name := Eingabe.StadtName;
            end case;
            
         when 'r' => -- Runde beenden            
            return -1_000;
            
         when 'c' => -- Kleine Cheattaste
            Cheat.Menü (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;

      return 1;
      
   end Befehle;



   procedure EinheitOderStadt (RasseExtern : in GlobaleDatentypen.Rassen; AuswahlExtern : in Integer; StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
                               EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert) is
   begin
      
      case AuswahlExtern is
         when GlobaleKonstanten.JaKonstante =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when others =>
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBeschäftigung /= 0 then
               Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
               case Wahl is
                  when True =>
                     GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBeschäftigung := 0;
                           
                  when False =>
                     null;
               end case;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBewegungspunkte = 0.00 then
               null;
                     
            else
               BewegungssystemEinheiten.BewegungEinheitenRichtung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
            end if;
      end case;
      
   end EinheitOderStadt;   

end BefehleImSpiel;
