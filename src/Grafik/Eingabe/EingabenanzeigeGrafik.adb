pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with Views;
with TextaccessVariablen;

with EinstellungenGrafik;
with EinheitenbeschreibungenGrafik;
with LeseEinheitenGebaut;
with TextberechnungenHoeheGrafik;
with InteraktionAuswahl;
with TextberechnungenBreiteGrafik;
with NachLogiktask;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with NachGrafiktask;
with AllgemeineViewsGrafik;
with TextfarbeGrafik;

package body EingabenanzeigeGrafik is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in GrafikDatentypen.Eingaben_Fragen_Enum)
   is begin
      
      AllgemeineViewsGrafik.Frage (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   FrageExtern       => To_Wide_Wide_String (Source => Meldungstexte.Frage (FrageExtern)));
      
      case
        EingabeExtern
      is
         when GrafikDatentypen.Text_Eingabe_Enum =>
            AnzeigeText;
            
         when GrafikDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeGanzeZahl;
            
         when GrafikDatentypen.Ja_Nein_Enum =>
            AnzeigeJaNein;
            
         when GrafikDatentypen.Zeichen_Eingabe_Enum =>
            null;
      end case;
      
   end Fragenaufteilung;
   
   

   procedure AnzeigeGanzeZahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      case
        NachGrafiktask.EingegebenesVorzeichen
      is
         when False =>
            Text := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => NachGrafiktask.EingegebeneZahl);
                              
         when True =>
            Text := ZahlAlsStringNatural (ZahlExtern => NachGrafiktask.EingegebeneZahl);       
      end case;
                                    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => 0.00);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
                  
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      -- Die Viewflächen auch in ein Array umwandeln?
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => 0.00);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeJaNein
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.JaNeinBereich.width, GrafikRecordKonstanten.JaNeinBereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.JaNeinBereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
            
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlZwei;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert,
                                                AuswahlExtern    => AktuelleAuswahl,
                                                TextaccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                       position => Textposition);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         
         InteraktionAuswahl.PositionenJaNein (TextSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeJaNein;
   
   
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Integer)
   is begin
      
      WelcheAuswahl := NachGrafiktask.WelcheAuswahl;
      
      case
        WelcheAuswahl.StadtEinheit
      is
         when True =>
            Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Stadtauswahlbereich.width, GrafikRecordKonstanten.Stadtauswahlbereich.height));
            
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtEinheitviewAccess,
                                                  GrößeExtern          => Viewfläche,
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Stadtauswahlbereich);
            
         when False =>
            Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Einheitauswahlbereich.width, GrafikRecordKonstanten.Einheitauswahlbereich.height));
            
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtEinheitviewAccess,
                                                  GrößeExtern          => Viewfläche,
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Einheitauswahlbereich);
      end case;
            
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugStadt);
                  
               when False =>
                  Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern,
                                                                                                                                                                                       WelcheAuswahl.MöglicheAuswahlen (0))),
                                                                                                                   RasseExtern => RasseExtern));
            end case;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => Text));
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                  str  => EinheitenbeschreibungenGrafik.BeschreibungKurz
                                                    (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert))),
                                                     RasseExtern => RasseExtern));
               
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
               
            end if;
         end if;
         
         if
           WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
         then
            null;
            
         else
            TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Natural (AuswahlSchleifenwert),
                                                   AuswahlExtern    => AktuelleAuswahlExtern,
                                                   TextaccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          position => Textposition);
            
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end if;
         
      end loop AuswahlSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
   end AnzeigeEinheitenStadt;

end EingabenanzeigeGrafik;
