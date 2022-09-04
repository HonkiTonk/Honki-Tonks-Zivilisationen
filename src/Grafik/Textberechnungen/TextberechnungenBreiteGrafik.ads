pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenBreiteGrafik is

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 ViewbreiteExtern >= 0.00
              );
   
   function HalbeBreiteBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              ),
         
       Post => (
                  HalbeBreiteBerechnen'Result >= 0.00
               );
   
   function NeueTextbreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 TextbreiteExtern >= 0.00
              ),
         
       Post => (
                  NeueTextbreiteErmitteln'Result >= 0.00
               );
   
private
   
   NeueTextbreite : Float;

end TextberechnungenBreiteGrafik;
