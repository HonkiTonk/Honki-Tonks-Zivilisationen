with GrafikKonstanten;
with GrafikRecordKonstanten;

with EingeleseneTexturenGrafik;
with TexturenSetzenSkalierenGrafik;
with Fehlermeldungssystem;
with ObjekteZeichnenGrafik;
with SpritesverwaltungssystemGrafik;

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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.Hintergrund: Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
         
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
               Farbe.a := GrafikKonstanten.Hintergrundtransparents;
         end case;
         
         SpritesverwaltungssystemGrafik.FarbeZeichnen (SpriteAccessExtern => HintergrundSpriteAccess,
                                                       FarbeExtern        => Farbe);
         
         return;
      end if;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                              PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                              FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
   end Hintergrund;
   
   
   
   procedure Spezieshintergrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, HintergrundExtern) = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.Spezieshintergrund: Hintergrund fehlt: " & SpeziesExtern'Wide_Wide_Image & " " & HintergrundExtern'Wide_Wide_Image);
         
      else
         Sf.Graphics.Sprite.scale (sprite  => SpezieshintergrundSpriteAccess,
                                   factors => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpezieshintergrundSpriteAccess,
                                                                                                      TextureAccessExtern => EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, HintergrundExtern),
                                                                                                      GrößeExtern         => AbmessungenExtern));
         
         Farbe := Sf.Graphics.Sprite.getColor (sprite => SpezieshintergrundSpriteAccess);
         
        -- case
        --   HintergrundExtern
        -- is
        --    when GrafikDatentypen.Hintergrund_Undurchsichtig_Enum =>
               Farbe.a := GrafikKonstanten.Undurchsichtig;
               
        --    when GrafikDatentypen.Hintergrund_Durchsichtig_Enum =>
        --       Farbe.a := 150;
        -- end case;
        
         SpritesverwaltungssystemGrafik.FarbeZeichnen (SpriteAccessExtern => SpezieshintergrundSpriteAccess,
                                                       FarbeExtern        => Farbe);
         
         return;
      end if;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                              PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                              FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
   end Spezieshintergrund;

end HintergrundGrafik;
