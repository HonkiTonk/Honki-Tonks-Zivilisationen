with KartenDatentypen;
with SystemDatentypen;

private with KartenkoordinatenWerteLogik;

package KartenkoordinateEAchseBerechnenLogik is
   pragma Elaborate_Body;

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;
   
private
   
   ÜberhangEAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   ZwischenwertEAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   
         
   function KartenkoordinateEAchseÜbergangUnten
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;
   
   function KartenkoordinateEAchseÜbergangOben
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;

end KartenkoordinateEAchseBerechnenLogik;
