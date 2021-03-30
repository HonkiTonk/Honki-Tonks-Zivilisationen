pragma SPARK_Mode (On);

with GlobaleRecords;

package KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer;

private
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end KartenGeneratorKueste;
