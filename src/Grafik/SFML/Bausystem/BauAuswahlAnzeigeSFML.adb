pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with TextKonstanten;

with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with AllgemeineTextBerechnungenSFML;
with Fehler;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
   is begin
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
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
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                               size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
            SchriftgrößeFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            SchriftfarbeFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      TextPosition := StartPositionText;
      Ende := InDerStadtBauen.Ende;
      AktuelleAuswahl := InDerStadtBauen.AktuelleAuswahl;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageBauprojekt)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess), StartPositionText.y));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      AbstandÜberschrift := TextPosition.y;
        
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      Bauliste := InDerStadtBauen.Bauliste;
      
      AnzeigeSchleife:
      for BaulisteSchleifenwert in Bauliste'First .. Ende loop
         
         if
           AktuelleAuswahl = BaulisteSchleifenwert
         then
            WeiterenTextAnzeigen (WelcherTextExtern => Bauliste (BaulisteSchleifenwert));
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
            
         else
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         end if;
         
         WelcherTextKurz := 2 * Natural (Bauliste (BaulisteSchleifenwert).Nummer) - 1;
         
         case
           Bauliste (BaulisteSchleifenwert).GebäudeEinheit
         is
            when True =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (WelcherTextKurz)));
               
            when False =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (WelcherTextKurz)));
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => TextPosition);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess);
         
         TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
                           
      end loop AnzeigeSchleife;
      
   end BauAuswahlAnzeige;
   
   
   
   procedure WeiterenTextAnzeigen
     (WelcherTextExtern : in EinheitStadtRecords.BauprojektRecord)
   is begin
      
      WelcherTextLang := 2 * Natural (WelcherTextExtern.Nummer);
      
      case
        WelcherTextExtern.GebäudeEinheit
      is
         when True =>
            if
              WelcherTextLang > GlobaleTexte.Gebäude'Last
            then
               Fehler.GrafikFehler (FehlermeldungExtern => "BauAuswahlAnzeigeSFML.WeiterenTextAnzeigen - Gebäude ist außerhalb der Liste.");
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (WelcherTextLang)));
            end if;
            
         when False =>
            if
              WelcherTextLang > GlobaleTexte.Einheiten'Last
            then
               Fehler.GrafikFehler (FehlermeldungExtern => "BauAuswahlAnzeigeSFML.WeiterenTextAnzeigen - Einheit ist außerhalb der Liste.");
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (WelcherTextLang)));
            end if;
      end case;
      
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end WeiterenTextAnzeigen;

end BauAuswahlAnzeigeSFML;
