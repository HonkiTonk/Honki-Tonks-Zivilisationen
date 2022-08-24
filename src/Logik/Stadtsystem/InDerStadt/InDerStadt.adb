pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with GrafikDatentypen;

with SchreibeStadtGebaut;

with InDerStadtBauen;
with EingabeSFML;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;
with NachGrafiktask;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleStadt := StadtRasseNummerExtern.Nummer;
      
      StadtSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
         
         Befehl := EingabeSFML.Tastenwert;
         
         case
           Befehl
         is
            -- Einwohner von Feld entfernen/zuweisen
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 WasIstAusgewählt (StadtRasseNummerExtern => StadtRasseNummerExtern) = True
               then
                  null;
                  
               else
                  return;
               end if;
               
            when TastenbelegungDatentypen.Bauen_Enum =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
               -- Gebäude verkaufen
            when TastenbelegungDatentypen.Auflösen_Enum =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
               NeuerName := EingabeSFML.StadtName;
               
               if
                 NeuerName.ErfolgreichAbbruch = True
               then
                  SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            NameExtern             => NeuerName.EingegebenerText);
                  
               else
                  null;
               end if;

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               exit StadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleStadt := StadtKonstanten.LeerNummer;
      
   end InDerStadt;
   
   
   
   function WasIstAusgewählt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      -- Hier dann prüfen wo der Mauszeiger ist und entsprechend die Auswahl gestalten.
      -- Daran denken dass das auch für weitere Einstellungen gilt und nicht nur für die Zuweisung von Bürgern.
      
      EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      return True;
      
   end WasIstAusgewählt;

end InDerStadt;
