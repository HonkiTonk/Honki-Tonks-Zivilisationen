with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KIXAchsenbewertung is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   function XAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
              );

private

   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felderanzahl : FelderanzahlArray;



   function StandardübergangWesten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
              );

   function StandardübergangOsten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 ZielpunktExtern <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeuerPunktExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end KIXAchsenbewertung;
