pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenBreiteGrafik is
   pragma Elaborate_Body;
   
   function KleinerSpaltenabstandVariabel
     return Float
     with
       Post => (
                  KleinerSpaltenabstandVariabel'Result >= 0.00
               );
   
   function SpaltenabstandVariabel
     return Float
     with
       Post => (
                  SpaltenabstandVariabel'Result >= 0.00
               );

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
