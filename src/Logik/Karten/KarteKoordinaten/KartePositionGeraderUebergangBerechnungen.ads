pragma SPARK_Mode (On);

with KartenDatentypen;

package KartePositionGeraderUebergangBerechnungen is
   
   function PositionBestimmenEWechsel
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.EbeneVorhanden;

   function PositionBestimmenYWechsel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;

   function PositionBestimmenXWechsel
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;
   
private
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangEAchse : ÜberhangArray;
   ÜberhangYAchse : ÜberhangArray;
   ÜberhangXAchse : ÜberhangArray;
   
   ZwischenwertEAchse : ÜberhangArray;

end KartePositionGeraderUebergangBerechnungen;
