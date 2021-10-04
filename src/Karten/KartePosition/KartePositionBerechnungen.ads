pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

package KartePositionBerechnungen is

   function PositionBestimmenEAchseFest
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.Ebene;
   
   function PositionBestimmenYAchseFest
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function PositionBestimmenXAchseFest
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

   function PositionBestimmenXWechsel
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldPositiv;

   function PositionBestimmenYWechsel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldPositiv;
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function PositionBestimmen_X_Y_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
private
   
   type PositionFeldArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositivMitNullwert;
   PolYAchse : PositionFeldArray;
   PolXAchse : PositionFeldArray;
   
   type ÜberhangArray is array (KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangYAchse : ÜberhangArray;
   ÜberhangXAchse : ÜberhangArray;

end KartePositionBerechnungen;
