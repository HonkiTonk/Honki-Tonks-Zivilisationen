pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenHoeheSFML is

   function HalbeBildschirmhöhe
     return Float
     with
       Post => (
                  HalbeBildschirmhöhe'Result > 0.00
               );
   
   function HalbeHöheBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              );
   
   function KleinerZeilenabstand
     return Float
     with
       Post => (
                  KleinerZeilenabstand'Result > 0.00
               );
   
   function Zeilenabstand
     return Float
     with
       Post => (
                  Zeilenabstand'Result > 0.00
               );
   
   function GroßerZeilenabstand
     return Float
     with
       Post => (
                  GroßerZeilenabstand'Result > 0.00
               );
   
   function Überschriftabstand
     return Float
     with
       Post => (
                  Überschriftabstand'Result > 0.00
               );
   
   function ÜberschriftabstandGroß
     return Float
     with
       Post => (
                  ÜberschriftabstandGroß'Result > 0.00
               );
   
   function NeueTexthöheErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TexthöheExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 TexthöheExtern >= 0.00
              ),
         
       Post => (
                  NeueTexthöheErmitteln'Result >= 0.00
               );
   
private
   
   NeueTexthöhe : Float;

end TextberechnungenHoeheSFML;
