pragma SPARK_Mode (On);

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf;
with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;
with Fehler;

package body TexturenSetzenSkalierenSFML is
   
   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      KartenfelderAbmessung := BerechnungenKarteSFML.KartenfelderAbmessung;
      
      SkalierungKartenfeld.x := KartenfelderAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := KartenfelderAbmessung.y / GrößeTextur.y;
      
      if
        SkalierungKartenfeld.x <= 0.00
        or
          SkalierungKartenfeld.y <= 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "SkalierungKartentexturenBerechnenSFML.SkalierungTexturenKartenfelderWeltkarteBerechnen - Skalierungsfaktor wurde auf <= 0.00 gesetzt.");
         
      else
         null;
      end if;
      
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
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden? -----------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      StadtfelderAbmessung := BerechnungenKarteSFML.StadtfelderAbmessung;
      
      SkalierungKartenfeld.x := StadtfelderAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := StadtfelderAbmessung.y / GrößeTextur.y;
            
      if
        SkalierungKartenfeld.x <= 0.00
        or
          SkalierungKartenfeld.y <= 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "SkalierungKartentexturenBerechnenSFML.SkalierungTexturenKartenfelderStadtkarteBerechnen - Skalierungsfaktor wurde auf <= 0.00 gesetzt.");
         
      else
         null;
      end if;
      
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
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden? -------------------------
      GrößeTextur := (Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccessExtern).height);
      StadtAbmessung := BerechnungenKarteSFML.StadtKarte;
      
      SkalierungKartenfeld.x := StadtAbmessung.x / GrößeTextur.x;
      SkalierungKartenfeld.y := StadtAbmessung.y / GrößeTextur.y;
      
      if
        SkalierungKartenfeld.x <= 0.00
        or
          SkalierungKartenfeld.y <= 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamteStadtkarte - Skalierungsfaktor wurde auf <= 0.00 gesetzt.");
         
      else
         null;
      end if;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenGesamteStadtkarte;

end TexturenSetzenSkalierenSFML;
