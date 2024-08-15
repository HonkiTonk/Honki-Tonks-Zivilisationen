with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KIYAchsenbewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

private

   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.SenkrechteNatural;
   Felderanzahl : FelderanzahlArray;



   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.YAchse
              );

end KIYAchsenbewertung;
