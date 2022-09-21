pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;
with TexturenSetzenSkalierenGrafik;
with Warnung;

package body KartenspritesZeichnenGrafik is
   
   function SpriteGezeichnetKartenfeld
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
      return Boolean
   is begin
      
      if
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden = False
      then
         null;
         
      elsif
        TexturAccessExtern = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld: TexturAccessExtern = null.");
         
      else
         SpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                         PositionExtern         => PositionExtern,
                         SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                   TextureAccessExtern => TexturAccessExtern),
                         DurchsichtigkeitExtern => DurchsichtigkeitExtern);
         return True;
      end if;
      
      return False;
      
   end SpriteGezeichnetKartenfeld;
   
   
   
   function SpriteGezeichnetStadtfeld
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden = False
      then
         null;
         
      elsif
        TexturAccessExtern = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld: TexturAccessExtern = null.");
         
      else
         SpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                         PositionExtern         => PositionExtern,
                         SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                    TextureAccessExtern => TexturAccessExtern),
                         DurchsichtigkeitExtern => Sf.sfUint8'Last);
         return True;
      end if;
      
      return False;
      
   end SpriteGezeichnetStadtfeld;
   
   
   
   -- Das nach Hintergrund verschieben? äöü
   function SpriteGezeichnetStadtgrund
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        TexturAccessExtern /= null
      then
         SpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                         PositionExtern         => PositionExtern,
                         SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenGesamteStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                           TextureAccessExtern => TexturAccessExtern),
                         DurchsichtigkeitExtern => Sf.sfUint8'Last);
         return True;
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "KartenspritesZeichnenGrafik.SpriteGezeichnetStadtgrund: TexturAccessExtern = null.");
         return False;
      end if;
      
   end SpriteGezeichnetStadtgrund;
   
   

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccesExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccesExtern,
                                factors => SkalierungExtern);
      
      Farbe := Sf.Graphics.Sprite.getColor (sprite => SpriteAccesExtern);
      
      Farbe.a := DurchsichtigkeitExtern;
      
      Sf.Graphics.Sprite.setColor (sprite => SpriteAccesExtern,
                                   color  => Farbe);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccesExtern);
      
   end SpriteZeichnen;
   
   
   
   procedure BefehlsknöpfespriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccesExtern,
                                      position => PositionExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccesExtern);
      
   end BefehlsknöpfespriteZeichnen;

end KartenspritesZeichnenGrafik;
