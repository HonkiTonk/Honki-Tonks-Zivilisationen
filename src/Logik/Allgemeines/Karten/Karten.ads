pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;

package Karten is

   ----------------------- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen.
   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   Kartenparameter : KartenRecords.KartenparameterRecord := KartenRecordKonstanten.KartenparameterStandard;

   Polgrößen : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisrand;
   Eisschild : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisschild;

   -- Alle Angaben sind Radien.
   ----------------------------- Wird scheinbar noch nicht richtig verwendet/hat noch keine sinnvollen Werte?, noch einmal drüber schauen.
   Landgrößen : KartenRecords.LandgrößenRecord := KartenRecordKonstanten.Inselgröße;
   Abstände : KartenRecords.LandabständeRecord := KartenRecordKonstanten.Inselabstand;

end Karten;
