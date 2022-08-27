pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Sichtweiten;
with GrafikEinstellungenSFML;

package body BerechnungenKarteSFML is
   
   procedure KartenfelderAbmessungBerechnen
   is begin
      
      FensterKarte := (0.00, 0.00, GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y);
      
      KartenfelderAbmessung.x := FensterKarte.width / Float (2 * Sichtweiten.SichtweiteLesen + 1);
      KartenfelderAbmessung.y := FensterKarte.height / Float (2 * Sichtweiten.SichtweiteLesen + 1);
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtfelderAbmessungBerechnen
   is begin
      
      StadtKarte := (0.00, 0.00, GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y);
      
      StadtfelderAbmessung.x := StadtKarte.width / Float (KartenDatentypen.Stadtfeld'Last);
      StadtfelderAbmessung.y := StadtKarte.height / Float (KartenDatentypen.Stadtfeld'Last);
      
   end StadtfelderAbmessungBerechnen;
   
   
   
   -- Mal eine bessere Lösung finden. äöü
   -- Die Aktuelle zeigt den schwarzen Rahmen an. äöü
   -- Die Ausgeklammerte crasht aber wenn es nur einen Übergang in der jeweiligen Achse gibt. äöü
   function SichtbereichKarteBerechnen
      return KartenDatentypen.SichtbereichAnfangEndeArray
   is begin
      
      YSichtAnfang := -Sichtweiten.SichtweiteLesen;
      YSichtEnde := Sichtweiten.SichtweiteLesen;
      XSichtAnfang := -Sichtweiten.SichtweiteLesen;
      XSichtEnde := Sichtweiten.SichtweiteLesen;
      
      return (YSichtAnfang, YSichtEnde, XSichtAnfang, XSichtEnde);
      
   end SichtbereichKarteBerechnen;

end BerechnungenKarteSFML;
