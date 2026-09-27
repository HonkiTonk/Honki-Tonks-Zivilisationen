with Sf.Graphics.Texture;

with Views;
with InteraktionAuswahl;
with EinheitenKonstanten;
with ViewKonstanten;
with GrafikKonstanten;
with TexturenfelderVariablenGrafik;

with ViewsEinstellenGrafik;
with EingeleseneTexturenGrafik;
with SpritesverwaltungssystemGrafik;

package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (EinheitartExtern : in EinheitenDatentypen.Einheitart_Enum;
      RechtsLinksExtern : in Boolean)
   is begin
            
      case
        EinheitartExtern
      is
         when EinheitenKonstanten.LeerEinheitArt =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        RechtsLinksExtern
      is
         when True =>
            WelcherViewbereich := ViewKonstanten.WeltEinheitenbefehleRechts;
            
         when False =>
            WelcherViewbereich := ViewKonstanten.WeltEinheitenbefehleLinks;
      end case;
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => EinheitenViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (WelcherViewbereich));
      
      EinheitenViewfläche := Einheitenbefehlsknöpfe (EinheitenArtExtern => EinheitartExtern);
      
   end Einheitenbefehle;
   
   
   
   -- Für alle Einheittypen eine spezifische Anzeige einbauen. äöü
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.EinheitenbefehleAccess).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.EinheitenbefehleAccess).y));
      
      SpritesverwaltungssystemGrafik.Setzen (SpriteAccessExtern  => SpriteAccess,
                                             TextureAccessExtern => EingeleseneTexturenGrafik.EinheitenbefehleAccess);
      SpritesverwaltungssystemGrafik.PositionZeichnen (SpriteAccessExtern => SpriteAccess,
                                                       PositionExtern     => GrafikRecordKonstanten.Nullposition);
         
      case
        EinheitenArtExtern
      is
         when EinheitenDatentypen.Einmalig_Enum =>
            InteraktionAuswahl.PositionenEinheitenbefehle := (others => (GrafikKonstanten.Nullwert, GrafikKonstanten.Nullwert, Texturgröße.x, Texturgröße.y));
            return Texturgröße;
            
         when others =>
            null;
      end case;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
        
         Rechteck := TexturenfelderVariablenGrafik.EinheitenbefehleRechteck (BefehlExtern => PositionSchleifenwert);
         
         InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := (Float (Rechteck.left), Float (Rechteck.top), Float (Rechteck.width), Float (Rechteck.height));
         
      end loop PositionenSchleife;

      return Texturgröße;
      
   end Einheitenbefehlsknöpfe;
   
   

   procedure Kartenbefehle
     (RechtsLinksExtern : in Boolean)
   is begin
      
      case
        RechtsLinksExtern
      is
         when True =>
            WelcherViewbereich := ViewKonstanten.WeltBefehleRechts;
            
         when False =>
            WelcherViewbereich := ViewKonstanten.WeltBefehleLinks;
      end case;
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => KartenbefehleViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (WelcherViewbereich));
      
      KartenbefehleViewfläche := Kartenbefehlsknöpfe;
      
   end Kartenbefehle;
   
   
   
   function Kartenbefehlsknöpfe
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenbefehleAccess).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenbefehleAccess).y));
      
      SpritesverwaltungssystemGrafik.Setzen (SpriteAccessExtern  => SpriteAccess,
                                             TextureAccessExtern => EingeleseneTexturenGrafik.KartenbefehleAccess);
      SpritesverwaltungssystemGrafik.PositionZeichnen (SpriteAccessExtern => SpriteAccess,
                                                       PositionExtern     => GrafikRecordKonstanten.Nullposition);
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
        
         Rechteck := TexturenfelderVariablenGrafik.KartenbefehleRechteck (BefehlExtern => PositionSchleifenwert);
         
         InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := (Float (Rechteck.left), Float (Rechteck.top), Float (Rechteck.width), Float (Rechteck.height));
         
      end loop PositionenSchleife;
      
      return Texturgröße;
      
   end Kartenbefehlsknöpfe;

end WeltkartenbefehleGrafik;
