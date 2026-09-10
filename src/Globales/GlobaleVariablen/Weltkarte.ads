with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with WeltkarteRecords;

package Weltkarte is
   pragma Elaborate_Body;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord := KartenRecordKonstanten.Standardkartenparameter;

   -- Das mal in einen Vektor packen? äöü
   type KarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.SenkrechtePositiv'Range, KartenDatentypen.WaagerechtePositiv'Range) of WeltkarteRecords.WeltkarteRecord;
   Karte : KarteArray := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));

end Weltkarte;
