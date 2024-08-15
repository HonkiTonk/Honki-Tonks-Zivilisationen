with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KIXAchsenbewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Waagerechte;

   function XAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
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
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
              );

   function StandardübergangOsten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end KIXAchsenbewertung;
