pragma SPARK_Mode (On);

with KartenRecords;
with KartenDatentypen;

package KartePositionAbstrakteKartenformen is
   
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
   ZwischenPositionEins : PositionArray;
   ZwischenPositionZwei : PositionArray;
   
   type ÄnderungArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenfeld;
   EAchse : ÄnderungArray;
   YAchse : ÄnderungArray;
   XAchse : ÄnderungArray;

end KartePositionAbstrakteKartenformen;
