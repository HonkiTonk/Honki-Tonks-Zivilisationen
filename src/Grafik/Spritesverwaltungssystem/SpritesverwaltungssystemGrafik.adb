with Sf.Graphics.Sprite;
with Sf.Graphics.RenderWindow;

with FensterGrafik;

package body SpritesverwaltungssystemGrafik is
   
   procedure SetzenBereichSkalierenZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturExtern : in Sf.Graphics.sfTexture_Ptr;
      BereichExtern : in Sf.Graphics.Rect.sfIntRect;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Setzen (SpriteAccessExtern  => SpriteAccessExtern,
              TextureAccessExtern => TexturExtern);
      
      Sf.Graphics.Sprite.setTextureRect (sprite    => SpriteAccessExtern,
                                         rectangle => BereichExtern);
      
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end SetzenBereichSkalierenZeichnen;
   
   
   
   procedure SetzenBereichPositionFarbeSkalierenZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Setzen (SpriteAccessExtern  => SpriteAccessExtern,
              TextureAccessExtern => TexturExtern);
      
      Sf.Graphics.Sprite.setTextureRect (sprite    => SpriteAccessExtern,
                                         rectangle => TexturbereichExtern);
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      
      Sf.Graphics.Sprite.setColor (sprite => SpriteAccessExtern,
                                   color  => FarbeExtern);
      
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end SetzenBereichPositionFarbeSkalierenZeichnen;
   
   
   
   procedure SetzenBereichPositionSkalieren
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturExtern : in Sf.Graphics.sfTexture_Ptr;
      BereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Setzen (SpriteAccessExtern  => SpriteAccessExtern,
              TextureAccessExtern => TexturExtern);
      
      Sf.Graphics.Sprite.setTextureRect (sprite    => SpriteAccessExtern,
                                         rectangle => BereichExtern);
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
   end SetzenBereichPositionSkalieren;
   
   
   
   procedure PositionSkalierungZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end PositionSkalierungZeichnen;
   
   
   
   procedure PositionSkalieren
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
   end PositionSkalieren;
   
   
   
   procedure PositionZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end PositionZeichnen;
   
   
   
   procedure PositionFarbeZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      
      FarbeZeichnen (SpriteAccessExtern => SpriteAccessExtern,
                     FarbeExtern        => FarbeExtern);
      
   end PositionFarbeZeichnen;
   
   

   procedure FarbeZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Sprite.setColor (sprite => SpriteAccessExtern,
                                   color  => FarbeExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end FarbeZeichnen;
   
   
   
   procedure Farbe
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Sprite.setColor (sprite => SpriteAccessExtern,
                                   color  => FarbeExtern);
      
   end Farbe;
   
   
   
   procedure Setzen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is begin
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TextureAccessExtern,
                                     resetRect => Sf.sfTrue);
      
   end Setzen;

end SpritesverwaltungssystemGrafik;
