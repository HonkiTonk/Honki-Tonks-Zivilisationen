with SpeziesDatentypen;
with EinheitenRecords;
with StadtRecords;
with StadtKonstanten;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package SichtbarkeitsberechnungssystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure SichtbarkeitsprüfungFürStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   SichtweiteObjekt : KartenDatentypen.Sichtweite;

   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end SichtbarkeitsberechnungssystemLogik;
