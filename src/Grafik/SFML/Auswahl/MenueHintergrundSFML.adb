pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.Graphics.RenderWindow;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;

package body MenueHintergrundSFML is
   
   ------------------------- Ein SpriteAccess für jedes Menübild?
   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                         position => (0.00, 0.00));
         Sf.Graphics.Sprite.scale (sprite  => SpriteAccessExtern,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => SpriteAccessExtern,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccessExtern);
         
      else
         -- Hier wird kein einfarbiger Hintergrund wie bei den Kartenfeldern benötigt, da es ja immer auf schwarz gesetzt wird.
         null;
      end if;
      
   end MenüHintergrund;

end MenueHintergrundSFML;
