with Sf.Graphics;
with Sf.System.Vector2;
-- with Sf.Graphics.Rect;

package TexturenSetzenSkalierenGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfSprite_Ptr;
   use type Sf.Graphics.sfTexture_Ptr;
   
   procedure Textursetzung
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
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
   
   function AllgemeineSkalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  AllgemeineSkalierung'Result.x >= 0.00
                and
                  AllgemeineSkalierung'Result.y >= 0.00
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
   
   function Stadtkarte
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
                  Stadtkarte'Result.x >= 0.00
                and
                  Stadtkarte'Result.y >= 0.00
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
   
   SkalierungKartenfeld : Sf.System.Vector2.sfVector2f;
   SkalierungBild : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   Kartenabmessung : Sf.System.Vector2.sfVector2f;
   Rechteck : Sf.System.Vector2.sfVector2f;
      
   Texturengröße : Sf.System.Vector2.sfVector2f;
   Feldgröße : Sf.System.Vector2.sfVector2f;

end TexturenSetzenSkalierenGrafik;
