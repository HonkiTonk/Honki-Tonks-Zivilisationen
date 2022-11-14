with Sf.Graphics.RenderWindow;

with GrafikKonstanten;

with EingeleseneTexturenGrafik;
with TexturenSetzenSkalierenGrafik;
with EinstellungenGrafik;
with Warnung;
with ObjekteZeichnenGrafik;

package body HintergrundGrafik is
   
   procedure Hintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        EingeleseneTexturenGrafik.HintergrundAccess (HintergrundExtern) = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundGrafik.Hintergrund: Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
         
      else
         Sf.Graphics.Sprite.scale (sprite  => HintergrundSpriteAccess,
                                   factors => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => HintergrundSpriteAccess,
                                                                                                      TextureAccessExtern => EingeleseneTexturenGrafik.HintergrundAccess (HintergrundExtern),
                                                                                                      GrößeExtern         => AbmessungenExtern));
         
         Farbe := Sf.Graphics.Sprite.getColor (sprite => HintergrundSpriteAccess);
         
         case
           HintergrundExtern
         is
            when GrafikDatentypen.Hintergrund_Undurchsichtig_Enum =>
               Farbe.a := GrafikKonstanten.Undurchsichtig;
               
            when GrafikDatentypen.Hintergrund_Durchsichtig_Enum =>
               Farbe.a := 200;
         end case;
         
         Sf.Graphics.Sprite.setColor (sprite => HintergrundSpriteAccess,
                                      color  => Farbe);
                        
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                              object       => HintergrundSpriteAccess);
         
         return;
      end if;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                              PositionExtern  => (0.00, 0.00),
                                              FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
   end Hintergrund;
   
   
   
   procedure Rassenhintergrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      HintergrundExtern : in GrafikDatentypen.Rassenhintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, HintergrundExtern) = null
      then
         Warnung.GrafikWarnung (WarnmeldungExtern => "HintergrundGrafik.Rassenhintergrund: Hintergrund fehlt: " & RasseExtern'Wide_Wide_Image & " - " & HintergrundExtern'Wide_Wide_Image);
         
      else
         Sf.Graphics.Sprite.scale (sprite  => RassenhintergrundSpriteAccess,
                                   factors => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => RassenhintergrundSpriteAccess,
                                                                                                      TextureAccessExtern => EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, HintergrundExtern),
                                                                                                      GrößeExtern         => AbmessungenExtern));
         
         -- Farbe := Sf.Graphics.Sprite.getColor (sprite => RassenhintergrundSpriteAccess);
         
         -- case
         --   HintergrundExtern
         -- is
         --   when GrafikDatentypen.Hintergrund_Undurchsichtig_Enum =>
         --      Farbe.a := GrafikKonstanten.Undurchsichtig;
               
         --   when GrafikDatentypen.Hintergrund_Durchsichtig_Enum =>
         --     Farbe.a := 150;
         -- end case;
         
         --  Sf.Graphics.Sprite.setColor (sprite => RassenhintergrundSpriteAccess,
         --                               color  => Farbe);
                        
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                              object       => RassenhintergrundSpriteAccess);
         
         return;
      end if;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                              PositionExtern  => (0.00, 0.00),
                                              FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
   end Rassenhintergrund;

end HintergrundGrafik;
