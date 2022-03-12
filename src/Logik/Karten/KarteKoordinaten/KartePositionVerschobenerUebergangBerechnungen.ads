pragma SPARK_Mode (On);

with KartenDatentypen;
with KartenRecords;

package KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmenYAchseVerschoben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function PositionBestimmenXAchseVerschoben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

end KartePositionVerschobenerUebergangBerechnungen;
