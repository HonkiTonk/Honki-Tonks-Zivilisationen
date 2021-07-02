pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with Auswahl, InDerStadtBauen, KarteStadt, BewegungssystemCursor, Eingabe, EinwohnerZuweisenEntfernen, GebaeudeVerkaufen;

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
            -- Cursor in der Stadt bewegen
            when 1 .. 8 =>
               BewegungssystemCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                             RichtungExtern => Befehl,
                                                             RasseExtern    => StadtRasseNummerExtern.Rasse);

               -- Einwohner von Feld entfernen/zuweisen
            when 11 =>
               EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);                  
               
               -- Gebäude/Einheit bauen
            when 13 =>
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt = 0
               then
                  InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
                  -- Diese Auswahl nach InDerStadtBauen verschieben
               else
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 14)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
                     when others =>
                        null;
                  end case;
               end if;
               
               -- Gebäude verkaufen
            when 29 =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

               -- Stadt umbenennen
            when 34 =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := Eingabe.StadtName;

               -- Stadt verlassen
            when 12 =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
