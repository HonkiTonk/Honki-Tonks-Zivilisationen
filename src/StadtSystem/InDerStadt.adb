pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with Auswahl, InDerStadtBauen, GebaeudeDatenbank, KarteStadt, BewegungssystemCursor, Karten, KartenPruefungen, Eingabe;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         New_Line;  

         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when 1 .. 8 => -- Cursor in der Stadt bewegen
               BewegungssystemCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                             RichtungExtern => Befehl,
                                                             RasseExtern    => StadtRasseNummerExtern.Rasse);

            when 11 => -- Einwohner von Feld entfernen/zuweisen
               if
                 GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
                 and
                   GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7
               then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse - 17;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße;
                  if
                    RelativeCursorPositionY < -NutzbarerBereich
                    or
                      RelativeCursorPositionY > NutzbarerBereich
                      or
                        RelativeCursorPositionX < -NutzbarerBereich
                        or
                          RelativeCursorPositionX > NutzbarerBereich
                  then
                     null;
                  
                  elsif
                    RelativeCursorPositionY = 0
                    and
                      RelativeCursorPositionX = 0
                  then
                     null;
                  
                  else
                     EinwohnerZuweisen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  end if;

               else
                  null;
               end if;
                  
               
            when 13 => -- Gebäude/Einheit bauen
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0
               then
                  InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
               else -- Diese Auswahl nach InDerStadtBauen verschieben
                  Wahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 14);
                  case
                    Wahl
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
                     when others =>
                        null;
                  end case;
               end if;
               
            when 29 => -- Gebäude verkaufen
               if
                 GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 1
                 and
                   GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
               then
                  case
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                    (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse))
                  is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                     GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                          (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)) := False;
                  end case;
            
               elsif
                 GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 2
                 and
                   GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
               then
                  case
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                    (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12)
                  is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                                     GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                          (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12) := False;
                  end case;
                  
               else
                  null;
               end if;

            when 34 => -- Stadt umbenennen
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := Eingabe.StadtName;

            when 12 => -- Stadt verlassen
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;



   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) = True
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner - 1;
                        
      else
         KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                 ÄnderungExtern       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                 ZusatzYAbstandExtern => 0);
            
         case
           KartenWert.YAchse
         is
            when 0 =>
               return;
                                 
            when others =>
               null;
         end case;
            
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
           < GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner + 1;
                           
         else
            null;
         end if;
      end if;
      
   end EinwohnerZuweisen;

end InDerStadt;
