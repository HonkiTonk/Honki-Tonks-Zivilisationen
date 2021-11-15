pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with Sichtweiten;
with GrafikEinstellungen;

package body BerechnungenKarteSFML is
   
   procedure KartenfelderAbmessungBerechnen
   is begin
      
      FensterKarte := (Float (GrafikEinstellungen.FensterEinstellungen.FensterBreite) * AusschnittKarte, Float (GrafikEinstellungen.FensterEinstellungen.FensterHöhe));
                  
      KartenfelderAbmessung.x := FensterKarte.x / Float (2 * Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse + 1);
      KartenfelderAbmessung.y := FensterKarte.y / Float (2 * Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse + 1);
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtfelderAbmessungBerechnen
   is begin
      
      StadtKarte := (Float (GrafikEinstellungen.FensterEinstellungen.FensterBreite) * AusschnittStadtKarte, Float (GrafikEinstellungen.FensterEinstellungen.FensterHöhe));
      
      StadtfelderAbmessung.x := StadtKarte.x / Float (KartenDatentypen.Stadtfeld'Last);
      StadtfelderAbmessung.y := StadtKarte.y / Float (KartenDatentypen.Stadtfeld'Last);
      
   end StadtfelderAbmessungBerechnen;

end BerechnungenKarteSFML;
