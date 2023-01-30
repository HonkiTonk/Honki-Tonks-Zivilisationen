with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StrahlungswaffeEingesetztLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure StrahlungswaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );

private

   Spezies : SpeziesDatentypen.Spezies_Enum;

   Strahlungsbereich : KartenRecords.EffektbereichRecord;
   Strahlungshöhe : KartenRecords.EffekthöheRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end StrahlungswaffeEingesetztLogik;
