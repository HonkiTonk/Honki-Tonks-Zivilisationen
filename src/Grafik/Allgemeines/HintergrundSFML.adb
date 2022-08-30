pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;
with Warnung;

package body HintergrundSFML is
   
   procedure MenüHintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern) /= null
      then
         Sf.Graphics.Sprite.scale (sprite  => MenüspriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturskalierungVariabel (SpriteAccessExtern  => MenüspriteAccess,
                                                                                                    TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern),
                                                                                                    GrößeExtern         => AbmessungenExtern));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => MenüspriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.MenüHintergrund - Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
      end if;
      
   end MenüHintergrund;
   
   
   
   procedure SeitenleisteHintergrund
     (AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (GrafikDatentypen.Seitenleiste_Hintergrund_Enum) /= null
      then
         Sf.Graphics.Sprite.scale (sprite  => SeitenleistespriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturskalierungVariabel (SpriteAccessExtern  => SeitenleistespriteAccess,
                                                                                                    TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess (GrafikDatentypen.Seitenleiste_Hintergrund_Enum),
                                                                                                    GrößeExtern         => AbmessungenExtern));
                                   
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SeitenleistespriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.SeitenleisteHintergrund - Hintergrund fehlt: " & GrafikDatentypen.Seitenleiste_Hintergrund_Enum'Wide_Wide_Image);
      end if;
      
   end SeitenleisteHintergrund;

end HintergrundSFML;
