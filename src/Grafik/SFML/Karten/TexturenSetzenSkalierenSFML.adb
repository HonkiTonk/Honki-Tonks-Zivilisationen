pragma SPARK_Mode (On);

with Sf;
with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;

package body TexturenSetzenSkalierenSFML is
   
   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Sollte geprüft werden ob die Texturebreite/höhe /= 0 ist? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      KartenfelderAbmessung := BerechnungenKarteSFML.KartenfelderAbmessung;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / GrößeTextur.y;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenWeltkarte;
   
   
   
   function TexturenSetzenSkalierenStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Sollte geprüft werden ob die Texturebreite/höhe /= 0 ist? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      StadtfelderAbmessung := BerechnungenKarteSFML.StadtfelderAbmessung;
      
      SkalierungKartenfeld.x := StadtfelderAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := StadtfelderAbmessung.y / GrößeTextur.y;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenStadtkarte;
   
   
   
   function TexturenSetzenSkalierenGesamteStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Sollte geprüft werden ob die Texturebreite/höhe /= 0 ist? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      StadtAbmessung := BerechnungenKarteSFML.StadtKarte;
      
      SkalierungKartenfeld.x := StadtAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := StadtAbmessung.y / GrößeTextur.y;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenGesamteStadtkarte;

end TexturenSetzenSkalierenSFML;
