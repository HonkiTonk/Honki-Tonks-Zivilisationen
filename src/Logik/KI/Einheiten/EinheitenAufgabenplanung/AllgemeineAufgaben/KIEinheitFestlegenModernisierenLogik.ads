with SpeziesDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with StadtRecords;
private with KartenRecords;
private with EinheitenDatentypen;
private with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitFestlegenModernisierenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function EinheitVerbessern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   use type EinheitenDatentypen.Einheitenbereich;
   
   Umgebung : KartenRecords.UmgebungDreiRecord;
   
   NeueEinheitenID : EinheitenDatentypen.EinheitenID;
   
   StadtKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   PlatzGefunden : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   function EinheitVerbessernPlatz
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitNummerExtern <= LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenModernisierenLogik;
