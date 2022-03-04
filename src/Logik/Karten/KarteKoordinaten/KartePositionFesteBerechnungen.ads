pragma SPARK_Mode (On);

with KartenDatentypen;

package KartePositionFesteBerechnungen is

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

end KartePositionFesteBerechnungen;
