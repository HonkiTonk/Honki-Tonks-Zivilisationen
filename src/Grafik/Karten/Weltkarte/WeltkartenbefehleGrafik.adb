pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Texture;

with EinheitenDatentypen; use EinheitenDatentypen;
with Views;
with InteraktionAuswahl;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with ViewsEinstellenGrafik;
with KartenspritesZeichnenGrafik;
with TexturenSetzenSkalierenGrafik;
with EingeleseneTexturenGrafik;

package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      RechtsLinksExtern : in Boolean)
   is begin
      
      Einheitart := LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        Einheitart
      is
         when EinheitenKonstanten.LeerEinheitArt =>
            return;
            
         when EinheitenDatentypen.PZB_Enum'Range =>
            WelcherKnopf := BefehleDatentypen.Roter_Knopf_Enum;
            
         when others =>
            WelcherKnopf := BefehleDatentypen.Einheitenknöpfe_Enum;
      end case;
      
      case
        RechtsLinksExtern
      is
         when True =>
            WelcherViewbereich := 1;
            
         when False =>
            WelcherViewbereich := 2;
      end case;
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => EinheitenViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Einheitenbefehlsbereich (WelcherViewbereich));
      
      EinheitenViewfläche := Einheitenbefehlsknöpfe (EinheitenArtExtern => Einheitart,
                                                       WelcheTexturExtern => WelcherKnopf);
      
   end Einheitenbefehle;
   
   
   
   -- Für alle Einheittypen eine spezifische Anzeige einbinden? äöü
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      WelcheTexturExtern : in BefehleDatentypen.Befehlsknöpfe_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern)).y));
      
      TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                   TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (WelcheTexturExtern));
      KartenspritesZeichnenGrafik.BefehlsknöpfespriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                                PositionExtern    => (0.00, 0.00));
      
      Teiler := 1;
      Textbox.width := Texturgröße.x / 3.00;
      Textbox.height := Texturgröße.y / 5.00;
      Multiplikator := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         if
           EinheitenArtExtern in EinheitenDatentypen.PZB_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle := (others => (0.00, 0.00, Texturgröße.x, Texturgröße.y));
            exit PositionenSchleife;
            
         else
            if
              Teiler mod 2 = 0
            then
               Knopfposition.x := Textbox.width;
               Knopfposition.y := Textbox.height * Multiplikator;
               
            elsif
              Teiler mod 3 = 0
            then
               Knopfposition.x := 2.00 * Textbox.width;
               Knopfposition.y := Textbox.height * Multiplikator;
                  
            else
               Knopfposition.x := 0.00;
               Knopfposition.y := Textbox.height * Multiplikator;
            end if;
            
            Textbox.left := Knopfposition.x;
            Textbox.top := Knopfposition.y;
            
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := Textbox;
         end if;
         
         case
           Teiler
         is
            when 1 .. 2 =>
               Teiler := Teiler + 1;
               
            when others =>
               Teiler := 1;
               Multiplikator := Multiplikator + 1.00;
         end case;
         
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
            WelcherViewbereich := 1;
            
         when False =>
            WelcherViewbereich := 2;
      end case;
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => KartenbefehleViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Kartenbefehlsbereich (WelcherViewbereich));
      
      KartenbefehleViewfläche := Kartenbefehlsknöpfe;
      
   end Kartenbefehle;
   
   
   
   function Kartenbefehlsknöpfe
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).y));
      
      TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                   TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum));
      KartenspritesZeichnenGrafik.BefehlsknöpfespriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                                PositionExtern    => (0.00, 0.00));
      
      Teiler := 1;
      Multiplikator := 0.00;
      Textbox.width := Texturgröße.x / 3.00;
      Textbox.height := Texturgröße.y / 4.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
         
         if
           Teiler mod 2 = 0
         then
            Knopfposition.x := Textbox.width;
            Knopfposition.y := Textbox.height * Multiplikator;
               
         elsif
           Teiler mod 3 = 0
         then
            Knopfposition.x := 2.00 * Textbox.width;
            Knopfposition.y := Textbox.height * Multiplikator;
                  
         else
            Knopfposition.x := 0.00;
            Knopfposition.y := Textbox.height * Multiplikator;
         end if;
            
         Textbox.left := Knopfposition.x;
         Textbox.top := Knopfposition.y;
            
         InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := Textbox;
         
         case
           Teiler
         is
            when 1 .. 2 =>
               Teiler := Teiler + 1;
               
            when others =>
               Teiler := 1;
               Multiplikator := Multiplikator + 1.00;
         end case;
         
      end loop PositionenSchleife;
      
      return Texturgröße;
      
   end Kartenbefehlsknöpfe;

end WeltkartenbefehleGrafik;
