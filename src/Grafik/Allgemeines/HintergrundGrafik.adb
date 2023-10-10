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
      
         -- Cyan Zeichnen lassen, um zu signalisieren dass hier etwas nicht stimmt.
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => PositionExtern,
                                                 FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
         
      else
         Skalierung := TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => HintergrundSpritePositionierbarAccess,
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
      
         -- Cyan Zeichnen lassen, um zu signalisieren dass hier etwas nicht stimmt.
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => AbmessungenExtern,
                                                 PositionExtern  => GrafikRecordKonstanten.Nullposition,
                                                 FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
         
      else
         Skalierung := TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpezieshintergrundSpriteAccess,
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
