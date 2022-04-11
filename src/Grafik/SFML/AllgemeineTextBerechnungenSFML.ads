pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

package AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

   function TextViertelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float;
   
   function TextHalbeBreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float;
   
private
   
   Position : Float;
   TextHalbeBreite : Float;
   
   PositionLogik : Float;
   TextHalbeBreiteLogik : Float;

end AllgemeineTextBerechnungenSFML;
