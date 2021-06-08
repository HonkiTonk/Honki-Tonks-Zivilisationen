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
            when 1 .. 8 => -- Cursor in der Stadt bewegen
               BewegungssystemCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                             RichtungExtern => Befehl,
                                                             RasseExtern    => StadtRasseNummerExtern.Rasse);

            when 11 => -- Einwohner von Feld entfernen/zuweisen
               EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);                  
               
            when 13 => -- Gebäude/Einheit bauen
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0
               then
                  InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
               else -- Diese Auswahl nach InDerStadtBauen verschieben
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 14)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                     
                     when others =>
                        null;
                  end case;
               end if;
               
            when 29 => -- Gebäude verkaufen
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when 34 => -- Stadt umbenennen
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := Eingabe.StadtName;

            when 12 => -- Stadt verlassen
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
