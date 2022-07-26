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
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => HintergrundspriteAccess,
                                         position => Nullposition);
         Sf.Graphics.Sprite.scale (sprite  => HintergrundspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => HintergrundspriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.StandardHintergrund - Hintergrund nicht vorhanden: " & HintergrundExtern'Wide_Wide_Image);
      end if;
      
   end StandardHintergrund;
   
   
   
   procedure SeitenleisteHintergrund
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (GrafikDatentypen.Seitenleiste_Hintergrund_Enum) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => HintergrundspriteAccess,
                                         position => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, 0.00));
         -- Die aktuelle Skalierung macht die Leiste deutlich größer als es sein müsste, ist aber nicht zu bemerken weil sie einfach aus dem Bild rausgerendert wird. äöü
         -- Später mal anpassen. äöü
         Sf.Graphics.Sprite.scale (sprite  => HintergrundspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => HintergrundspriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess
                                                                                                                 (GrafikDatentypen.Seitenleiste_Hintergrund_Enum)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.SeitenleisteHintergrund - Hintergrund nicht vorhanden: " & GrafikDatentypen.Seitenleiste_Hintergrund_Enum'Wide_Wide_Image);
      end if;
      
   end SeitenleisteHintergrund;
      
   
   
   -- Hintergrund für das Baumenü.
   -- Das hier alles noch einmal überarbeiten, unter anderem passt das mit den Menüs auch nicht. äöü
   procedure TextHintergrund
     (LinksRechtsExtern : in Boolean;
      AbstandÜberschriftExtern : in Float;
      VerhältnisTextfeldExtern : in Sf.System.Vector2.sfVector2f;
      StartpositionExtern : in Float)
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (GrafikDatentypen.Zusatz_Hintergrund_Enum) /= null
      then
         case
           LinksRechtsExtern
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
                                                                                                           TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess (GrafikDatentypen.Zusatz_Hintergrund_Enum),
                                                                                                           VerhältnisExtern    => VerhältnisTextfeldExtern));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundspriteAccess);
         
      else
         -- Später hier einen einfarbigen Hintergrund wie bei den Kartenfeldern einbauen. äöü
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.TextHintergrund - Textur nicht gefunden: " & GrafikDatentypen.Zusatz_Hintergrund_Enum'Wide_Wide_Image);
      end if;
      
   end TextHintergrund;

end HintergrundSFML;
