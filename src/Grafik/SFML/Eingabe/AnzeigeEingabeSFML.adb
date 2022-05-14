pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen;
with GlobaleTexte;
with TextKonstanten;

with EingabeSFML;
with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with EingabeSystemeSFML;
with EinheitenBeschreibungen;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with TextaccessVariablen;
with AllgemeineTextBerechnungenSFML;
with InteraktionGrafiktask;
with InteraktionAuswahl;

package body AnzeigeEingabeSFML is

   ------------------- Überarbeiten und dabei die Accesse auslagern.
   procedure AnzeigeGanzeZahl
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
      
      case
        SchriftartFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setFont (text => TextAccess,
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            SchriftartFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 100.00));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfRed);
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextAccess).x - 10.00, Sf.Graphics.Text.getPosition (text => TextAccess).y - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      
      WelchesVorzeichen := EingabeSFML.WelchesVorzeichen;
      AktuellerWert := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
      
      case
        WelchesVorzeichen
      is
         when False =>
            AktuellerText := To_Unbounded_Wide_Wide_String (Source => "-") & AktuellerWert;
                              
         when True =>
            AktuellerText := AktuellerWert;         
      end case;
                              
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 150.00));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
      
      case
        SchriftartFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setFont (text => TextAccess,
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            SchriftartFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 100.00));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfRed);
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextAccess).x - 10.00, Sf.Graphics.Text.getPosition (text => TextAccess).y - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => EingabeSystemeSFML.EingegebenerText));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 150.00));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setFont (text => TextAccess,
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            SchriftartFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      AktuelleAuswahl := AuswahlStadtEinheit.AktuelleAuswahl;
      WelcheAuswahl := AuswahlStadtEinheit.WelcheAuswahl;
      TextPosition := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugStadt))
                                                     & To_Wide_Wide_String (Source => LeseStadtGebaut.Name
                                                                            ---------------------- Übergangslösung bis hier alles mal neu geschrieben wird. Gilt auch für die Konvertierungen weiter unten.
                                                                            ---------------------- Siehe auch AuswahlStadtEinheit
                                                                              (StadtRasseNummerExtern => (RasseExtern, StadtDatentypen.MaximaleStädteMitNullWert (WelcheAuswahl.MöglicheAuswahlen (0))))));
                  
               when False =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
            end case;
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => EinheitenBeschreibungen.BeschreibungKurz
                                                    (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert)))));
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
               Sf.Graphics.Text.setColor (text  => TextAccess,
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
         
            else
               Sf.Graphics.Text.setColor (text  => TextAccess,
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            end if;
            
            Sf.Graphics.Text.setPosition (text     => TextAccess,
                                          position => (TextPosition.x - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00, TextPosition.y));
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextAccess);
            TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
            
   end AnzeigeEinheitenStadt;
   
   
   
   procedure AnzeigeJaNein
   is begin
      
      WelcheFrage := InteraktionGrafiktask.JaNeinFrage;
      
      case
        WelcheFrage
      is
         when 0 =>
            return;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (1),
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
            Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      end case;
      
      TextPosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (1)), AllgemeineTextBerechnungenSFML.HalbeBildschirmhöhe);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (1),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.JaNeinAccess (1)).height + 3.00 * Zeilenabstand;
      TextPosition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (2));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (2),
                                    position => TextPosition);
      
      InteraktionAuswahl.PositionenJaNein (1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (2));
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.JaNeinAccess (2)).height + 3.00 * Zeilenabstand;
      TextPosition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (3));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (3),
                                    position => TextPosition);
      
      InteraktionAuswahl.PositionenJaNein (2) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (3));
      
      ------------------------ Das ganze Draw Zeug mal auslagern.
      TextAnzeigenSchleife:
      for TextAnzeigenSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextAnzeigenSchleifenwert));
         
      end loop TextAnzeigenSchleife;
      
   end AnzeigeJaNein;

end AnzeigeEingabeSFML;
