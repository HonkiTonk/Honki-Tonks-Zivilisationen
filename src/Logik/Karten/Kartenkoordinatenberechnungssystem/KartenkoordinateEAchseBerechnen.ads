pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartenkoordinateEAchseBerechnen is

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene;
   
private
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangEAchse : ÜberhangArray;
   
   ZwischenwertEAchse : ÜberhangArray;
         
   function KartenkoordinateEAchseÜbergangUnten
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene;
   
   function KartenkoordinateEAchseÜbergangOben
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene;

end KartenkoordinateEAchseBerechnen;
