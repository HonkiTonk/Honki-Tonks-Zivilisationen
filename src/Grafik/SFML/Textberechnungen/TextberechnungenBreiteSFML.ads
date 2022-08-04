pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenBreiteSFML is

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              ),
   
       Post => (
                  MittelpositionBerechnen'Result > 0.00
               );

   function ViertelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              ),
   
       Post => (
                  ViertelpositionBerechnen'Result > 0.00
               );
   
   function HalbeBreiteBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function NeueTextbreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
private
   
   Position : Float;
   NeueTextbreite : Float;

end TextberechnungenBreiteSFML;
