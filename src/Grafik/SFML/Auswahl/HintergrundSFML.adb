pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;
with Warnung;

package body HintergrundSFML is
   
   procedure StandardHintergrund
     (StandardHintergrundExtern : in GrafikDatentypen.Standard_Texturen_Enum)
   is begin
      
      --------------------------------- EingeleseneTexturenSFML. ... später auch mal in eine lokale Variable auslagern.
      if
        EingeleseneTexturenSFML.StandardHintergrundAccess (StandardHintergrundExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => HintergrundspriteAccess,
                                         position => Nullposition);
         Sf.Graphics.Sprite.scale (sprite  => HintergrundspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => HintergrundspriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.StandardHintergrundAccess (StandardHintergrundExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.StandardHintergrund - Hintergrund nicht vorhanden: " & StandardHintergrundExtern'Wide_Wide_Image);
      end if;
      
   end StandardHintergrund;
   
   
   
   ------------------------- Ein SpriteAccess für jedes Menübild?
   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => HintergrundspriteAccess,
                                         position => Nullposition);
         Sf.Graphics.Sprite.scale (sprite  => HintergrundspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => HintergrundspriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         -- Hier wird kein einfarbiger Hintergrund wie bei den Kartenfeldern benötigt, da es ja immer auf schwarz gesetzt wird.
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.MenüHintergrund - Hintergrund nicht vorhanden: " & WelchesMenüExtern'Wide_Wide_Image);
      end if;
      
   end MenüHintergrund;

end HintergrundSFML;
