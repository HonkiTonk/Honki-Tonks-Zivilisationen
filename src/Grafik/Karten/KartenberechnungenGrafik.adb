with KartenDatentypen;

with SichtweitenGrafik;
with EinstellungenGrafik;

package body KartenberechnungenGrafik is
   
   procedure KartenfelderAbmessungBerechnen
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      FensterKarte := (0.00, 0.00, EinstellungenGrafik.AktuelleFensterAuflösung.x, EinstellungenGrafik.AktuelleFensterAuflösung.y);
      
      KartenfelderAbmessung.x := FensterKarte.width / Float (2 * SichtweitenGrafik.SichtweiteLesen + 1);
      KartenfelderAbmessung.y := FensterKarte.height / Float (2 * SichtweitenGrafik.SichtweiteLesen + 1);
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtfelderAbmessungBerechnen
   is begin
      
      StadtKarte := (0.00, 0.00, EinstellungenGrafik.AktuelleFensterAuflösung.x, EinstellungenGrafik.AktuelleFensterAuflösung.y);
      
      StadtfelderAbmessung.x := StadtKarte.width / Float (KartenDatentypen.Stadtfeld'Last);
      StadtfelderAbmessung.y := StadtKarte.height / Float (KartenDatentypen.Stadtfeld'Last);
      
   end StadtfelderAbmessungBerechnen;

end KartenberechnungenGrafik;
