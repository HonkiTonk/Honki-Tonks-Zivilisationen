with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KIYAchsenbewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

private

   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felderanzahl : FelderanzahlArray;



   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

end KIYAchsenbewertung;
