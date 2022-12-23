with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;
with TexturenSetzenSkalierenGrafik;
with Fehlermeldungssystem;

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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnen: TexturAccessExtern = null.");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                 TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern = null.");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccesExtern      => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenStadtbewirtschaftung (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                            TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => Sf.sfUint8'Last);
      end if;
      
   end StadtbewirtschaftungZeichnen;
   
   
   
   procedure StadtkarteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtkarteZeichnen: TexturAccessExtern = null.");
         
      else
         SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                         PositionExtern    => (0.00, 0.00),
                         SkalierungExtern  => TexturenSetzenSkalierenGrafik.Stadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                        TextureAccessExtern => TexturAccessExtern));
      end if;
      
   end StadtkarteZeichnen;
   
   
   
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
