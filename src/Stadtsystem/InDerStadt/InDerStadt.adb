pragma SPARK_Mode (On);

with SchreibeStadtGebaut;

with InDerStadtBauen;
with BewegungCursor;
with Eingabe;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;
with InteraktionTasks;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuelleRasseStadt := StadtRasseNummerExtern;
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Stadtkarte;
      
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
               -- Hier nicht die Mausbewegunsberechnungen einbauen um konsistent mit den Befehlen zu sein und keine Probeleme beim Zugriff auf das/die Fenster/Maus zu bekommen.
               null;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;
   
   
   
   function WasIstAusgewählt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      -- Hier dann prüfen wo der Mauszeiger ist und entsprechend die Auswahl gestalten.
      
      EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      return True;
      
   end WasIstAusgewählt;

end InDerStadt;
