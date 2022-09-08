pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with WeltkarteRecords;

package Karten is

   -- Muss gesetzt werden da sonst im aktuellen System die Berechnung der Sichweite durch den Grafiktask nicht funktioniert!
   -- Ist das noch aktuell? äöü
   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen? äöü
   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of WeltkarteRecords.WeltkarteRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));

end Karten;
