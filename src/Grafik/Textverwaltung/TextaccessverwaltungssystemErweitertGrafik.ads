with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Color;

package TextaccessverwaltungssystemErweitertGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
   function TextSkalierenFarbeZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 MaximaleTextbreiteExtern >= 0.00
              ),
         
       Post => (
                  TextSkalierenFarbeZeichnen'Result > 0.00
               );

   function TextSkalierenZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 MaximaleTextbreiteExtern >= 0.00
              ),
         
       Post => (
                  TextSkalierenZeichnen'Result > 0.00
               );
   
   function TextSkalierenMittelnZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 MaximaleTextbreiteExtern >= 0.00
              ),
         
       Post => (
                  TextSkalierenMittelnZeichnen'Result > 0.00
               );
   
   function SkalierenMittelnZeichnen
     (TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 MaximaleTextbreiteExtern >= 0.00
              ),
         
       Post => (
                  SkalierenMittelnZeichnen'Result > 0.00
               );
   
private
   
   Textbreite : Float;
   XTextposition : Float;
      
   Skalierung : Sf.System.Vector2.sfVector2f;

end TextaccessverwaltungssystemErweitertGrafik;
