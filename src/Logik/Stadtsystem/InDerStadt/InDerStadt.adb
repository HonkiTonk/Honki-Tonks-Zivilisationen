pragma SPARK_Mode (On);

with SchreibeStadtGebaut;

with InDerStadtBauen;
with BewegungCursor;
with Eingabe;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;
with InteraktionGrafiktask;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuelleRasseStadt := StadtRasseNummerExtern;
      
      StadtSchleife:
      loop
         
         InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Stadtkarte);
         
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
               if
                 WasIstAusgewählt (StadtRasseNummerExtern => StadtRasseNummerExtern) = True
               then
                  null;
                  
               else
                  return;
               end if;
               
            when SystemDatentypen.Bauen =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
               -- Gebäude verkaufen
            when SystemDatentypen.Auflösen =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when SystemDatentypen.Stadt_Umbenennen =>
               NeuerName := Eingabe.StadtName;
               
               if
                 NeuerName.ErfolgreichAbbruch = True
               then
                  SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            NameExtern             => NeuerName.EingegebenerText);
                  
               else
                  null;
               end if;

            when SystemDatentypen.Menü_Zurück =>
               AktuelleRasseStadt.Platznummer := 0;
               exit StadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      
   end InDerStadt;
   
   
   
   function WasIstAusgewählt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      -- Hier dann prüfen wo der Mauszeiger ist und entsprechend die Auswahl gestalten.
      -- Daran denken dass das auch für weitere Einstellungen gilt und nicht nur für die Zuweisung von Bürgern.
      
      EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      return True;
      
   end WasIstAusgewählt;

end InDerStadt;
