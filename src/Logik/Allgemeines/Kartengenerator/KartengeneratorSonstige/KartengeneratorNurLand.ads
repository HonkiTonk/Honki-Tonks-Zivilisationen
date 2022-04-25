pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;

package KartengeneratorNurLand is

   procedure NurLandGenerieren;
   
private
   
   Polkorrektur : KartenRecords.KartenpoleKorrekturRecord;

end KartengeneratorNurLand;
