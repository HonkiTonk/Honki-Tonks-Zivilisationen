pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package KartePositionBerechnungen is

   function PositionBestimmenEAchseFest
     (EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.Ebene;
   
   function PositionBestimmenYAchseFest
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert;
   
   function PositionBestimmenXAchseFest
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert;

   function PositionBestimmenXWechsel
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv;

   function PositionBestimmenYWechsel
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv;
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   function PositionBestimmen_X_Y_Wechsel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord;
   
private
   
   type PositionFeldArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleDatentypen.KartenfeldPositivMitNullwert;
   PolYAchse : PositionFeldArray;
   PolXAchse : PositionFeldArray;
   
   type ÜberhangArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangYAchse : ÜberhangArray;
   ÜberhangXAchse : ÜberhangArray;

end KartePositionBerechnungen;
