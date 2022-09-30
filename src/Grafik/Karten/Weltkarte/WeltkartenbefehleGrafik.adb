pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Texture;

with EinheitenDatentypen; use EinheitenDatentypen;
with Views;
with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;
with EinheitenKonstanten;
with TastenbelegungDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with KartenspritesZeichnenGrafik;
with TexturenSetzenSkalierenGrafik;
with EingeleseneTexturenGrafik;

package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => EinheitenViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Einheitenbefehlsbereich);
      
      case
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden
      is
         when False =>
            EinheitenViewfläche := Einheitenbefehlstexte (EinheitenArtExtern => Einheitart);
            
         when True =>
            EinheitenViewfläche := Einheitenbefehlsknöpfe (EinheitenArtExtern => Einheitart,
                                                             WelcheTexturExtern => WelcherKnopf);
      end case;
      
   end Einheitenbefehle;
   
   
   
   function Einheitenbefehlstexte
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen? äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => EinheitenViewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      Aktuelleposition := AnfangEinheitenbefehle;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         if
           EinheitenArtExtern /= EinheitenDatentypen.Arbeiter_Enum
           and
             PositionSchleifenwert in BefehleDatentypen.Siedler_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
         elsif
           EinheitenArtExtern not in Einheitenart_Kampf_Enum'Range
           and
             PositionSchleifenwert in BefehleDatentypen.Kampf_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
         
            -- elsif
            --   EinheitenArtExtern = EinheitenDatentypen.PZB_Enum'Range
            -- then
            -- Noch einen roten Knopf für die Textvariante einbauen. äöü
            
         else
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                                    ViewbreiteExtern => EinheitenViewfläche.x);
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                          position => Textposition);
         
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                                TextbreiteExtern => Textbreite);
                  
            Textbox := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition));
            Textbox.left := 0.00;
            Textbox.width := EinheitenViewfläche.x;
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := Textbox;
         
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition));
         end if;
         
         Aktuelleposition := Aktuelleposition + 1;
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheitenbefehlstexte;
   
   
   
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
   is begin
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => KartenbefehleViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Kartenbefehlsbereich);
      
      case
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden
      is
         when False =>
            KartenbefehleViewfläche := Kartenbefehlstexte;
            
         when True =>
            KartenbefehleViewfläche := Kartenbefehlsknöpfe;
      end case;
      
   end Kartenbefehle;
   
   
   
   function Kartenbefehlstexte
     return Sf.System.Vector2.sfVector2f
   is begin
            
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen? äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => KartenbefehleViewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      Aktuelleposition := AnfangKartenbefehle;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
         
         case
           PositionSchleifenwert
         is
            when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
               null;
               
            when others =>
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                                       ViewbreiteExtern => KartenbefehleViewfläche.x);
         
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                             position => Textposition);
         
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                                   TextbreiteExtern => Textbreite);
         
               Textbox := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition));
               Textbox.left := 0.00;
               Textbox.width := KartenbefehleViewfläche.x;
               InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := Textbox;
         
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.SteuerungSFMLAccess (Aktuelleposition));
         end case;
         
         Aktuelleposition := Aktuelleposition + 1;
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Kartenbefehlstexte;
   
   
   
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
