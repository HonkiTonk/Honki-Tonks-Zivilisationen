pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with SchreibeStadtGebaut;

with InDerStadtBauen, KarteStadt, BewegungCursor, Eingabe, EinwohnerZuweisenEntfernen, GebaeudeVerkaufen;

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
               BewegungCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                      RichtungExtern => Befehl,
                                                      RasseExtern    => StadtRasseNummerExtern.Rasse);

               -- Einwohner von Feld entfernen/zuweisen
            when GlobaleDatentypen.Auswählen =>
               EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
            when GlobaleDatentypen.Bauen =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
               -- Gebäude verkaufen
            when GlobaleDatentypen.Einheit_Auflösen =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when GlobaleDatentypen.Stadt_Umbenennen =>
               SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         NameExtern             => Eingabe.StadtName);

               -- Stadt verlassen
            when GlobaleDatentypen.Menü_Zurück =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
