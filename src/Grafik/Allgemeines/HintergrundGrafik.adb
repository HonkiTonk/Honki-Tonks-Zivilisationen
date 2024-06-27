with GrafikKonstanten;
with GrafikRecordKonstanten;

with EingeleseneTexturenGrafik;
with TexturenskalierungGrafik;
with Fehlermeldungssystem;
with ObjekteZeichnenGrafik;
with SpritesverwaltungssystemGrafik;
with KartenspritesZeichnenGrafik;
with TexturenfelderVariablenGrafik;

package body HintergrundGrafik is
   
   procedure Intro
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Intro_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      HintergrundNeu (TexturAccessExtern  => EingeleseneTexturenGrafik.IntroAccess,
                      TexturbereichExtern => TexturenfelderVariablenGrafik.Introbereich (IntroExtern => HintergrundExtern),
                      AbmessungenExtern   => AbmessungenExtern);
      
   end Intro;
   
   
   
   procedure Hintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      HintergrundPositionierbar (HintergrundExtern      => HintergrundExtern,
                                 AbmessungenExtern      => AbmessungenExtern,
                                 PositionExtern         => GrafikRecordKonstanten.Nullposition,
                                 DurchsichtigkeitExtern => GrafikKonstanten.Hintergrundtransparents);
      
   end Hintergrund;
   
   
   
   procedure HintergrundNeu
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      HintergrundPositionierbarNeu (TexturAccessExtern     => TexturAccessExtern,
                                    TexturbereichExtern    => TexturbereichExtern,
                                    AbmessungenExtern      => AbmessungenExtern,
                                    PositionExtern         => GrafikRecordKonstanten.Nullposition,
                                    DurchsichtigkeitExtern => GrafikKonstanten.Hintergrundtransparents);
      
   end HintergrundNeu;
   
   
   
   procedure HintergrundPositionierbarNeu
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.HintergrundPositionierbarNeu: Hintergrund fehlt: " & TexturAccessExtern'Wide_Wide_Image);
         
      else
         Skalierung := TexturenskalierungGrafik.VariableSkalierung (TexturengrößeExtern     => (Sf.sfUint32 (TexturbereichExtern.width), Sf.sfUint32 (TexturbereichExtern.height)),
                                                                    BereichsabmessungExtern => AbmessungenExtern);
         
         KartenspritesZeichnenGrafik.SpriteZeichnen (TexturAccessExtern     => TexturAccessExtern,
                                                     TexturbereichExtern    => TexturbereichExtern,
                                                     PositionExtern         => PositionExtern,
                                                     SkalierungExtern       => Skalierung,
                                                     DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end HintergrundPositionierbarNeu;
   
   
   
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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.HintergrundPositionierbar: Hintergrund fehlt: " & HintergrundExtern'Wide_Wide_Image);
      
         -- Cyan Zeichnen lassen, um zu signalisieren dass hier etwas nicht stimmt.
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => PositionExtern,
                                                 FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
         
      else
         Skalierung := TexturenskalierungGrafik.TexturskalierungVariabel (SpriteAccessExtern  => HintergrundSpritePositionierbarAccess,
                                                                               TextureAccessExtern => EingeleseneTexturenGrafik.HintergrundAccess (HintergrundExtern),
                                                                               GrößeExtern         => AbmessungenExtern);
         Sf.Graphics.Sprite.setScale (sprite => HintergrundSpritePositionierbarAccess,
                                      scale  => Skalierung);
         
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, HintergrundExtern) = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.Spezieshintergrund: Hintergrund fehlt: " & SpeziesExtern'Wide_Wide_Image & " " & HintergrundExtern'Wide_Wide_Image);
      
         -- Cyan Zeichnen lassen, um zu signalisieren dass hier etwas nicht stimmt.
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                                 FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
         
      else
         Skalierung := TexturenskalierungGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpezieshintergrundSpriteAccess,
                                                                               TextureAccessExtern => EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, HintergrundExtern),
                                                                               GrößeExtern         => AbmessungenExtern);
         Sf.Graphics.Sprite.setScale (sprite => SpezieshintergrundSpriteAccess,
                                      scale  => Skalierung);
         
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
