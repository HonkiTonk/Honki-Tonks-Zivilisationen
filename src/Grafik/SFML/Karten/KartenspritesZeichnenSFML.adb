pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Sprite;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;
with TexturenSetzenSkalierenSFML;

package body KartenspritesZeichnenSFML is
   
   function SpriteGezeichnetKartenfeld
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        TexturAccessExtern /= null
      then
         KartenspritesZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccesExtern,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccesExtern,
                                                                                                                                      TextureAccessExtern => TexturAccessExtern));
         return True;
         
      else
         return False;
      end if;
      
   end SpriteGezeichnetKartenfeld;
   
   
   
   function SpriteGezeichnetStadtfeld
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        TexturAccessExtern /= null
      then
         SpriteZeichnen (SpriteAccesExtern => SpriteAccesExtern,
                         PositionExtern    => PositionExtern,
                         SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccesExtern,
                                                                                                             TextureAccessExtern => TexturAccessExtern));
         return True;
         
      else
         return False;
      end if;
      
   end SpriteGezeichnetStadtfeld;
   
   
   
   function SpriteGezeichnetStadtgrund
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        TexturAccessExtern /= null
      then
         SpriteZeichnen (SpriteAccesExtern => SpriteAccesExtern,
                         PositionExtern    => PositionExtern,
                         SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamteStadtkarte (SpriteAccessExtern  => SpriteAccesExtern,
                                                                                                                    TextureAccessExtern => TexturAccessExtern));
         return True;
         
      else
         return False;
      end if;
      
   end SpriteGezeichnetStadtgrund;
   
   

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin

      Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccesExtern,
                                      position => PositionExtern);
      Sf.Graphics.Sprite.scale (sprite  => SpriteAccesExtern,
                                factors => SkalierungExtern);
         
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                           object       => SpriteAccesExtern);
      
   end SpriteZeichnen;

end KartenspritesZeichnenSFML;
