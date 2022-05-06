pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with TextKonstanten;
with MenueDatentypen;

with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with AllgemeineTextBerechnungenSFML;
with InDerStadtBauen;
with InteraktionAuswahl;
with Fehler;
with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;

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
      
            Sf.Graphics.Text.setPosition (text     => GebäudetextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => GebäudetextAccess (0),
                                                                                                                    LinksRechtsExtern => True),
                                                       Grundposition.y));
      
            Sf.Graphics.Text.setPosition (text     => EinheitentextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => GebäudetextAccess (0),
                                                                                                                    LinksRechtsExtern => False),
                                                       Grundposition.y));
            
            Grundposition.y := Grundposition.y + Sf.Graphics.Text.getLocalBounds (text => ÜberschriftAccess).height + 10.00 * Zeilenabstand;
            TextPosition := Grundposition;
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
                  ZusatztextGebäude := GebäudeSchleifenwert;
                  Sf.Graphics.Text.setColor (text  => GebäudetextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => GebäudezusatztextAccess (GebäudeSchleifenwert),
                                                position => (2.00 * Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 4.00, AbstandÜberschrift));
                  TextHintergrund (GebäudeEinheitExtern => True);
            
               else
                  Sf.Graphics.Text.setColor (text  => GebäudetextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
                  
               if
                 InteraktionAuswahl.PositionenBauenFestgelegt = False
               then
                  TextPosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => GebäudetextAccess (GebäudeSchleifenwert),
                                                                                                 LinksRechtsExtern => True);
                  Sf.Graphics.Text.setPosition (text     => GebäudetextAccess (GebäudeSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => GebäudetextAccess (GebäudeSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => GebäudetextAccess (GebäudeSchleifenwert));
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
               
      end loop GebäudeSchleife;

      ZusatztextEinheiten := 0;
      TextPosition := Grundposition;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl.GebäudeEinheit = False
                 and
                   AktuelleAuswahl.Nummer = EinheitenSchleifenwert
               then
                  ZusatztextEinheiten := EinheitenSchleifenwert;
                  Sf.Graphics.Text.setColor (text  => EinheitentextAccess (EinheitenSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => EinheitenzusatztextAccess (EinheitenSchleifenwert),
                                                position => (StartPositionText.x, AbstandÜberschrift));
                  TextHintergrund (GebäudeEinheitExtern => False);
            
               else
                  Sf.Graphics.Text.setColor (text  => EinheitentextAccess (EinheitenSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
                  
               if
                 InteraktionAuswahl.PositionenBauenFestgelegt = False
               then
                  TextPosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => EinheitentextAccess (EinheitenSchleifenwert),
                                                                                                 LinksRechtsExtern => False);
                  Sf.Graphics.Text.setPosition (text     => EinheitentextAccess (EinheitenSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => EinheitentextAccess (EinheitenSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => EinheitentextAccess (EinheitenSchleifenwert));
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      InteraktionAuswahl.PositionenBauenFestgelegt := True;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => ÜberschriftAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in GebäudetextAccessArray'Range loop
         
         case
           ZusatztextEinheiten
         is
            when 0 =>
               if
                 GebäudetextSchleifenwert = 0
                 or else
                   InteraktionAuswahl.MöglicheGebäude (GebäudetextSchleifenwert) = True
               then
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => GebäudetextAccess (GebäudetextSchleifenwert));
            
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
               
      end loop GebäudetextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitentextAccessArray'Range loop
         
         case
           ZusatztextGebäude
         is
            when 0 =>
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
               
            when others =>
               null;
         end case;
         
      end loop EinheitentextSchleife;
      
      AktuellerTextbereichEins := TextKonstanten.LeerUnboundedString;
      AktuellerTextbereichZwei := TextKonstanten.LeerUnboundedString;
      BreiteTextfeld := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * VerhältnisTextfeld.x;
      
      if
        ZusatztextGebäude /= 0
        and
          ZusatztextEinheiten /= 0
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "BauAuswahlAnzeigeSFML.BauAuswahlAnzeige - Zwei Projekte sind gleichzeitig ausgewählt.");
         
      elsif
        ZusatztextGebäude /= 0
      then
         Multiplikator := 1.00;
                    
         GebäudeTextbereichSchleife:
         for TextbereichSchleifenwert in 1 .. To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (ZusatztextGebäude)))'Last loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (ZusatztextGebäude))) (TextbereichSchleifenwert);
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (ZusatztextGebäude))) (TextbereichSchleifenwert);
            
            Sf.Graphics.Text.setUnicodeString (text => GebäudezusatztextAccess (ZusatztextGebäude),
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
         
            if
              Sf.Graphics.Text.getLocalBounds (text => GebäudezusatztextAccess (ZusatztextGebäude)).width >= Multiplikator * BreiteTextfeld
            then
               AktuellerTextbereichZwei := AktuellerTextbereichZwei & Ada.Characters.Wide_Wide_Latin_1.LF;
               Multiplikator := Multiplikator + 1.00;
            
            else
               null;
            end if;
            
         end loop GebäudeTextbereichSchleife;
            
         Sf.Graphics.Text.setUnicodeString (text => GebäudezusatztextAccess (ZusatztextGebäude),
                                            str  => To_Wide_Wide_String (Source => AktuellerTextbereichZwei));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => GebäudezusatztextAccess (ZusatztextGebäude));
         
      elsif
        ZusatztextEinheiten /= 0
      then
         Multiplikator := 1.00;
                    
         EinheitenTextbereichSchleife:
         for TextbereichSchleifenwert in 1 .. To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten)))'Last loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten))) (TextbereichSchleifenwert);
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten))) (TextbereichSchleifenwert);
            
            Sf.Graphics.Text.setUnicodeString (text => EinheitenzusatztextAccess (ZusatztextEinheiten),
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
         
            if
              Sf.Graphics.Text.getLocalBounds (text => EinheitenzusatztextAccess (ZusatztextEinheiten)).width >= Multiplikator * BreiteTextfeld
            then
               AktuellerTextbereichZwei := AktuellerTextbereichZwei & Ada.Characters.Wide_Wide_Latin_1.LF;
               Multiplikator := Multiplikator + 1.00;
            
            else
               null;
            end if;
            
         end loop EinheitenTextbereichSchleife;
            
         Sf.Graphics.Text.setUnicodeString (text => EinheitenzusatztextAccess (ZusatztextEinheiten),
                                            str  => To_Wide_Wide_String (Source => AktuellerTextbereichZwei));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => EinheitenzusatztextAccess (ZusatztextEinheiten));
         
      else
         null;
      end if;
      
   end BauAuswahlAnzeige;
      
   
   
   ----------------------------- Das hier alles noch einmal überarbeiten, unter anderem passt das mit den Menüs auch nicht.
   procedure TextHintergrund
     (GebäudeEinheitExtern : in Boolean)
   is begin
            
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum) /= null
      then
         case
           GebäudeEinheitExtern
         is
            when True =>
               PositionHintergrund := (2.00 * Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 4.00, AbstandÜberschrift);
               
            when False =>
               PositionHintergrund := (StartPositionText.x, AbstandÜberschrift);
         end case;
         
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => PositionHintergrund);
         
         Sf.Graphics.Sprite.scale (sprite  => SpriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenTeilBild (SpriteAccessExtern  => SpriteAccess,
                                                                                                           TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum),
                                                                                                           VerhältnisExtern    => VerhältnisTextfeld));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         -------------------- Später hier einen einfarbigen Hintergrund wie bei den Kartenfeldern einbauen.
         null;
      end if;
      
   end TextHintergrund;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setFont (text => ÜberschriftAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in GebäudetextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => GebäudetextAccess (GebäudetextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop GebäudetextSchleife;
      
      GebäudezusatztextSchleife:
      for GebäudezusatztextSchleifenwert in GebäudezusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => GebäudezusatztextAccess (GebäudezusatztextSchleifenwert),
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
      
      Sf.Graphics.Text.setCharacterSize (text => GebäudetextAccess (0),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => GebäudetextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         Sf.Graphics.Text.setCharacterSize (text => GebäudezusatztextAccess (GebäudetextSchleifenwert),
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
      
      Sf.Graphics.Text.setColor (text => GebäudetextAccess (0),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setColor (text => GebäudetextAccess (GebäudetextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => GebäudezusatztextAccess (GebäudetextSchleifenwert),
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
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageBauprojekt)));
      
      Sf.Graphics.Text.setUnicodeString (text => GebäudetextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGebäude)));
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => GebäudetextAccess (GebäudetextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => GebäudezusatztextAccess (GebäudetextSchleifenwert),
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
