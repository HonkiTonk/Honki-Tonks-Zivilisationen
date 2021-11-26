pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with GlobaleTexte;

with EingabeSFML;
with GrafikEinstellungen;
with GrafikAllgemein;

package body AnzeigeEingabe is

   procedure AnzeigeGanzeZahl
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 100.00));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfRed);
      
      GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 20.00, 100.00),
                                        PositionExtern  => (Sf.Graphics.Text.getPosition (text => TextAccess).x - 10.00, Sf.Graphics.Text.getPosition (text => TextAccess).y - 10.00),
                                        FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
            
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      
      WelchesVorzeichen := EingabeSFML.WelchesVorzeichen;
      AktuellerWert := EingabeSFML.AktuellerWert;
      
      case
        WelchesVorzeichen
      is
         when False =>
            AktuellerText := (To_Unbounded_Wide_Wide_String (Source => "-" & AktuellerWert'Wide_Wide_Image));
                              
         when True =>
            AktuellerText := (To_Unbounded_Wide_Wide_String (Source => AktuellerWert'Wide_Wide_Image));         
      end case;
                              
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 150.00));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
   end AnzeigeGanzeZahl;

end AnzeigeEingabe;
