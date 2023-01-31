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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnen: TexturAccessExtern: null");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                 TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern: null");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.TexturenSetzenSkalierenStadtbewirtschaftung (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                            TextureAccessExtern => TexturAccessExtern,
                                                                                                                                            GrößeExtern         => GrößeExtern),
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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtkarteZeichnen: TexturAccessExtern: null");
         
      else
         SpriteZeichnen (SpriteAccessExtern => SpriteAccess,
                         PositionExtern     => (0.00, 0.00),
                         SkalierungExtern   => TexturenSetzenSkalierenGrafik.Stadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                         TextureAccessExtern => TexturAccessExtern));
      end if;
      
   end StadtkarteZeichnen;
   
   
   
   -- Das hier dann überall wo es möglich ist verwenden und den Rest entsprechend anpassen? äöü
   procedure SpriteZeichnenVariabel
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.SpriteZeichnenVariabel: TexturAccessExtern: null");
         
      else
         SpriteZeichnen (SpriteAccessExtern => SpriteAccess,
                         PositionExtern     => PositionExtern,
                         SkalierungExtern   => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpriteAccess,
                                                                                                       TextureAccessExtern => TexturAccessExtern,
                                                                                                       GrößeExtern         => GrößeExtern));
      end if;
      
   end SpriteZeichnenVariabel;
   
   
   
   procedure SpriteZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccessExtern,
                                factors => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccessExtern);
      
   end SpriteZeichnen;
   
   

   procedure DurchsichtigesSpriteZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccessExtern,
                                factors => SkalierungExtern);
      
      Farbe := Sf.Graphics.Sprite.getColor (sprite => SpriteAccessExtern);
      
      Farbe.a := DurchsichtigkeitExtern;
      
      Sf.Graphics.Sprite.setColor (sprite => SpriteAccessExtern,
                                   color  => Farbe);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccessExtern);
      
   end DurchsichtigesSpriteZeichnen;
   
   
   
   procedure BefehlsknöpfespriteZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccessExtern);
      
   end BefehlsknöpfespriteZeichnen;

end KartenspritesZeichnenGrafik;
