pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with GrafikKonstanten;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;
with Warnung;

package body HintergrundSFML is
   
   procedure Hintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern) /= null
      then
         Sf.Graphics.Sprite.scale (sprite  => HintergrundSpriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturskalierungVariabel (SpriteAccessExtern  => HintergrundSpriteAccess,
                                                                                                    TextureAccessExtern => EingeleseneTexturenSFML.HintergrundAccess (HintergrundExtern),
                                                                                                    GrößeExtern         => AbmessungenExtern));
         
         Farbe := Sf.Graphics.Sprite.getColor (sprite => HintergrundSpriteAccess);
         
         case
           HintergrundExtern
         is
            when GrafikDatentypen.Hintergrund_Undurchsichtig_Enum =>
               Farbe.a := GrafikKonstanten.Undurchsichtig;
               
            when GrafikDatentypen.Hintergrund_Durchsichtig_Enum =>
               Farbe.a := 150;
         end case;
         
         Sf.Graphics.Sprite.setColor (sprite => HintergrundSpriteAccess,
                                      color  => Farbe);
                        
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => HintergrundSpriteAccess);
         
      else
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundSFML.Hintergrund - Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
      end if;
      
   end Hintergrund;

end HintergrundSFML;
