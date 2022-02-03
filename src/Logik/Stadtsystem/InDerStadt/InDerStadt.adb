pragma SPARK_Mode (On);

with StadtKonstanten;

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
      
      AktuelleStadtNummerGrafik := StadtRasseNummerExtern.Platznummer;
      
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
            when SystemKonstanten.AuswählenKonstante =>
               if
                 WasIstAusgewählt (StadtRasseNummerExtern => StadtRasseNummerExtern) = True
               then
                  null;
                  
               else
                  return;
               end if;
               
            when SystemKonstanten.BauenKonstante =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
               -- Gebäude verkaufen
            when SystemKonstanten.AuflösenKonstante =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when SystemKonstanten.StadtUmbenennenKonstante =>
               NeuerName := Eingabe.StadtName;
               
               if
                 NeuerName.ErfolgreichAbbruch = True
               then
                  SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            NameExtern             => NeuerName.EingegebenerText);
                  
               else
                  null;
               end if;

            when SystemKonstanten.MenüZurückKonstante =>
               exit StadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      
      -- Theoretisch kann diese Wertzuweisung raus, sicherheitshalber trotzdem drinnen lassen?
      AktuelleStadtNummerGrafik := StadtKonstanten.LeerNummer;
      
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
