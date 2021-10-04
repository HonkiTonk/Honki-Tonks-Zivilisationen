pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, KartenRecords;
use GlobaleDatentypen;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitVerschieben
     (RasseLandExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
private
   
   UmgebungPrüfen : KartenDatentypen.Sichtweite;
   BereitsGeprüft : KartenDatentypen.SichtweiteMitNullwert;
   
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertVerschieben : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

end EinheitVerschieben;
