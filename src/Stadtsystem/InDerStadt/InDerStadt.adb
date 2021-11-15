pragma SPARK_Mode (On);

with SchreibeStadtGebaut;

with InDerStadtBauen;
with KarteStadt;
with BewegungCursor;
with Eingabe;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      StadtSchleife:
      loop
         
         KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);

         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when SystemDatentypen.Tastenbelegung_Bewegung_Stadt_Enum'Range =>
               BewegungCursor.BewegungCursorRichtung (KarteExtern    => False,
                                                      RichtungExtern => Befehl,
                                                      RasseExtern    => StadtRasseNummerExtern.Rasse);

               -- Einwohner von Feld entfernen/zuweisen
            when SystemDatentypen.Auswählen =>
               EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
            when SystemDatentypen.Bauen =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
               -- Gebäude verkaufen
            when SystemDatentypen.Einheit_Auflösen =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when SystemDatentypen.Stadt_Umbenennen =>
               SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         NameExtern             => Eingabe.StadtName);

               -- Stadt verlassen
            when SystemDatentypen.Menü_Zurück =>
               return;
               
            when SystemDatentypen.Mausbewegung =>
               null;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
