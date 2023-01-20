with Sf.Graphics;

package TextberechnungenBreiteGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
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
   
   function MittelpositionBerechnenGlobaleGrenzen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 ViewbreiteExtern >= 0.00
              );
   
   function HalbeBreiteBerechnenGlobaleGrenzen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
              ),
         
       Post => (
                  HalbeBreiteBerechnenGlobaleGrenzen'Result >= 0.00
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
