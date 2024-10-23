with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KIWaagerechtebewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Waagerechte;

   function WaagerechteBewerten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.WaagerechteNatural;
   Felderanzahl : FelderanzahlArray;



   function StandardübergangWesten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function StandardübergangOsten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KIWaagerechtebewertung;
