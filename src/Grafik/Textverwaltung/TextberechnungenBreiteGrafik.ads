with Sf.Graphics;

package TextberechnungenBreiteGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
   function WinzigerSpaltenabstand
     return Float
     with
       Post => (
                  WinzigerSpaltenabstand'Result >= 0.00
               );
   
   function KleinerSpaltenabstand
     return Float
     with
       Post => (
                  KleinerSpaltenabstand'Result >= 0.00
               );
   
   function Spaltenabstand
     return Float
     with
       Post => (
                  Spaltenabstand'Result >= 0.00
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
   
   function TextbreiteAnfangsabstand
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      AbstandExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 AbstandExtern >= 0.00
              ),
         
       Post => (
                  TextbreiteAnfangsabstand'Result >= 0.00
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
