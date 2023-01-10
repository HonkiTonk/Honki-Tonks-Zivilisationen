with SpeziesDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;

package KIEinheitFestlegenPlatzMachenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function PlatzMachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenPlatzMachenLogik;
