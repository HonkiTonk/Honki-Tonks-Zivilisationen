pragma SPARK_Mode (On);

with KartenRecords;
with KartenDatentypen;

package KartePositionAbstrakteBerechnungen is
   
   function PositionBestimmen_Y_X_WechselTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function PositionBestimmen_X_Y_WechselTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function PositionBestimmenEWechsel
     (EAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungEAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;
   
private
      
   type PositionFeldArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositivMitNullwert;
   YAchseZwischenwert : PositionFeldArray;
   XAchseZwischenwert : PositionFeldArray;
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangEAchse : ÜberhangArray;

end KartePositionAbstrakteBerechnungen;
