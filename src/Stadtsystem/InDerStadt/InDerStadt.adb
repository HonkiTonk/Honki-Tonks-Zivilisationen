pragma SPARK_Mode (On);

with SchreibeStadtGebaut;

with InDerStadtBauen;
with BewegungCursor;
with Eingabe;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;
with BewegungCursorSFML;
with GrafikWichtigeEinstellungen;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuelleRasseStadt := StadtRasseNummerExtern;
      GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Stadtkarte;
      
      StadtSchleife:
      loop
         
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
               AktuelleRasseStadt.Platznummer := 0;
               return;
               
            when SystemDatentypen.Mausbewegung =>
               BewegungCursorSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;

end InDerStadt;
