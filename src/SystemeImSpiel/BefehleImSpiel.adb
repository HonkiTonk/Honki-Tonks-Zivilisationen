package body BefehleImSpiel is

   function Befehle return Integer is
   begin
            
      Get_Immediate (Taste);

      case To_Lower (Taste) is
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
            BewegungssystemCursor.BewegungCursorRichtung (Karte => True, Richtung => To_Lower (Taste));
            Karte.AnzeigeKarte;
            return 1;
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten, Prüfung einbauen anstatt im Bewegungssystem
            Wert := StadtOderEinheit;
            case Wert is
               when GlobaleVariablen.EinheitenGebaut'First (2) .. GlobaleVariablen.EinheitenGebaut'Last (2) =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBeschäftigung /= '0' then
                     Wahl := EinheitenDatenbank.BeschäftigungAbbrechen;
                     case Wahl is
                        when True =>
                           GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBeschäftigung := '0';
                           
                        when others =>
                           null;
                     end case;
                  
                  elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0 then
                     return 1;
                     
                  else
                     BewegungssystemEinheiten.BewegungEinheitenRichtung (Rasse => GlobaleVariablen.Rasse, EinheitenPositionInListe => Wert);
                     return 1000;
                  end if;

               when -GlobaleVariablen.StadtGebaut'Last (2) .. -GlobaleVariablen.StadtGebaut'First (2) =>
                  GlobaleVariablen.CursorImSpiel.YAchseStadt := 1;
                  GlobaleVariablen.CursorImSpiel.XAchseStadt := 1;
                  InDerStadt.InDerStadt (Rasse => GlobaleVariablen.Rasse, StadtPositionInListe => -Wert);
                  
               when others =>
                  null;
            end case;
            return 1;
            
         when 'q' => -- Menüaufruf
            return Auswahl.Auswahl (WelcheAuswahl => 0, WelcherText => 8);

         when 'b' => -- Baue Stadt
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;
                  
               when others =>
                  if EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID).SiedlerLandeinheitSeeeinheitLufteinheit = 1 and
                  GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte > 0 then
                     InDerStadt.StadtBauen (Rasse => GlobaleVariablen.Rasse, Listenplatz => Wert);
                     
                  else
                     null;
                  end if;
            end case;
               
            return 1;
            
         when 'n' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt;
            Karte.AnzeigeKarte;
            return 1;
            
         when 'm' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten;
            Karte.AnzeigeKarte;
            return 1;
            
         when ',' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit;
            Karte.AnzeigeKarte;
            return 1;
            
         when '.' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheitOhneBewegungspunkte;
            Karte.AnzeigeKarte;
            return 1;
            
         when 'l' | 't' | 'f' | 'u' | 'z' | 'p' => -- Landstraße/Tiefengrabung/Farm/Festung/Wald aufforsten/Roden-Trockenlegen
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID /= 1 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 8);
                     
                  else
                     VerbesserungenDatenbank.Verbesserung (Befehl => To_Lower (Taste), Rasse => GlobaleVariablen.Rasse, Listenplatz => Wert);
                  end if;
            end case;
               
            return 1;

         when 'h' | 'v' => -- Heilen/Verschanzen
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;                     
                                 
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 8);

                  else
                     VerbesserungenDatenbank.Verbesserung (Befehl => To_Lower (Taste), Rasse => GlobaleVariablen.Rasse, Listenplatz => Wert);
                  end if;
            end case;
               
            return 1;

         when Space | DEL => -- Runde aussetzen/Einheit auflösen
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;                     
                                 
               when others =>
                  VerbesserungenDatenbank.Verbesserung (Befehl => To_Lower (Taste), Rasse => GlobaleVariablen.Rasse, Listenplatz => Wert);
            end case;
            return 1;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            return 1;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;
            return 1;

         when 'j' => -- Plündern
            Wert := Einheit;
            case Wert is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).ID = 1 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, Wert).AktuelleBewegungspunkte = 0 then
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 8);
                     
                  else
                     VerbesserungenDatenbank.Verbesserung (Befehl => To_Lower (Taste),
                                                           Rasse => GlobaleVariablen.Rasse,
                                                           Listenplatz => Wert);
                  end if;
            end case;
            return 1;

         when 'o' =>
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
