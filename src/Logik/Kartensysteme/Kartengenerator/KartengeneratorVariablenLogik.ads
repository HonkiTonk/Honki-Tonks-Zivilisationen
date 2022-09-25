pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartengrundDatentypen;

package KartengeneratorVariablenLogik is

   PolgrundOberfläche : KartengrundDatentypen.Kartengrund_Vorhanden_Enum := KartengrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartengrundDatentypen.Kartengrund_Vorhanden_Enum := KartengrundDatentypen.Untereis_Enum;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartenDatentypen.PolregionenArray := KartengeneratorRecordKonstanten.Eisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kontinentgröße;

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

end KartengeneratorVariablenLogik;
