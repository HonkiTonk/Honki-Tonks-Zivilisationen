with Sf;
with Sf.Graphics.Sprite;

with FensterGrafik;
with SichtweitenGrafik;
with PruefungenGrafik;

-- Bei der Verwendung dieser Funktionen immer darauf achten erste die Skalierung aufzurufen und in einem Extraschritt sie zu zeichnen/umzufärben/usw., da es sonst zu Fehlern kommen kann!
package body TexturenskalierungGrafik is
   
   function Kartenfeldskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturengröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (Float (TexturengrößeExtern.x), Float (TexturengrößeExtern.y)));
      Bereichsabmessung := SichtweitenGrafik.Kartenfeldfläche;
      
      Skalierung.x := Bereichsabmessung.x / Texturengröße.x;
      Skalierung.y := Bereichsabmessung.y / Texturengröße.y;
      
      return Skalierung;
      
   end Kartenfeldskalierung;
   
   
   
   function Stadtfeldskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturengröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (Float (TexturengrößeExtern.x), Float (TexturengrößeExtern.y)));
      Bereichsabmessung := SichtweitenGrafik.Stadtumgebungsfläche;
      
      Skalierung.x := Bereichsabmessung.x / Texturengröße.x;
      Skalierung.y := Bereichsabmessung.y / Texturengröße.y;
      
      return Skalierung;
      
   end Stadtfeldskalierung;
   
   
   
   function Vollbildskalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturengröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (Float (TexturengrößeExtern.x), Float (TexturengrößeExtern.y)));
      Bereichsabmessung := FensterGrafik.AktuelleAuflösung;
      
      Skalierung.x := Bereichsabmessung.x / Texturengröße.x;
      Skalierung.y := Bereichsabmessung.y / Texturengröße.y;
      
      return Skalierung;
      
   end Vollbildskalierung;
   
   
   
   function VariableSkalierung
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2u;
      BereichsabmessungExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturengröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (Float (TexturengrößeExtern.x), Float (TexturengrößeExtern.y)));
      Bereichsabmessung := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => BereichsabmessungExtern);
      
      Skalierung.x := Bereichsabmessung.x / Texturengröße.x;
      Skalierung.y := Bereichsabmessung.y / Texturengröße.y;
      
      return Skalierung;
      
   end VariableSkalierung;
   
   
   
   function Weltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      Bereichsabmessung := SichtweitenGrafik.Kartenfeldfläche;
      
      Skalierung.x := Bereichsabmessung.x / Rechteck.x;
      Skalierung.y := Bereichsabmessung.y / Rechteck.y;
      
      return Skalierung;
      
   end Weltkarte;
   
   
   
   function Stadtbewirtschaftung
     (FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      TexturengrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Feldgröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (FeldgrößeExtern.x, FeldgrößeExtern.y));
      Texturengröße := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => (TexturengrößeExtern.x, TexturengrößeExtern.y));
      
      Skalierung.x := Feldgröße.x / Texturengröße.x;
      Skalierung.y := Feldgröße.y / Texturengröße.y;
      
      return Skalierung;
      
   end Stadtbewirtschaftung;
   
   
   
   function Stadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      Rechteck := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      -- Kartenabmessung := FensterGrafik.AktuelleAuflösung;
      
     -- Skalierung.x := Kartenabmessung.x / Rechteck.x;
    --  Skalierung.y := Kartenabmessung.y / Rechteck.y;
      
      return Skalierung;
      
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
      
      Rechteck := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      Rechteck := PruefungenGrafik.NullprüfungFloatvektor (GrößeExtern => Rechteck);
      
       Skalierung.x := GrößeExtern.x / Rechteck.x;
      Skalierung.y := GrößeExtern.y / Rechteck.y;
      
      return Skalierung;
      
   end TexturskalierungVariabel;
     
end TexturenskalierungGrafik;
