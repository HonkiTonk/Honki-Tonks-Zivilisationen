with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;
with TexturenSetzenSkalierenGrafik;
with Warnung;

package body KartenspritesZeichnenGrafik is
   
   procedure KartenfeldZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnen: TexturAccessExtern = null.");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                 TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure StadtfeldZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern = null.");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                  TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => Sf.sfUint8'Last);
      end if;
      
   end StadtfeldZeichnen;
   
   
   
   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccesExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccesExtern,
                                factors => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccesExtern);
      
   end SpriteZeichnen;
   
   

   procedure DurchsichtigesSpriteZeichnen
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
      
   end DurchsichtigesSpriteZeichnen;
   
   
   
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
