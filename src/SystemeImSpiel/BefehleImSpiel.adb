package body BefehleImSpiel is

   function Befehle return Integer is
   begin
            
      Get_Immediate (Item => Taste);

      case To_Lower (Item => Taste) is
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
            BewegungssystemCursor.BewegungCursorRichtung (Karte => True, Richtung => To_Lower (Item => Taste));
            Karte.AnzeigeKarte;
            return 1;
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten, Prüfung einbauen anstatt im Bewegungssystem
            Wert := StadtOderEinheit;
            case Wert is
               when GlobaleVariablen.EinheitenGebaut'First (2) .. GlobaleVariablen.EinheitenGebaut'Last (2) =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBeschäftigung /= 0 then
                     Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
                     case Wahl is
                        when True =>
                           GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBeschäftigung := 0;
                           
                        when others =>
                           null;
                     end case;
                  
                  elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0.0 then
                     return 1;
                     
                  else
                     BewegungssystemEinheiten.BewegungEinheitenRichtung (Rasse => GlobaleVariablen.Rasse,
                                                                         EinheitenPositionInListe => Wert);
                     return 1000;
                  end if;

               when -GlobaleVariablen.StadtGebaut'Last (2) .. -GlobaleVariablen.StadtGebaut'First (2) =>
                  GlobaleVariablen.CursorImSpiel.YAchseStadt := 1;
                  GlobaleVariablen.CursorImSpiel.XAchseStadt := 1;
                  InDerStadt.InDerStadt (Rasse => GlobaleVariablen.Rasse,
                                         StadtPositionInListe => -Wert);
                  
               when others =>
                  null;
            end case;
            return 1;
            
         when 'q' => -- Menüaufruf
            return Auswahl.Auswahl (WelcheAuswahl => 0,
                                    WelcherText => 8);

         when 'b' => -- Baue Stadt
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;
                  
               when others =>
                  if EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID).SiedlerLandeinheitSeeeinheitLufteinheit = 1 and
                  GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte > 0.0 then
                     InDerStadt.StadtBauen (Rasse => GlobaleVariablen.Rasse,
                                            Listenplatz => Wert);
                     
                  else
                     null;
                  end if;
            end case;
               
            return 1;
            
         when 't' => -- Technologie/Forschung
            
            
            return 1;
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt;
            Karte.AnzeigeKarte;
            return 1;
            
         when '+' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten;
            Karte.AnzeigeKarte;
            return 1;
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit;
            Karte.AnzeigeKarte;
            return 1;
            
         when '-' => -- Einheiten ohne Bewegungspunkte
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
               
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID /= 1 and WelcherBefehl > 0 and WelcherBefehl <= 6 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 3);

                     elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID = 1 and WelcherBefehl = 11 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0.0 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 8);
                     
                  else
                     VerbesserungenDatenbank.Verbesserung (Befehl => WelcherBefehl,
                                                           Rasse => GlobaleVariablen.Rasse,
                                                           Listenplatz => Wert);
                  end if;
            end case;
               
            return 1;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            return 1;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;
            return 1;
            
         when 'r' => -- Runde beenden
            return -1000;
            
         when others =>
            return 1;
      end case;
      
   end Befehle;
   
   
   
   function BefehleStadt return Integer is
   begin
      
      return 1;
      
   end BefehleStadt;
   
   
   
   function StadtOderEinheit return Integer is
   begin
      
      EinheitenSchleife:
      for E in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).ID = 0 then
            exit EinheitenSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).YAchse = GlobaleVariablen.CursorImSpiel.YAchse and GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).XAchse = GlobaleVariablen.CursorImSpiel.XAchse then
            return E;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;

      StadtSchleife:
      for S in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if S = 0 then
            null;
            
         elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, S).ID = 0 then
            return 0;
            
         elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, S).YAchse = GlobaleVariablen.CursorImSpiel.YAchse and GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, S).XAchse = GlobaleVariablen.CursorImSpiel.XAchse then
            return -S;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
         
      return 0;
      
   end StadtOderEinheit;



   function Einheit return Integer is
   begin
      
      EinheitenSchleife:
      for E in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).ID = 0 then
            return 0;
            
         elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).YAchse = GlobaleVariablen.CursorImSpiel.YAchse and GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, E).XAchse = GlobaleVariablen.CursorImSpiel.XAchse then
            return E;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return 0;
      
   end Einheit;

end BefehleImSpiel;
