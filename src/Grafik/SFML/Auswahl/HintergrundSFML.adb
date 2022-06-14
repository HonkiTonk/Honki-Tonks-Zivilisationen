pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;

package body HintergrundSFML is
   
   procedure StandardHintergrund
     (StandardHintergrundExtern : in GrafikDatentypen.Standard_Texturen_Enum)
   is begin
      
      --------------------------------- EingeleseneTexturenSFML. ... später auch mal in eine lokale Variable auslagern.
      if
        EingeleseneTexturenSFML.StandardHintergrundAccess (StandardHintergrundExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => StandardspriteAccess,
                                         position => Nullposition);
         Sf.Graphics.Sprite.scale (sprite  => StandardspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => StandardspriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.StandardHintergrundAccess (StandardHintergrundExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => StandardspriteAccess);
         
      else
         null;
      end if;
      
   end StandardHintergrund;
   
   ------------------------- Ein SpriteAccess für jedes Menübild?
   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccessExtern,
                                         position => Nullposition);
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

end HintergrundSFML;
