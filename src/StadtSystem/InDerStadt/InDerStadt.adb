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
            when GlobaleDatentypen.Tastenbelegung_Bewegung_Stadt_Enum'Range =>
               BewegungssystemCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                             RichtungExtern => Befehl,
                                                             RasseExtern    => StadtRasseNummerExtern.Rasse);

               -- Einwohner von Feld entfernen/zuweisen
            when GlobaleDatentypen.Auswählen =>
               EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);                  
               
            when GlobaleDatentypen.Bauen =>
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
            when GlobaleDatentypen.Einheit_Auflösen =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when GlobaleDatentypen.Stadt_Umbenennen =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := Eingabe.StadtName;

               -- Stadt verlassen
            when GlobaleDatentypen.Menü_Zurück =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
