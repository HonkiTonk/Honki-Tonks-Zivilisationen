with Sf;
with Sf.Graphics.Sprite;

with SichtweitenGrafik;

package body TexturenSetzenSkalierenGrafik is
   
   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern); 
      KartenfelderAbmessung := SichtweitenGrafik.KartenfelderAbmessung;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / Rechteck.width;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / Rechteck.height;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenWeltkarte;
   
   
   
   function TexturenSetzenSkalierenStadtbewirtschaftung
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern); 
      KartenfelderAbmessung := SichtweitenGrafik.KartenfelderAbmessung;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / Rechteck.width;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / Rechteck.height;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenStadtbewirtschaftung;
   
   
   
   function TexturskalierungVariabel
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern); 
      
      SkalierungBild.x := GrößeExtern.x / Rechteck.width;
      SkalierungBild.y := GrößeExtern.y / Rechteck.height;
      
      return SkalierungBild;
      
   end TexturskalierungVariabel;
   
   
   
   procedure Textursetzung
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
   end Textursetzung;
     
end TexturenSetzenSkalierenGrafik;
