pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with ZahlenDatentypen;

package Karten is

   -- Muss gesetzt werden da sonst im aktuellen Problem die Berechnung der Sichweite durch den Grafiktast nicht funktioniert.
   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen? äöü
   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray;

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of ZahlenDatentypen.EigenerInteger;
   Stadtkarte : StadtkarteArray;

end Karten;
