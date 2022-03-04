pragma SPARK_Mode (On);

with KartenDatentypen;
with KartenRecords;

package KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function PositionBestimmen_X_Y_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
private
   
   type PositionFeldArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositivMitNullwert;
   YAchseZwischenwert : PositionFeldArray;
   XAchseZwischenwert : PositionFeldArray;

end KartePositionVerschobenerUebergangBerechnungen;
