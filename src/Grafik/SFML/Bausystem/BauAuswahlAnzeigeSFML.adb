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
with InDerStadtBauen;
with InteraktionAuswahl;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
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
      
      ------------------ Hier Aufruf für Hintergrundbild einbauen.
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      AktuelleAuswahl := InDerStadtBauen.AktuelleAuswahl;
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      case
        InteraktionAuswahl.PositionenBauenFestgelegt
      is
         when False =>
            Grundposition := StartPositionText;
            
            Sf.Graphics.Text.setPosition (text     => ÜberschriftAccess,
                                          position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => ÜberschriftAccess), Grundposition.y));
            
            Grundposition.y := Grundposition.y + Sf.Graphics.Text.getLocalBounds (text => ÜberschriftAccess).height + 10.00 * Zeilenabstand;
      
            Sf.Graphics.Text.setPosition (text     => GebäudtextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => GebäudtextAccess (0),
                                                                                                                    LinksRechtsExtern => True),
                                                       Grundposition.y));
      
            Sf.Graphics.Text.setPosition (text     => EinheitentextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => GebäudtextAccess (0),
                                                                                                                    LinksRechtsExtern => False),
                                                       Grundposition.y));
            
            TextPosition.y := Grundposition.y + Sf.Graphics.Text.getLocalBounds (text => ÜberschriftAccess).height + 10.00 * Zeilenabstand;
            AbstandÜberschrift := TextPosition.y;
            
         when True =>
            null;
      end case;

      ZusatztextGebäude := 0;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl.GebäudeEinheit = True
                 and
                   AktuelleAuswahl.Nummer = GebäudeSchleifenwert
               then
                  -- WeiterenTextAnzeigen (WelcherTextExtern => Bauliste (BaulisteSchleifenwert));
                  Sf.Graphics.Text.setColor (text  => GebäudtextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
            
               else
                  Sf.Graphics.Text.setColor (text  => GebäudtextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
         
               -- WelcherTextKurz := 2 * Natural (Bauliste (BaulisteSchleifenwert).Nummer) - 1;
         
               Sf.Graphics.Text.setPosition (text     => GebäudtextAccess (GebäudeSchleifenwert),
                                             position => TextPosition);
         
               TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => GebäudtextAccess (GebäudeSchleifenwert)).height + 3.00 * Zeilenabstand;

            when False =>
               null;
         end case;
               
      end loop GebäudeSchleife;

      ZusatztextEinheiten := 0;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         null;
         
      end loop EinheitenSchleife;
      
      InteraktionAuswahl.PositionenBauenFestgelegt := True;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => ÜberschriftAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in GebäudtextAccessArray'Range loop
            
         if
           GebäudetextSchleifenwert = 0
           or else
             InteraktionAuswahl.MöglicheGebäude (GebäudetextSchleifenwert) = True
         then
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => GebäudtextAccess (GebäudetextSchleifenwert));
            
         else
            null;
         end if;
                        
      end loop GebäudetextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitentextAccessArray'Range loop
         
         if
           EinheitentextSchleifenwert = 0
           or else
             InteraktionAuswahl.MöglicheEinheiten (EinheitentextSchleifenwert) = True
         then
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => EinheitentextAccess (EinheitentextSchleifenwert));
            
         else
            null;
         end if;
         
      end loop EinheitentextSchleife;
      
   end BauAuswahlAnzeige;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setFont (text => ÜberschriftAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in GebäudtextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => GebäudtextAccess (GebäudetextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop GebäudetextSchleife;
      
      GebäudezusatztextSchleife:
      for GebäudezusatztextSchleifenwert in GebäudzusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => GebäudzusatztextAccess (GebäudezusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop GebäudezusatztextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitentextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => EinheitentextAccess (EinheitentextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop EinheitentextSchleife;
      
      EinheitenzusatztextSchleife:
      for EinheitenzusatztextSchleifenwert in EinheitenzusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => EinheitenzusatztextAccess (EinheitenzusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop EinheitenzusatztextSchleife;
   
      return True;
      
   end SchriftartFestlegen;



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => ÜberschriftAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      Sf.Graphics.Text.setCharacterSize (text => GebäudtextAccess (0),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => GebäudtextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         Sf.Graphics.Text.setCharacterSize (text => GebäudzusatztextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
            
      end loop GebäudetextSchleife;
      
      
      
      Sf.Graphics.Text.setCharacterSize (text => EinheitentextAccess (0),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => EinheitentextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         Sf.Graphics.Text.setCharacterSize (text => EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop EinheitentextSchleife;
      
      return True;

   end SchriftgrößenFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setColor (text => ÜberschriftAccess,
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text => GebäudtextAccess (0),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setColor (text => GebäudtextAccess (GebäudetextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => GebäudzusatztextAccess (GebäudetextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            
      end loop GebäudetextSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text => EinheitentextAccess (0),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setColor (text => EinheitentextAccess (EinheitentextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitentextSchleife;
      
      return True;

   end SchriftfarbenFestlegen;
   
   
   
   function TextFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => ÜberschriftAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.FrageBauprojekt)));
      
      Sf.Graphics.Text.setUnicodeString (text => GebäudtextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGebäude)));
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => GebäudtextAccess (GebäudetextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => GebäudzusatztextAccess (GebäudetextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert))));
            
      end loop GebäudetextSchleife;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => EinheitentextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugEinheiten)));
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setUnicodeString (text => EinheitentextAccess (EinheitentextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert))));
         
      end loop EinheitentextSchleife;
      
      return True;
      
   end TextFestlegen;

end BauAuswahlAnzeigeSFML;
