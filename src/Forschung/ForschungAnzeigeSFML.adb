pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;

with GrafikTextAllgemein;
with GrafikEinstellungen;
with ObjekteZeichnenSFML;
with AllgemeineTextBerechnungenSFML;

package body ForschungAnzeigeSFML is

   procedure ForschungAnzeige
   is begin
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x), Float ( GrafikEinstellungen.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontExtern         => GrafikEinstellungen.Schriftart,
                                                SchriftgrößeExtern => 2 * GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeÜberschrift);
      
      TextPosition := StartPositionText;
      Ende := ForschungAllgemein.Ende;
      AktuelleAuswahl := ForschungAllgemein.AktuelleAuswahl;
      ForschungText := ForschungAllgemein.ForschungText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (12)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess), StartPositionText.y));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      AbstandÜberschrift := TextPosition.y;
        
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungText'First .. Ende loop
         
         if
           AktuelleAuswahl = ForschungSchleifenwert
         then
            WeiterenTextAnzeigen (WelcherTextExtern => ForschungText (ForschungSchleifenwert).Nummer);
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                        color => GrafikEinstellungen.Schriftfarben.FarbeAusgewähltText);
            
         else
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                       color => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
         end if;
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => To_Wide_Wide_String (Source => ForschungText (ForschungSchleifenwert).Text));
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => TextPosition);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => TextAccess);
         
         TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
                           
      end loop AnzeigeSchleife;
      
   end ForschungAnzeige;
   
   
   
   procedure WeiterenTextAnzeigen
     (WelcherTextExtern : in Natural)
   is begin
            
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      
      if
        WelcherTextExtern < 1
      then
         WelcherText := GlobaleTexte.Forschungen'Last;
         
      else
         WelcherText := 2 * WelcherTextExtern;
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (WelcherText)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
   end WeiterenTextAnzeigen;

end ForschungAnzeigeSFML;
