with KartenDatentypen;

package KIYAchsenbewertung is
   pragma Elaborate_Body;

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

private

   type FelderArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felder : FelderArray;

   AnzahlFelder : KartenDatentypen.KartenfeldNatural;

   WelcheFelderanzahl : Natural;



   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural;

end KIYAchsenbewertung;
