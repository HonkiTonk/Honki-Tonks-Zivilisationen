with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Rect;

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
   
   

   function TexturenSetzenSkalierenWeltkarte
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
                  TexturenSetzenSkalierenWeltkarte'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenWeltkarte'Result.y >= 0.00
               );

   function TexturenSetzenSkalierenStadtbewirtschaftung
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
                  TexturenSetzenSkalierenStadtbewirtschaftung'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenStadtbewirtschaftung'Result.y >= 0.00
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
   
   Rechteck : Sf.Graphics.Rect.sfFloatRect;

end TexturenSetzenSkalierenGrafik;
