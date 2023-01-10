with SpeziesDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitUmsetzenErkundenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   ZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenErkundenLogik;
