with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with WeltkarteRecords;

package Weltkarte is
   pragma Elaborate_Body;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Ebenen auch vom Nutzer einstellbar machen, mit Begrenzung auf -1 .. 0. äöü
   type KarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of WeltkarteRecords.WeltkarteRecord;
   Karte : KarteArray := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));

end Weltkarte;
