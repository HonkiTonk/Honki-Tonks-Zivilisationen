pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;

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
      KartenfelderAbmessung := BerechnungenKarteSFML.KartenfelderAbmessung;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / Rechteck.width;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / Rechteck.height;
      
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
      
      Rechteck := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern); 
      StadtfelderAbmessung := BerechnungenKarteSFML.StadtfelderAbmessung;
      
      SkalierungKartenfeld.x := StadtfelderAbmessung.x / Rechteck.width;
      SkalierungKartenfeld.y := StadtfelderAbmessung.y / Rechteck.height;
      
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
      
      Rechteck := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern); 
      StadtAbmessung := (BerechnungenKarteSFML.StadtKarte.width, BerechnungenKarteSFML.StadtKarte.height);
      
      SkalierungKartenfeld.x := StadtAbmessung.x / Rechteck.width;
      SkalierungKartenfeld.y := StadtAbmessung.y / Rechteck.height;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenGesamteStadtkarte;
   
   
   
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

end TexturenSetzenSkalierenGrafik;