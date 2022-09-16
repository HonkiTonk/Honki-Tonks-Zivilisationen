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
with BefehleDatentypen;
with EinheitenKonstanten;
with TastenbelegungDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with EinheitenAllgemeinesLogik;
with KartenspritesZeichnenGrafik;
with TexturenSetzenSkalierenGrafik;
with EingeleseneTexturenGrafik;

package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => EinheitenViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Einheitenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen? äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => EinheitenViewfläche);
      
      case
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden
      is
         when False =>
            null;
            
         when True =>
            Einheitenbefehlsknöpfe (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
      end case;
      
      -- Später nicht nur auf Kampfeinheit abfragen sondern direkt auf die Einheitenart und dementsprechend die Knöpfe festlegen. äöü
      -- Ist wichtig für die speziellen Einheiten. äöü
      Kampfeinheit := EinheitenAllgemeinesLogik.Kampfeinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      Aktuelleposition := AnfangEinheitenbefehle;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         if
           Kampfeinheit
           and
             PositionSchleifenwert in BefehleDatentypen.Siedler_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
         elsif
           (Kampfeinheit = False)
           and
             PositionSchleifenwert in BefehleDatentypen.Kampf_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
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

      EinheitenViewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheitenbefehle;
   
   
   
   procedure Einheitenbefehlsknöpfe
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Später nicht nur auf Kampfeinheit abfragen sondern direkt auf die Einheitenart und dementsprechend die Knöpfe festlegen. äöü
      -- Ist wichtig für die speziellen Einheiten. äöü
      Einheitart := LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        Einheitart
      is
         when EinheitenKonstanten.LeerEinheitArt | EinheitenDatentypen.Cheat_Enum =>
            return;
            
         when others =>
            -- Ist das so überhaupt brauchbar? Wenn ich die Auflösung ändere ändert sich ja auch die Größe, oder?
            Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Einheitenknöpfe_Enum)).x),
                              Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Einheitenknöpfe_Enum)).y));
      
            TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                         TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Einheitenknöpfe_Enum));
            KartenspritesZeichnenGrafik.BefehlsknöpfespriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                                      PositionExtern    => (0.00, 0.00));
      end case;
      
      Aktuelleposition := 1;
      Teiler := 1;
      Textbox.width := Texturgröße.x / 3.00;
      Textbox.height := Texturgröße.y / 5.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         if
           Einheitart /= EinheitenDatentypen.Arbeiter_Enum
           and
             PositionSchleifenwert in BefehleDatentypen.Siedler_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
         elsif
           Einheitart not in Einheitenart_Kampf_Enum'Range
           and
             PositionSchleifenwert in BefehleDatentypen.Kampf_Aufgaben_Enum'Range
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
         elsif
           Einheitart = EinheitenDatentypen.PZB_Enum
         then
            null;
            
         else
            if
              Teiler mod 2 = 0
            then
               Knopfposition.x := Textbox.width;
               Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition - 2) / 2.00);
               
            elsif
              Teiler mod 3 = 0
            then
               Knopfposition.x := 2.00 * Textbox.width;
               Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition - 3) / 2.00);
                  
            else
               Knopfposition.x := 0.00;
               Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition - 1) / 2.00);
            end if;
            
            Textbox.left := Knopfposition.x;
            Textbox.top := Knopfposition.y;
            
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := Textbox;
         end if;
         
         Aktuelleposition := Aktuelleposition + 1;
         
         if
           Teiler >= 3
         then
            Teiler := 1;
            
         else
            Teiler := Teiler + 1;
         end if;
         
      end loop PositionenSchleife;

      EinheitenViewfläche := Texturgröße;
      
   end Einheitenbefehlsknöpfe;
   
   

   procedure Kartenbefehle
   is begin
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => KartenbefehleViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Kartenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen? äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => KartenbefehleViewfläche);
      
      case
        EinstellungenGrafik.Grafikeinstellungen.TexturenVerwenden
      is
         when False =>
            null;
            
         when True =>
            Kartenbefehlsknöpfe;
            return;
      end case;
      
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

      KartenbefehleViewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Kartenbefehle;
   
   
   
   procedure Kartenbefehlsknöpfe
   is begin
      
      Texturgröße := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum)).y));
      
      TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                   TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Kartenknöpfe_Enum));
      KartenspritesZeichnenGrafik.BefehlsknöpfespriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                                PositionExtern    => (0.00, 0.00));
      
      Aktuelleposition := AnfangKartenbefehle;
      Teiler := 1;
      Textbox.width := Texturgröße.x / 3.00;
      Textbox.height := Texturgröße.y / 4.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
         
         case
           PositionSchleifenwert
         is
            when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
               null;
               
            when others =>
               if
                 Teiler mod 2 = 0
               then
                  Knopfposition.x := Textbox.width;
                  Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition - AnfangKartenbefehle) / 2.00);
               
               elsif
                 Teiler mod 3 = 0
               then
                  Knopfposition.x := 2.00 * Textbox.width;
                  Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition - 1 - AnfangKartenbefehle) / 2.00);
                  
               else
                  Knopfposition.x := 0.00;
                  Knopfposition.y := Textbox.height * Float'Floor (Float (Aktuelleposition + 1 - AnfangKartenbefehle) / 2.00);
               end if;
            
               Textbox.left := Knopfposition.x;
               Textbox.top := Knopfposition.y;
            
               InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := Textbox;
         end case;
         
         Aktuelleposition := Aktuelleposition + 1;
         
         if
           Teiler = 3
         then
            Teiler := 1;
            
         else
            Teiler := Teiler + 1;
         end if;
         
      end loop PositionenSchleife;
      
      KartenbefehleViewfläche := Texturgröße;
      
   end Kartenbefehlsknöpfe;

end WeltkartenbefehleGrafik;
