with KartenDatentypen;

private with KartenkoordinatenWerteLogik;

package KartenkoordinateEAchseBerechnenLogik is
   pragma Elaborate_Body;

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene;
   
private
   
   ÜberhangEAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   ZwischenwertEAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   
         
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

end KartenkoordinateEAchseBerechnenLogik;
