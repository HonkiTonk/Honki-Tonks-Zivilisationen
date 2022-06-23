pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );

   function TextViertelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function TextHalbeBreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function HalbeBildschirmhöhe
     return Float;
   
private
   
   Position : Float;
   TextHalbeBreite : Float;
   
   PositionLogik : Float;
   TextHalbeBreiteLogik : Float;

end AllgemeineTextBerechnungenSFML;
