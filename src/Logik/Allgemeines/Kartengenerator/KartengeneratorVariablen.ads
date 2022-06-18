pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;

package KartengeneratorVariablen is

   ----------------------------- Alle Einstellungen in die Parameter schieben oder thematische Gruppen bilden?
   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisrand;
   Eisschild : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisschild;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartenRecordKonstanten.Inselgröße;
   Abstände : KartenRecords.LandabständeRecord := KartenRecordKonstanten.Inselabstand;

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

end KartengeneratorVariablen;
