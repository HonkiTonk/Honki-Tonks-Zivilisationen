with Sf.Graphics;
with Sf.System.Vector2;

package TexturenskalierungGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfSprite_Ptr;
   use type Sf.Graphics.sfTexture_Ptr;
   
   function Kartenfeldskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenfeldskalierung'Result.x >= 0.00
                and
                  Kartenfeldskalierung'Result.y >= 0.00
               );
   
   function Stadtfeldskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Stadtfeldskalierung'Result.x >= 0.00
                and
                  Stadtfeldskalierung'Result.y >= 0.00
               );
   
   function Vollbildskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Vollbildskalierung'Result.x >= 0.00
                and
                  Vollbildskalierung'Result.y >= 0.00
               );
   
   function VariableSkalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u;
      BereichsabmessungExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  VariableSkalierung'Result.x >= 0.00
                and
                  VariableSkalierung'Result.y >= 0.00
               );

   function Weltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  Weltkarte'Result.x >= 0.00
                and
                  Weltkarte'Result.y >= 0.00
               );
      
   function Stadtbewirtschaftung
     (FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      TexturengrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
               and
                 TexturengrößeExtern.x >= 0.00
               and
                 TexturengrößeExtern.y >= 0.00
              ),
         
       Post => (
                  Stadtbewirtschaftung'Result.x >= 0.00
                and
                  Stadtbewirtschaftung'Result.y >= 0.00
               );
   
   function TexturskalierungVariabel
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturskalierungVariabel'Result.x >= 0.00
                and
                  TexturskalierungVariabel'Result.y >= 0.00
               );
   
private
   
   Skalierung : Sf.System.Vector2.sfVector2f;
   Bereichsabmessung : Sf.System.Vector2.sfVector2f;
   Rechteck : Sf.System.Vector2.sfVector2f;
      
   Texturengröße : Sf.System.Vector2.sfVector2f;
   Feldgröße : Sf.System.Vector2.sfVector2f;

end TexturenskalierungGrafik;
