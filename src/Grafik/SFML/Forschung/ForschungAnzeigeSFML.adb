pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with ForschungenDatentypen; use ForschungenDatentypen;
with TextKonstanten;
with GlobaleTexte;
with ForschungKonstanten;

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
      then
         TextFestgelegt := TextFestlegen;
            
      else
         null;
      end if;
      
      ----------------------- Hier Aufruf für Hintergrundbild einbauen.
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      AktuelleAuswahl := ForschungAllgemein.AktuelleAuswahl;
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      case
        InteraktionAuswahl.PositionenForschungFestgelegt
      is
         when False =>
            TextPosition := StartPositionText;
      
            Sf.Graphics.Text.setPosition (text     => TextAccess (ForschungKonstanten.LeerForschung),
                                          position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (ForschungKonstanten.LeerForschung)), StartPositionText.y));
      
            TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (ForschungKonstanten.LeerForschung)).height + 10.00 * Zeilenabstand;
            AbstandÜberschrift := TextPosition.y;
            
         when True =>
            null;
      end case;
      
      WelcherZusatztext := ForschungKonstanten.LeerForschung;
      
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl = ForschungSchleifenwert
               then
                  WelcherZusatztext := ForschungSchleifenwert;
                  Sf.Graphics.Text.setColor (text  => TextAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => ZusatztextAccess (WelcherZusatztext),
                                                position => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
            
               else
                  Sf.Graphics.Text.setColor (text  => TextAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
               
               if
                 InteraktionAuswahl.PositionenForschungFestgelegt = False
               then
                  Sf.Graphics.Text.setPosition (text     => TextAccess (ForschungSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (ForschungSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (ForschungSchleifenwert));
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
               
      end loop AnzeigeSchleife;
      
      InteraktionAuswahl.PositionenForschungFestgelegt := True;
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
         
         if
           TextSchleifenwert = ForschungKonstanten.LeerForschung
           or else
             InteraktionAuswahl.MöglicheForschungen (TextSchleifenwert) = True
         then
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextAccess (TextSchleifenwert));

         else
            null;
         end if;
         
      end loop TextSchleife;
      
      case
        WelcherZusatztext
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => ZusatztextAccess (WelcherZusatztext));
      end case;
      
   end ForschungAnzeige;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (TextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop TextSchleife;
      
      ZusatztextSchleife:
      for ZusatztextSchleifenwert in ZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => ZusatztextAccess (ZusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextSchleife;
   
      return True;
      
   end SchriftartFestlegen;



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      --------------------- Zusammenführen
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (ForschungKonstanten.LeerForschung),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      ZusatztextSchleife:
      for ZusatztextSchleifenwert in ZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => ZusatztextAccess (ZusatztextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop ZusatztextSchleife;
      
      return True;

   end SchriftgrößenFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextAccess (ForschungKonstanten.LeerForschung),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
                  
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      ZusatztextSchleife:
      for ZusatztextSchleifenwert in ZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => ZusatztextAccess (ZusatztextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextSchleife;
      
      return True;

   end SchriftfarbenFestlegen;
   
   
   
   function TextFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (ForschungKonstanten.LeerForschung),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageForschungsprojekt)));
      
      TextSchleife:
      for TextSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (TextSchleifenwert) - 1)));
         
      end loop TextSchleife;
      
      ZusatztextSchleife:
      for ZusatztextSchleifenwert in ZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => ZusatztextAccess (ZusatztextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (ZusatztextSchleifenwert))));
         
      end loop ZusatztextSchleife;
      
      return True;
      
   end TextFestlegen;

end ForschungAnzeigeSFML;
