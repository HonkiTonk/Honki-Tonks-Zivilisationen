with GrafikKonstanten;
with GrafikRecordKonstanten;

with LeseGrafiktask;

with EingeleseneTexturenGrafik;
with TexturenskalierungGrafik;
with Fehlermeldungssystem;
with ObjekteZeichnenGrafik;
with SpritesverwaltungssystemGrafik;
with KartenspritesZeichnenGrafik;
with TexturenfelderVariablenGrafik;

package body HintergrundGrafik is
   
   procedure Aufteilung
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        HintergrundExtern
      is
         when GrafikDatentypen.Hintergrund_Intro_Enum'Range =>
            Hintergrund (TexturAccessExtern  => EingeleseneTexturenGrafik.IntroAccess,
                         TexturbereichExtern => TexturenfelderVariablenGrafik.AllgemeinesRechteck (HintergrundExtern => HintergrundExtern,
                                                                                                   SpeziesExtern     => SpeziesDatentypen.Leer_Spezies_Enum),
                         AbmessungenExtern   => AbmessungenExtern,
                         HintergrundExtern   => HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Kartenformen_Enum'Range =>
            Hintergrund (TexturAccessExtern  => EingeleseneTexturenGrafik.KartenformenAccess,
                         TexturbereichExtern => TexturenfelderVariablenGrafik.AllgemeinesRechteck (HintergrundExtern => HintergrundExtern,
                                                                                                   SpeziesExtern     => SpeziesDatentypen.Leer_Spezies_Enum),
                         AbmessungenExtern   => AbmessungenExtern,
                         HintergrundExtern   => HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Einheitenbefehle_Enum'Range =>
            null;
            
         when GrafikDatentypen.Hintergrund_Anzeige_Enum'Range =>
            Hintergrund (TexturAccessExtern  => EingeleseneTexturenGrafik.AllgemeinesAccess,
                         TexturbereichExtern => TexturenfelderVariablenGrafik.AllgemeinesRechteck (HintergrundExtern => HintergrundExtern,
                                                                                                   SpeziesExtern     => SpeziesDatentypen.Leer_Spezies_Enum),
                         AbmessungenExtern   => AbmessungenExtern,
                         HintergrundExtern   => HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Spezienspezifisch_Anzeige_Enum'Range =>
            AktuelleSpezies := LeseGrafiktask.AktiveSpezies;
            
            if
              AktuelleSpezies = SpeziesDatentypen.Leer_Spezies_Enum
            then
               return;
               
            else
               Hintergrund (TexturAccessExtern  => EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (AktuelleSpezies),
                            TexturbereichExtern => TexturenfelderVariablenGrafik.AllgemeinesRechteck (HintergrundExtern => HintergrundExtern,
                                                                                                      SpeziesExtern     => AktuelleSpezies),
                            AbmessungenExtern   => AbmessungenExtern,
                            HintergrundExtern   => HintergrundExtern);
            end if;
            
         when GrafikDatentypen.Hintergrund_Outro_Enum'Range =>
            null;
      end case;
      
   end Aufteilung;
   
   
   
   procedure Hintergrund
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum)
   is begin
      
      case
        HintergrundExtern
      is
         when GrafikDatentypen.Hintergrund_Anzeige_Durchsichtig_Enum'Range =>
            HintergrundPositionierbar (TexturAccessExtern     => TexturAccessExtern,
                                       TexturbereichExtern    => TexturbereichExtern,
                                       AbmessungenExtern      => AbmessungenExtern,
                                       PositionExtern         => GrafikRecordKonstanten.Nullposition,
                                       DurchsichtigkeitExtern => GrafikKonstanten.Hintergrundtransparents);
            
         when others =>
            HintergrundPositionierbar (TexturAccessExtern     => TexturAccessExtern,
                                       TexturbereichExtern    => TexturbereichExtern,
                                       AbmessungenExtern      => AbmessungenExtern,
                                       PositionExtern         => GrafikRecordKonstanten.Nullposition,
                                       DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
      
   end Hintergrund;
   
   
   
   procedure HintergrundPositionierbar
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
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "HintergrundGrafik.HintergrundPositionierbar: Hintergrund fehlt: " & TexturAccessExtern'Wide_Wide_Image);
         
         -- Zeichnen lassen, um zu signalisieren dass hier etwas nicht stimmt.
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                                 FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
         
      else
         Skalierung := TexturenskalierungGrafik.VariableSkalierung (TexturengrößeExtern     => (Sf.sfUint32 (TexturbereichExtern.width), Sf.sfUint32 (TexturbereichExtern.height)),
                                                                    BereichsabmessungExtern => AbmessungenExtern);
         
         KartenspritesZeichnenGrafik.SpriteZeichnen (TexturAccessExtern     => TexturAccessExtern,
                                                     TexturbereichExtern    => TexturbereichExtern,
                                                     PositionExtern         => PositionExtern,
                                                     SkalierungExtern       => Skalierung,
                                                     DurchsichtigkeitExtern => DurchsichtigkeitExtern);
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
