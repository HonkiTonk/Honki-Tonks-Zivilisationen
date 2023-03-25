with Sf;
with Sf.Graphics.Sprite;

with FensterGrafik;
with SichtweitenGrafik;
with PruefungenGrafik;

package body TexturenSetzenSkalierenGrafik is
   
   function Weltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      KartenfelderAbmessung := SichtweitenGrafik.Kartenfeldfläche;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / Rechteck.x;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / Rechteck.y;
      
      return SkalierungKartenfeld;
      
   end Weltkarte;
   
   
   
   function Stadtbewirtschaftung
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      
      SkalierungKartenfeld.x := GrößeExtern.x / Rechteck.x;
      SkalierungKartenfeld.y := GrößeExtern.y / Rechteck.y;
      
      return SkalierungKartenfeld;
      
   end Stadtbewirtschaftung;
   
   
   
   function Stadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      Kartenabmessung := FensterGrafik.AktuelleAuflösung;
      
      SkalierungKartenfeld.x := Kartenabmessung.x / Rechteck.x;
      SkalierungKartenfeld.y := Kartenabmessung.y / Rechteck.y;
      
      return SkalierungKartenfeld;
      
   end Stadtkarte;
   
   
   
   function TexturskalierungVariabel
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      
      SkalierungBild.x := GrößeExtern.x / Rechteck.x;
      SkalierungBild.y := GrößeExtern.y / Rechteck.y;
      
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
