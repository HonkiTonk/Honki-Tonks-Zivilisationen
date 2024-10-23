with KartenDatentypen;
with SystemDatentypen;

private with KartenkoordinatenWerteLogik;

package KartenkoordinateEbeneBerechnenLogik is
   pragma Elaborate_Body;

   function KartenkoordinateEbeneBerechnen
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;
   
private
   
   ÜberhangEbene : KartenkoordinatenWerteLogik.ÜberhangArray;
   ZwischenwertEbene : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   
         
   function KartenkoordinateEbeneÜbergangUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;
   
   function KartenkoordinateEbeneÜbergangOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene;

end KartenkoordinateEbeneBerechnenLogik;
