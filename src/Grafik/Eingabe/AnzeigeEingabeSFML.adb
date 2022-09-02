pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with GrafikDatentypen;
with Views;
with GrafikRecordKonstanten;
with TextaccessVariablen;

with EingabeSFML;
with GrafikEinstellungenSFML;
with EinheitenbeschreibungenSFML;
with LeseEinheitenGebaut;
with TextberechnungenHoeheSFML;
with InteraktionAuswahl;
with TextberechnungenBreiteSFML;
with NachLogiktask;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with NachGrafiktask;
with AllgemeineViewsSFML;

package body AnzeigeEingabeSFML is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in SystemDatentypen.Eingaben_Fragen_Enum)
   is begin
      
      AllgemeineViewsSFML.Frage (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                 FrageExtern       => To_Wide_Wide_String (Source => Meldungstexte.Frage (FrageExtern)));
      
      case
        EingabeExtern
      is
         when SystemDatentypen.Text_Eingabe_Enum =>
            AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeGanzeZahl;
            
         when SystemDatentypen.Ja_Nein_Enum =>
            AnzeigeJaNein;
            
         when SystemDatentypen.Zeichen_Eingabe_Enum =>
            null;
      end case;
      
   end Fragenaufteilung;
   
   

   procedure AnzeigeGanzeZahl
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.50, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      case
        EingabeSFML.WelchesVorzeichen
      is
         when False =>
            Text := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
                              
         when True =>
            Text := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);       
      end case;
                                    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                        TextbreiteExtern => 0.00);
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                            ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
                  
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      -- Die Viewflächen auch in ein Array umwandeln?
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess).height);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
            
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.50, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText));
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                        TextbreiteExtern => 0.00);
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                            ViewbreiteExtern => Viewfläche.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess).height);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeJaNein
   is begin
            
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.50, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (2),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.JaNeinBereich);
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
            
      Textbreite := 0.00;
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlZwei;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         if
           AktuelleAuswahl = TextSchleifenwert
         then
            Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
               
         else
            Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
         end if;
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                    color => Farbe);
         
         Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                               ViewbreiteExtern => Viewfläche.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                       position => Textposition);
         
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         InteraktionAuswahl.PositionenJaNein (TextSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (TextaccessVariablen.JaNeinAccess'Last)).height);
      
   end AnzeigeJaNein;
   
   
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier auch noch eine Frage einbauen? äöü
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => (0.25, 0.45, 0.50, 0.10));
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlEins;
      WelcheAuswahl := NachGrafiktask.WelcheAuswahl;
      
      Textposition.y := TextKonstanten.StartpositionText.y;
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
                  Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern,
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
                                                  str  => EinheitenbeschreibungenSFML.BeschreibungKurz
                                                    (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert))),
                                                     RasseExtern => RasseExtern));
               
               Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                 TextbreiteExtern => Textbreite);
               
            end if;
         end if;
         
         if
           WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert (StadtDatentypen.MaximaleStädteMitNullWert'First)
         then
            null;
            
         else
            if
              AktuelleAuswahl = Natural (AuswahlSchleifenwert)
            then
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
         
            else
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
            end if;
            
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                       color => Farbe);
            
            Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                  ViewbreiteExtern => Viewfläche.x);
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          position => Textposition);
            
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                              TextbreiteExtern => Textbreite);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert);
            
   end AnzeigeEinheitenStadt;

end AnzeigeEingabeSFML;
