with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;
with LeseGrenzen;

package StadtumgebungErreichbarLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   function UmgebungErreichbar
     (StadtKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 StadtKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StadtKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              ),
           
       Post => (
                  UmgebungErreichbar'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  UmgebungErreichbar'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
private
   
   BereitsGetestet : KartenRecords.UmgebungZweiRecord;
   
   Umgebung : KartenRecords.UmgebungDreiRecord;
   Stadtumgebung : KartenRecords.UmgebungDreiRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.KartenfeldNaturalRecord;
   
   
   
   function Prüfungen
     (StadtKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      AktuelleKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 StadtKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StadtKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 AktuelleKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 AktuelleKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
end StadtumgebungErreichbarLogik;
