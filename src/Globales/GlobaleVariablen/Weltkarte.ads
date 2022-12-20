with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with WeltkarteRecords;

package Weltkarte is
   pragma Elaborate_Body;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen? äöü
   -- Eventuell auf -1 .. 0 als minimale Eingabe begrenzen? äöü
   type KarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of WeltkarteRecords.WeltkarteRecord;
   Karte : KarteArray := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));

end Weltkarte;
