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
   is begin
      
      HintergrundPositionierbar (HintergrundExtern      => HintergrundExtern,
                                 AbmessungenExtern      => AbmessungenExtern,
                                 PositionExtern         => GrafikRecordKonstanten.Nullposition,
                                 DurchsichtigkeitExtern => GrafikKonstanten.Hintergrundtransparents);
      
   end Hintergrund;
   
   
   
   procedure HintergrundPositionierbar
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        EingeleseneTexturenGrafik.HintergrundAccess (HintergrundExtern) = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.Hintergrund: Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
      
         -- Muss ich bei sowas überhaupt was zeichnen? Sollte nach dem Leeren des Fensters doch eh immer schwarz sein, oder? äöü
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => PositionExtern,
                                                 FarbeExtern     => Sf.Graphics.Color.sfBlack);
         
      else
         Sf.Graphics.Sprite.scale (sprite  => HintergrundSpritePositionierbarAccess,
                                   factors => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => HintergrundSpritePositionierbarAccess,
                                                                                                      TextureAccessExtern => EingeleseneTexturenGrafik.HintergrundAccess (HintergrundExtern),
                                                                                                      GrößeExtern         => AbmessungenExtern));
         
         Farbe := Sf.Graphics.Sprite.getColor (sprite => HintergrundSpritePositionierbarAccess);
         
         case
           HintergrundExtern
         is
            when GrafikDatentypen.Hintergrund_Undurchsichtig_Enum =>
               Farbe.a := GrafikKonstanten.Undurchsichtig;
               
            when GrafikDatentypen.Hintergrund_Durchsichtig_Enum =>
               Farbe.a := DurchsichtigkeitExtern;
         end case;
         
         SpritesverwaltungssystemGrafik.PositionFarbeZeichnen (SpriteAccessExtern => HintergrundSpritePositionierbarAccess,
                                                               PositionExtern     => PositionExtern,
                                                               FarbeExtern        => Farbe);
      end if;
      
   end HintergrundPositionierbar;
   
   
   
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
      
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                                 FarbeExtern     => Sf.Graphics.Color.sfBlack);
         
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
      end if;
      
   end Spezieshintergrund;

end HintergrundGrafik;
