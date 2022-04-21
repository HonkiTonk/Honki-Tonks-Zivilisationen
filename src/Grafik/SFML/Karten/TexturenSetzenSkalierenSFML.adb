pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;
with GrafikEinstellungenSFML;

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
   
   
   
   function TexturenSetzenSkalierenGesamtesBild
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Sollte geprüft werden ob die Texturebreite/höhe /= 0 ist? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      GrößeGesamtbild := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      SkalierungBild.x := GrößeGesamtbild.x / GrößeTextur.x;
      SkalierungBild.y := GrößeGesamtbild.y / GrößeTextur.y;
      
      return SkalierungBild;
      
   end TexturenSetzenSkalierenGesamtesBild;
   
   
   
   function TexturenSetzenSkalierenTeilBild
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Sollte geprüft werden ob die Texturebreite/höhe /= 0 ist? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      GrößeGesamtbild := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      SkalierungBild.x := GrößeGesamtbild.x * VerhältnisExtern.x / GrößeTextur.x;
      SkalierungBild.y := GrößeGesamtbild.y * VerhältnisExtern.y / GrößeTextur.y;
      
      return SkalierungBild;
      
   end TexturenSetzenSkalierenTeilBild;

end TexturenSetzenSkalierenSFML;
