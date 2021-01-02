package body BefehleImSpiel is

   function Befehle (Rasse : in Integer) return Integer is
   begin
            
      Get_Immediate (Item => Taste);

      case To_Lower (Item => Taste) is
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
            BewegungssystemCursor.BewegungCursorRichtung (Karte    => True,
                                                          Richtung => To_Lower (Item => Taste));
            return 1;
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (Rasse  => Rasse,
                                                                                 YAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                 XAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse);
            WertStadt := SchleifenPruefungen.KoordinatenStadtMitRasseSuchen (Rasse  => Rasse,
                                                                             YAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                             XAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse);

            if WertEinheit /= 0 and WertStadt /= 0 then
               StadtOderEinheit := Auswahl.Auswahl (WelcheAuswahl => 15,
                                                    WelcherText => 18);

               EinheitOderStadt (Rasse         => Rasse,
                                 Auswahl       => StadtOderEinheit,
                                 Stadtnummer   => WertStadt,
                                 EinheitNummer => WertEinheit);
               
               
            elsif WertStadt /= 0 then
               EinheitOderStadt (Rasse         => Rasse,
                                 Auswahl       => -3,
                                 Stadtnummer   => WertStadt,
                                 EinheitNummer => WertEinheit);
               
            elsif WertEinheit /= 0 then
               EinheitOderStadt (Rasse         => Rasse,
                                 Auswahl       => 654, -- Hauptsache ungleich -3
                                 Stadtnummer   => WertStadt,
                                 EinheitNummer => WertEinheit);
               
            else
               null;
            end if;
            return 1;
            
         when 'q' => -- Menüaufruf
            return Auswahl.Auswahl (WelcheAuswahl => 0,
                                    WelcherText => 8);

         when 'b' => -- Baue Stadt
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (Rasse  => Rasse,
                                                                                 YAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                 XAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse);
            case WertEinheit is
               when 0 =>
                  null;
                  
               when others =>
                  if EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, WertEinheit).ID).SiedlerLandeinheitSeeeinheitLufteinheit = 1 and
                    GlobaleVariablen.EinheitenGebaut (Rasse, WertEinheit).AktuelleBewegungspunkte > 0.00 then
                     Nullwert := InDerStadt.StadtBauen (Rasse         => Rasse,
                                                        EinheitNummer => WertEinheit);
                     
                  else
                     null;
                  end if;
            end case;               
            return 1;
            
         when 't' => -- Technologie/Forschung
            case GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt is
               when 0 =>
                  ForschungsDatenbank.Forschung (Rasse => Rasse);
                     
               when others =>
                  WahlForschung := Auswahl.Auswahl (WelcheAuswahl => 17,
                                                    WelcherText => 18);
                  case WahlForschung is
                     when -3 =>
                        ForschungsDatenbank.Forschung (Rasse => Rasse);
                     
                     when others =>
                        null;
                  end case;
            end case;            
            return 1;
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt;
            Karte.AnzeigeKarte;
            return 1;
            
         when '.' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten;
            Karte.AnzeigeKarte;            
            return 1;
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit;
            Karte.AnzeigeKarte;            
            return 1;
            
         when ',' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheitOhneBewegungspunkte;
            Karte.AnzeigeKarte;            
            return 1;
            
         when 'l' | 'm' | 'f' | 'u' | 'z' | 'p' | 'h' | 'v' | Space | DEL | 'j' => -- l/1 = Straße, m/2 = Mine, f/3 = Farm, u/4 = Festung, z/5 = Wald aufforsten, p/6 = /Roden-Trockenlegen,
                                                                                   -- h/7 = Heilen, v/8 = Verschanzen Space/9 = Runde aussetzen, DEL/10 = Einheit auflösen, j/11 = Plündern
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
               
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (Rasse  => Rasse,
                                                                                 YAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                 XAchse => GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse);
            case WertEinheit is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (Rasse, WertEinheit).ID /= 1 and WelcherBefehl > 0 and WelcherBefehl <= 6 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 3);

                     elsif GlobaleVariablen.EinheitenGebaut (Rasse, WertEinheit).ID = 1 and WelcherBefehl = 11 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (Rasse, WertEinheit).AktuelleBewegungspunkte = 0.00 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 8);
                     
                  else
                     Verbesserungen.Verbesserung (Befehl        => WelcherBefehl,
                                                  Rasse         => Rasse,
                                                  EinheitNummer => WertEinheit);
                  end if;
            end case;               
            return 1;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            return 1;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;            
            return 1;

         when 'g' => -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor;
            Karte.AnzeigeKarte;            
            return 1;
            
         when 'r' => -- Runde beenden            
            return -1_000;
            
         when '+' => -- Ebene hoch
            case GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse is
               when 2 =>
                  GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse := -2;
                  
               when others =>
                  GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse + 1;
            end case;
            return 1;
            
         when '-' => -- Ebene runter
            case GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse is
               when -2 =>
                  GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse := 2;
                  
               when others =>
                  GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse - 1;
            end case;          
            return 1;
            
         when 'c' => -- Kleine Cheattaste
            Cheat.Menü;
            Karte.AnzeigeKarte;            
            return 1;
            
         when others =>            
            return 1;
      end case;
      
   end Befehle;



   procedure EinheitOderStadt (Rasse, Auswahl, StadtNummer, EinheitNummer : in Integer) is
   begin
      
      case Auswahl is
         when -3 =>
            GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (Rasse       => Rasse,
                                   StadtNummer => StadtNummer);
                     
         when others =>
            if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBeschäftigung /= 0 then
               Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
               case Wahl is
                  when True =>
                     GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBeschäftigung := 0;
                           
                  when others =>
                     null;
               end case;
                  
            elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
               null;
                     
            else
               BewegungssystemEinheiten.BewegungEinheitenRichtung (Rasse => Rasse,
                                                                   EinheitNummer => EinheitNummer);
               null;
            end if;
      end case;
      
   end EinheitOderStadt;   

end BefehleImSpiel;
