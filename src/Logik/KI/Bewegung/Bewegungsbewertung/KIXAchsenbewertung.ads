with KartenDatentypen;

package KIXAchsenbewertung is
   pragma Elaborate_Body;

   function XAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

private

   type FelderArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felder : FelderArray;

   AnzahlFelder : KartenDatentypen.KartenfeldNatural;

   WelcheFelderanzahl : Natural;



   function StandardübergangWesten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

   function StandardübergangOsten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

end KIXAchsenbewertung;
