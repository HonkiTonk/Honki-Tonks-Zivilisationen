with Sf.Graphics.Texture;

with Views;
with InteraktionAuswahl;
with EinheitenKonstanten;
with ViewKonstanten;
with GrafikKonstanten;

with LeseEinheitenDatenbank;

with ViewsEinstellenGrafik;
with TexturenSetzenSkalierenGrafik;
with EingeleseneTexturenGrafik;
with SpritesverwaltungssystemGrafik;
with TexturenberechnungenGrafik;

package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      RechtsLinksExtern : in Boolean)
   is begin
      
      Einheitart := LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => SpeziesExtern,
                                                         IDExtern      => IDExtern);
      
      case
        Einheitart
      is
         when EinheitenKonstanten.LeerEinheitArt =>
            return;
            
         when EinheitenDatentypen.Einmalig_Enum =>
            WelcherKnopf := BefehleDatentypen.Roter_Knopf_Enum;
            
         when others =>
            WelcherKnopf := BefehleDatentypen.Einheitenknöpfe_Enum;
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
      
      EinheitenViewfläche := Einheitenbefehlsknöpfe (EinheitenArtExtern => Einheitart,
                                                       WelcheTexturExtern => WelcherKnopf);
      
   end Einheitenbefehle;
   
   
   
   -- Für alle Einheittypen eine spezifische Anzeige einbauen? äöü
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      WelcheTexturExtern : in BefehleDatentypen.Befehlsknöpfe_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern)).y));
      
      TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                   TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern));
      SpritesverwaltungssystemGrafik.PositionZeichnen (SpriteAccessExtern => SpriteAccess,
                                                       PositionExtern     => GrafikRecordKonstanten.Nullposition);
         
      case
        EinheitenArtExtern
      is
         when EinheitenDatentypen.Einmalig_Enum =>
            InteraktionAuswahl.PositionenEinheitenbefehle := (others => (GrafikKonstanten.Nullwert, GrafikKonstanten.Nullwert, Texturgröße.x, Texturgröße.y));
            return Texturgröße;
            
         when others =>
            Teiler := GrafikKonstanten.Einswert;
            Knopffläche := TexturenberechnungenGrafik.Texturenfeld (TexturengrößeExtern => Texturgröße,
                                                                     TeilerExtern        => (3.00, 5.00));
      end case;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
            
         Knopfposition := TexturenberechnungenGrafik.TexturenbereichVariabel (TexturengrößeExtern => Texturgröße,
                                                                              TeilerExtern        => (3.00, 5.00),
                                                                              BereichnummerExtern => Teiler);
            
         InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := (Knopfposition.x, Knopfposition.y, Knopffläche.x, Knopffläche.y);
         
         Teiler := Teiler + 1.00;
         
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
      
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).y));
      
      TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                   TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum));
      SpritesverwaltungssystemGrafik.PositionZeichnen (SpriteAccessExtern => SpriteAccess,
                                                       PositionExtern     => GrafikRecordKonstanten.Nullposition);
      
      Teiler := GrafikKonstanten.Einswert;
      Knopffläche := TexturenberechnungenGrafik.Texturenfeld (TexturengrößeExtern => Texturgröße,
                                                               TeilerExtern        => (3.00, 4.00));
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
         
         Knopfposition := TexturenberechnungenGrafik.TexturenbereichVariabel (TexturengrößeExtern => Texturgröße,
                                                                              TeilerExtern        => (3.00, 4.00),
                                                                              BereichnummerExtern => Teiler);
            
         InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := (Knopfposition.x, Knopfposition.y, Knopffläche.x, Knopffläche.y);
         
         Teiler := Teiler + 1.00;
         
      end loop PositionenSchleife;
      
      return Texturgröße;
      
   end Kartenbefehlsknöpfe;

end WeltkartenbefehleGrafik;
