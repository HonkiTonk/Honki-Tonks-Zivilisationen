with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with KartenDatentypen;
private with EinheitenDatentypen;
private with StadtRecords;
private with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitenverschiebungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure VonEigenemLandWerfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitVerschieben
     (SpeziesLandExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesLandExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Umgebungsgröße : KartenDatentypen.UmgebungsbereichDrei;
   
   UmgebungPrüfen : KartenRecords.YXAchsenKartenfeldPositivRecord;
   BereitsGeprüft : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertVerschieben : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure EinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end EinheitenverschiebungLogik;
