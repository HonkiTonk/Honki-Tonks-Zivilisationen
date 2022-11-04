pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartengrundDatentypen;
with KartenartDatentypen;

package KartengeneratorVariablenLogik is

   PolgrundOberfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Untereis_Enum;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartengeneratorRecordKonstanten.PolregionenArray := KartengeneratorRecordKonstanten.Eisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

end KartengeneratorVariablenLogik;
