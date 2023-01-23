with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package BiologischeWaffeEingesetztLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure BiologischeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );

private

   Krankheitsbereich : KartenRecords.EffektbereichRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end BiologischeWaffeEingesetztLogik;
