pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;

package KartengeneratorVariablen is

   ------------------------- Die Schleifenbereiche müssen auf jeden Fall mit gespeichert werden, sonst funktioniert nach dem Neustart des Spiels und Laden eines Spielstandes die Bewertung nicht mehr.
   ------------------------- SPEICHERN/LADEN
   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;

   Polbereiche : KartenRecords.KartenpoleKorrekturRecord;

   -- type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartengrundDatentypen.Kartengrund_Enum;
   -- GeneratorKarte : GeneratorKarteArray;

   -- type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   -- GeneratorGrund : GeneratorGrundArray;

end KartengeneratorVariablen;
