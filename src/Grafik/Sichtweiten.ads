pragma SPARK_Mode (On);

with KartenRecords;

package Sichtweiten is

   SichtweiteFestlegen : Positive;

   type SichtweitenArray is array (1 .. 3) of KartenRecords.AchsenKartenfeldPositivRecord;
   SichtweitenStandard : constant SichtweitenArray := (1 => (0, 6, 8),
                                                       2 => (0, 6, 16),
                                                       3 => (0, 6, 24));

end Sichtweiten;
