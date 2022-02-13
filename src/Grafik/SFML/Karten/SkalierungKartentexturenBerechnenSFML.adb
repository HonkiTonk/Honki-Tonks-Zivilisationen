pragma SPARK_Mode (On);

with Sf.Graphics.Sprite;

with BerechnungenKarteSFML;
with Fehler;

package body SkalierungKartentexturenBerechnenSFML is
   
   function SkalierungTexturenKartenfelderWeltkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
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
      
   end SkalierungTexturenKartenfelderWeltkarteBerechnen;
   
   
   
   function SkalierungTexturenKartenfelderStadtkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
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
      
   end SkalierungTexturenKartenfelderStadtkarteBerechnen;
   
   
   
   function SkalierungTexturenGesamtStadtkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
   is begin
      
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
      
   end SkalierungTexturenGesamtStadtkarteBerechnen;

end SkalierungKartentexturenBerechnenSFML;
