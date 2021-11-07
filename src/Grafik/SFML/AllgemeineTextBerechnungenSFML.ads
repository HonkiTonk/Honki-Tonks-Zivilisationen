pragma SPARK_Mode (On);

with Sf.Graphics;

package AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

   function TextViertelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float;
   
   function TextHalbeBreiteErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;
   
private
   
   Position : Float;
   TextHalbeBreite : Float;

end AllgemeineTextBerechnungenSFML;
