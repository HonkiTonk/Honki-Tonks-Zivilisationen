pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with ZahlenDatentypen;
with WeltkarteRecords;

package Karten is

   -- Muss gesetzt werden da sonst im aktuellen System die Berechnung der Sichweite durch den Grafiktask nicht funktioniert!
   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen? äöü
   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of WeltkarteRecords.WeltkarteRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of ZahlenDatentypen.EigenerInteger;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

end Karten;
