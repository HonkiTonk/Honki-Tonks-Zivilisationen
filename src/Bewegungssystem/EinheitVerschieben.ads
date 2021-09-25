pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, KartenRecords;
use GlobaleDatentypen;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitVerschieben
     (RasseLandExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
private
   
   UmgebungPrüfen : GlobaleDatentypen.Sichtweite;
   BereitsGeprüft : GlobaleDatentypen.SichtweiteMitNullwert;
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertVerschieben : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

end EinheitVerschieben;
