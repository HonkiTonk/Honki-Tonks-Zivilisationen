pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with TextKonstanten;
with GlobaleTexte;
-- with ForschungKonstanten;

with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with AllgemeineTextBerechnungenSFML;
with ForschungAllgemein;
with InteraktionAuswahl;

package body ForschungAnzeigeSFML is

   procedure ForschungAnzeige
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößenFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbenFestlegen;
            
         when True =>
            null;
      end case;

      if
        TextFestgelegt = False
        or
          NeuerAufruf /= ForschungAllgemein.NeuerAufruf
      then
         TextFestgelegt := TextFestlegen;
         NeuerAufruf := ForschungAllgemein.NeuerAufruf;
            
      else
         null;
      end if;
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      TextPosition := StartPositionText;
      AktuelleAuswahl := ForschungAllgemein.AktuelleAuswahl;
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (1),
                                    position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (1)), StartPositionText.y));
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (1)).height + 10.00 * Zeilenabstand;
      AbstandÜberschrift := TextPosition.y;
      
      AnzeigeSchleife:
      for ForschungSchleifenwert in EinheitStadtDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl = ForschungSchleifenwert
               then
                  Sf.Graphics.Text.setColor (text  => TextAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
            
               else
                  Sf.Graphics.Text.setColor (text  => TextAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
         
               Sf.Graphics.Text.setPosition (text     => TextAccess (ForschungSchleifenwert),
                                             position => TextPosition);
         
               TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (ForschungSchleifenwert)).height + 3.00 * Zeilenabstand;
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (ForschungSchleifenwert));

            when False =>
               null;
         end case;
               
      end loop AnzeigeSchleife;
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
         
         if
           TextSchleifenwert = 0
           or else
             InteraktionAuswahl.MöglicheForschungen (TextSchleifenwert) = True
         then
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextAccess (TextSchleifenwert));

         else
            null;
         end if;
         
      end loop TextSchleife;
      
   end ForschungAnzeige;
   
   
   
   procedure WeiterenTextAnzeigen
     (WelcherTextExtern : in Natural)
   is begin
            
      Sf.Graphics.Text.setColor (text  => TextAccess (1),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      WelcherText := 2 * WelcherTextExtern;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (WelcherText)));
      Sf.Graphics.Text.setPosition (text     => TextAccess (1),
                                    position => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (1));
      
   end WeiterenTextAnzeigen;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (TextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop TextSchleife;
   
      return True;
      
   end SchriftartFestlegen;



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextAccessArray'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      return True;

   end SchriftgrößenFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
                  
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      return True;

   end SchriftfarbenFestlegen;
   
   
   
   function TextFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageForschungsprojekt)));
      
      TextSchleife:
      for TextSchleifenwert in EinheitStadtDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (TextSchleifenwert) - 1)));
         
      end loop TextSchleife;
      
      return True;
      
   end TextFestlegen;

end ForschungAnzeigeSFML;
