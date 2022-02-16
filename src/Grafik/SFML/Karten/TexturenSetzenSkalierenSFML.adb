pragma SPARK_Mode (On);

with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;
with Fehler;

package body TexturenSetzenSkalierenSFML is
   
   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccessExtern,
                                     texture => TextureAccessExtern);
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden?
      GrößeTextur := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      KartenfelderAbmessung := BerechnungenKarteSFML.KartenfelderAbmessung;
      
      if
        GrößeTextur.x /= KartenfelderAbmessung.x
      then
         SkalierungKartenfeld.x := KartenfelderAbmessung.x / GrößeTextur.x;
         
      else
         SkalierungKartenfeld.x := 1.00;
      end if;
      
      if
        GrößeTextur.y /= KartenfelderAbmessung.y
      then
         SkalierungKartenfeld.y := KartenfelderAbmessung.y / GrößeTextur.y;
         
      else
         SkalierungKartenfeld.y := 1.00;
      end if;
      
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
      
      Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccessExtern,
                                     texture => TextureAccessExtern);
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden?
      GrößeTextur := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      StadtfelderAbmessung := BerechnungenKarteSFML.StadtfelderAbmessung;
      
      if
        GrößeTextur.x /= StadtfelderAbmessung.x
      then
         SkalierungKartenfeld.x := StadtfelderAbmessung.x / GrößeTextur.x;
         
      else
         SkalierungKartenfeld.x := 1.00;
      end if;
      
      if
        GrößeTextur.y /= StadtfelderAbmessung.y
      then
         SkalierungKartenfeld.y := StadtfelderAbmessung.y / GrößeTextur.y;
         
      else
         SkalierungKartenfeld.y := 1.00;
      end if;
      
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
      
      Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccessExtern,
                                     texture => TextureAccessExtern);
      
      -- Es wird geprüft ob der Access /= null ist, aber nicht ob die Texturebreite/höhe = 0, sollte das geprüft werden?
      GrößeTextur := (Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).width, Sf.Graphics.Sprite.getLocalBounds (sprite => SpriteAccessExtern).height);
      StadtAbmessung := BerechnungenKarteSFML.StadtKarte;
      
      if
        GrößeTextur.x /= StadtAbmessung.x
      then
         SkalierungKartenfeld.x := StadtAbmessung.x / GrößeTextur.x;
         
      else
         SkalierungKartenfeld.x := 1.00;
      end if;
      
      if
        GrößeTextur.y /= StadtAbmessung.y
      then
         SkalierungKartenfeld.y := StadtAbmessung.y / GrößeTextur.y;
         
      else
         SkalierungKartenfeld.y := 1.00;
      end if;
      
      if
        SkalierungKartenfeld.x <= 0.00
        or
          SkalierungKartenfeld.y <= 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "KarteStadtSFML.GrafischeDarstellung - Skalierungsfaktor wurde auf <= 0.00 gesetzt.");
         
      else
         null;
      end if;
      
      return SkalierungKartenfeld;
      
   end TexturenSetzenSkalierenGesamteStadtkarte;

end TexturenSetzenSkalierenSFML;
