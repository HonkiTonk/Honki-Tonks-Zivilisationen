pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;

package KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmenYAchse
     (KoordinatenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.YXAchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositiv;
   
   function PositionBestimmenXAchse
     (KoordinatenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.YXAchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositiv;
   
private
   
   HalberWert : constant Float := 0.50;

end KartePositionVerschobenerUebergangBerechnungen;
