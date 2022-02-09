pragma SPARK_Mode (On);

with KartenRecords;
with KartenDatentypen;

package KartePositionKartenformen is

   function KartenPositionXZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionTorus
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionKugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionViereck
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionKugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenPositionTugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
     
   function KartenPositionTugelExtrem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
private
   
   type PositionArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   ZwischenPositionAchse : PositionArray;
   ZwischenPositionTugelAchse : PositionArray;
   
   type ÄnderungArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenfeld;
   EAchse : ÄnderungArray;
   YAchse : ÄnderungArray;
   XAchse : ÄnderungArray;

end KartePositionKartenformen;
