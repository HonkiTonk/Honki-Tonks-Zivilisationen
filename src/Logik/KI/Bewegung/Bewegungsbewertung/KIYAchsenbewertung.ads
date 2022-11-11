with KartenDatentypen;

with KIDatentypen;

package KIYAchsenbewertung is
   pragma Elaborate_Body;

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung;

private

   ZwischenspeicherAktuell : Integer;
   ZwischenspeicherNeu : Integer;



   function Standardübergang
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung;

end KIYAchsenbewertung;
