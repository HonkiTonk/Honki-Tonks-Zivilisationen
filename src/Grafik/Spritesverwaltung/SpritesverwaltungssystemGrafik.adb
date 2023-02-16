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
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccessExtern,
                                     texture   => TexturExtern,
                                     resetRect => Sf.sfTrue);
      
      Sf.Graphics.Sprite.setTextureRect (sprite    => SpriteAccessExtern,
                                         rectangle => BereichExtern);
      
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccessExtern,
                                   scale  => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => FensterGrafik.FensterLesen,
                                           object       => SpriteAccessExtern);
      
   end SetzenBereichSkalierenZeichnen;
   
   
   
   procedure PositionSkalierungZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccessExtern,
                                factors => SkalierungExtern);
      
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
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccessExtern,
                                factors => SkalierungExtern);
      
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

end SpritesverwaltungssystemGrafik;
