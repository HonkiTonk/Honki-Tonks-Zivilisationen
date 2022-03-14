pragma SPARK_Mode (On);

with KartenDatentypen;
with KartenRecords;

package KartePositionRueckwaertsUebergangBerechnungen is

   function PositionBestimmenYAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

   function PositionBestimmenXAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

private

   YAchseZwischenwert : KartenDatentypen.KartenfeldPositivMitNullwert;
   XAchseZwischenwert : KartenDatentypen.KartenfeldPositivMitNullwert;

end KartePositionRueckwaertsUebergangBerechnungen;
