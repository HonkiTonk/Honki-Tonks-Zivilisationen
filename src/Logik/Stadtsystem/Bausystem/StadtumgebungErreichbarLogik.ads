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
     (StadtKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 StadtKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 StadtKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              ),
           
       Post => (
                  UmgebungErreichbar'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  UmgebungErreichbar'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   BereitsGetestet : KartenDatentypen.SenkrechteUmgebungZwei;
   Umgebung : KartenDatentypen.SenkrechteUmgebungDrei;
   Stadtumgebung : KartenDatentypen.SenkrechteUmgebungDrei;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function Prüfungen
     (StadtKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 StadtKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 StadtKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
end StadtumgebungErreichbarLogik;
