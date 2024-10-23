with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KISenkrechtebewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;

   function SenkrechteBewerten
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
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
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
              );

   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Senkrechte
              );

end KISenkrechtebewertung;
