pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartePositionGeraderUebergangBerechnungen is
   
   function PositionBestimmenEAchse
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.EbeneVorhanden;

   function PositionBestimmenYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;

   function PositionBestimmenXAchse
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
