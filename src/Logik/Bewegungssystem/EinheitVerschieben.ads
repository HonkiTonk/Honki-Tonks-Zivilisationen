pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with EinheitStadtRecords;
with KartenRecords;
with KartenDatentypen;
with EinheitStadtDatentypen;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitVerschieben
     (RasseLandExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
private
   
   UmgebungPrüfen : KartenDatentypen.Sichtweite;
   BereitsGeprüft : KartenDatentypen.SichtweiteMitNullwert;
   
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertVerschieben : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end EinheitVerschieben;
