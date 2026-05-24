with KartenDatentypen;
with SystemDatentypen;

private with KartenkoordinatenWerteLogik;

package KartenkoordinateEbeneBerechnenLogik is
   pragma Elaborate_Body;

   function KartenkoordinateEbeneBerechnen
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.EbeneBasis;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.EbeneBasis;
   
private
   
   ÜberhangEbene : KartenkoordinatenWerteLogik.ÜberhangArray;
   ZwischenwertEbene : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   
         
   function KartenkoordinateEbeneÜbergangUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.EbeneBasis;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.EbeneBasis;
   
   function KartenkoordinateEbeneÜbergangOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.EbeneBasis;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.EbeneBasis;

end KartenkoordinateEbeneBerechnenLogik;
