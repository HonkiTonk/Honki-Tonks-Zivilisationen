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
      
      -- EingeleseneTexturenSFML. ... später auch mal in eine lokale Variable auslagern. äöü
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
   
   
   
   -- Ein SpriteAccess für jedes Menübild? äöü
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
      
   
   
   -- Hintergrund für das Baumenü.
   -- Das hier alles noch einmal überarbeiten, unter anderem passt das mit den Menüs auch nicht. äöü
   procedure TextHintergrund
     (GebäudeEinheitExtern : in Boolean;
      AbstandÜberschriftExtern : in Float;
      VerhältnisTextfeldExtern : in Sf.System.Vector2.sfVector2f;
      StartpositionExtern : in Float)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum) /= null
      then
         case
           GebäudeEinheitExtern
         is
            when True =>
               PositionHintergrund := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschriftExtern);
               
            when False =>
               PositionHintergrund := (StartpositionExtern, AbstandÜberschriftExtern);
         end case;
         
         Sf.Graphics.Sprite.setPosition (sprite   => HintergrundspriteAccess,
                                         position => PositionHintergrund);
         
         Sf.Graphics.Sprite.scale (sprite  => HintergrundspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenTeilBild (SpriteAccessExtern  => HintergrundspriteAccess,
                                                                                                           TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum),
                                                                                                           VerhältnisExtern    => VerhältnisTextfeldExtern));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         -- Später hier einen einfarbigen Hintergrund wie bei den Kartenfeldern einbauen. äöü
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.TextHintergrund - Textur nicht gefunden: " & MenueDatentypen.Rassen_Menü_Enum'Wide_Wide_Image);
      end if;
      
   end TextHintergrund;

end HintergrundSFML;
