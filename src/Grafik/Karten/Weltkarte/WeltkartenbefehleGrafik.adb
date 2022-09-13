pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with EinheitenAllgemeinesLogik;

-- Zwei Viewflächen anlegen? Wäre das eventuell sinnvoll bei späteren Doppelaufrufen? äöü
package body WeltkartenbefehleGrafik is
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- EinheitenViewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => EinheitenViewfläche,
      --                                                                           VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EinheitenbefehlsviewAccess,
                                            GrößeExtern          => EinheitenViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Einheitenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen. äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => EinheitenViewfläche);
      
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
             Aktuelleposition in 2 .. 8
         then
            InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
            
         elsif
           Kampfeinheit = False
           and
             Aktuelleposition = 11
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
   
   

   procedure Kartenbefehle
   is begin
      
      -- KartenbefehleViewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => KartenbefehleViewfläche,
      --                                                                                VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenbefehlsviewAccess,
                                            GrößeExtern          => KartenbefehleViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Kartenbefehlsbereich);
      
      -- Für die Anzeige noch einen eigenen Hintergrund einbauen. äöü
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => KartenbefehleViewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      Aktuelleposition := AnfangKartenbefehle;
      
      PositionenSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
         
         if
           Aktuelleposition = 24
         then
            InteraktionAuswahl.PositionenKartenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
               
         else
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
         end if;
         
         Aktuelleposition := Aktuelleposition + 1;
         
      end loop PositionenSchleife;

      KartenbefehleViewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Kartenbefehle;

end WeltkartenbefehleGrafik;
