pragma SPARK_Mode (On);

with Sf.Graphics.Sprite;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body KarteGrafikenZeichnenSFML is

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

end KarteGrafikenZeichnenSFML;
