pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;
with Fehler;

package body KarteGrafikenZeichnenSFML is

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      -- TextureAccessExtern muss nicht auf null geprüft werden, weil das ungleich null sein Voraussetzung ist hier her zu kommen.
      -- Sollte man sowas trotzdem prüfen? Für den Fall dass das irgendwo falsch eingebaut ist? ----------------------
      if
        SpriteAccesExtern = null
      then
         -- Muss hier Stopp sein, da sonst nichts gezeichnet wird.
         -- Alternativ könnte man das in eine Funktion umbauen und je nach Rückgabewert noch ein Feld ohne Textur zeichnen lassen?
         Fehler.LogikStopp (FehlermeldungExtern => "KarteGrafikenZeichnenSFML.SpriteZeichnen - SpriteAccesExtern = null.");
         
      else
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccesExtern,
                                         position => PositionExtern);
         Sf.Graphics.Sprite.setScale (sprite => SpriteAccesExtern,
                                      scale  => SkalierungExtern);
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccesExtern);
      end if;
      
   end SpriteZeichnen;

end KarteGrafikenZeichnenSFML;
