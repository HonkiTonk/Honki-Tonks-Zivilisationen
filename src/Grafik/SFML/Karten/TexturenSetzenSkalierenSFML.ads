pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package TexturenSetzenSkalierenSFML is

   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null
          and
            TextureAccessExtern /= null);

   function TexturenSetzenSkalierenStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null
          and
            TextureAccessExtern /= null);
   
   function TexturenSetzenSkalierenGesamteStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null
          and
            TextureAccessExtern /= null);
   
private
   
   SkalierungKartenfeld : Sf.System.Vector2.sfVector2f;
   GrößeTextur : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtAbmessung : Sf.System.Vector2.sfVector2f;

end TexturenSetzenSkalierenSFML;
