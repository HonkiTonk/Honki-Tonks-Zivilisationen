pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with GlobaleKonstanten;

with Auswahl, InDerStadtBauen, GebaeudeDatenbank, KarteStadt, BewegungssystemCursor, Karten, KartenPruefungen, Eingabe;

package body InDerStadt is

   procedure InDerStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtRasseNummer => StadtRasseNummer);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte       => False,
                                                             Richtung    => To_Lower (Item => Taste),
                                                             RasseExtern => StadtRasseNummer.Rasse);

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
                 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7 then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse - 17;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;
                  if RelativeCursorPositionY < -NutzbarerBereich or RelativeCursorPositionY > NutzbarerBereich or RelativeCursorPositionX < -NutzbarerBereich or RelativeCursorPositionX > NutzbarerBereich then
                     null;
                  
                  elsif RelativeCursorPositionY = 0 and RelativeCursorPositionX = 0 then
                     null;
                  
                  else
                     case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) is
                        when True =>
                           GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
                           GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                             := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner - 1;
                        
                        when False =>
                           KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                                   Änderung       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                                   ZusatzYAbstand => 0);
                           
                           case KartenWert.Erfolgreich is
                              when False =>
                                 null;
                                 
                              when True =>
                                 if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                                   < GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner then
                                    GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                                    GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                                      := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner + 1;
                           
                                 else
                                    null;
                                 end if;
                           end case;
                     end case;
                  end if;

               else
                  null;
               end if;
                  
               
            when 'b' => -- Gebäude/Einheit bauen
               case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt is
                  when 0 =>
                     InDerStadtBauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                  when others => -- Diese Auswahl nach InDerStadtBauen verschieben
                     Wahl := Auswahl.AuswahlJaNein (FrageZeile => 14);
                     case Wahl is
                        when GlobaleKonstanten.JaKonstante =>
                           InDerStadtBauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                     StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) := False;
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                     StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12) is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)
                                                                                                       + 12) := False;
                  end case;
                  
               else
                  null;
               end if;

            when 'n' => -- Stadt umbenennen
               GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Name := Eingabe.StadtName;

            when 'q' => -- Stadt verlassen
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
