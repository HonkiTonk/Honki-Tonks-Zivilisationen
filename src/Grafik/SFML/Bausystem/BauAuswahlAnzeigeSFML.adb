pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
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
with TextaccessVariablen;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
   is begin
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößenFestlegen;
            
         when True =>
            null;
      end case;
      
      ------------------ Hier Aufruf für Hintergrundbild einbauen.
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      AktuelleAuswahl := InDerStadtBauen.AktuelleAuswahl;
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      case
        InteraktionAuswahl.PositionenBauenFestgelegt
      is
         when False =>
            Grundposition := StartPositionText;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.BaumenüÜberschriftAccess,
                                          position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.BaumenüÜberschriftAccess), Grundposition.y));
            
            Grundposition.y := Grundposition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.BaumenüÜberschriftAccess).height + 10.00 * Zeilenabstand;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (0),
                                                                                                                    LinksRechtsExtern => True),
                                                       Grundposition.y));
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (0),
                                          position => (AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (0),
                                                                                                                    LinksRechtsExtern => False),
                                                       Grundposition.y));
            
            Grundposition.y := Grundposition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.BaumenüÜberschriftAccess).height + 10.00 * Zeilenabstand;
            TextPosition := Grundposition;
            AbstandÜberschrift := TextPosition.y;
            
         when True =>
            null;
      end case;

      ZusatztextGebäude := 0;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl.Gebäude /= 0
                 and
                   AktuelleAuswahl.Gebäude = GebäudeSchleifenwert
               then
                  ZusatztextGebäude := GebäudeSchleifenwert;
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (GebäudeSchleifenwert),
                                                position => (2.00 * Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 4.00, AbstandÜberschrift));
                  TextHintergrund (GebäudeEinheitExtern => True);
            
               else
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
                  
               if
                 InteraktionAuswahl.PositionenBauenFestgelegt = False
               then
                  TextPosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                                                                                 LinksRechtsExtern => True);
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert));
                  
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
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl.Einheit /= 0
                 and
                   AktuelleAuswahl.Einheit = EinheitenSchleifenwert
               then
                  ZusatztextEinheiten := EinheitenSchleifenwert;
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenzusatztextAccess (EinheitenSchleifenwert),
                                                position => (StartPositionText.x, AbstandÜberschrift));
                  TextHintergrund (GebäudeEinheitExtern => False);
            
               else
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
                  
               if
                 InteraktionAuswahl.PositionenBauenFestgelegt = False
               then
                  TextPosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                                                                                 LinksRechtsExtern => False);
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert));
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      InteraktionAuswahl.PositionenBauenFestgelegt := True;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.BaumenüÜberschriftAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
         
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
                                                     text         => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert));
            
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
               
      end loop GebäudetextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range loop
         
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
                                                     text         => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert));
            
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
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (ZusatztextGebäude),
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
         
            if
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.GebäudezusatztextAccess (ZusatztextGebäude)).width >= Multiplikator * BreiteTextfeld
            then
               AktuellerTextbereichZwei := AktuellerTextbereichZwei & Ada.Characters.Wide_Wide_Latin_1.LF;
               Multiplikator := Multiplikator + 1.00;
            
            else
               null;
            end if;
            
         end loop GebäudeTextbereichSchleife;
            
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (ZusatztextGebäude),
                                            str  => To_Wide_Wide_String (Source => AktuellerTextbereichZwei));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.GebäudezusatztextAccess (ZusatztextGebäude));
         
      elsif
        ZusatztextEinheiten /= 0
      then
         Multiplikator := 1.00;
                    
         EinheitenTextbereichSchleife:
         for TextbereichSchleifenwert in 1 .. To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten)))'Last loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten))) (TextbereichSchleifenwert);
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (ZusatztextEinheiten))) (TextbereichSchleifenwert);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (ZusatztextEinheiten),
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
         
            if
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.EinheitenzusatztextAccess (ZusatztextEinheiten)).width >= Multiplikator * BreiteTextfeld
            then
               AktuellerTextbereichZwei := AktuellerTextbereichZwei & Ada.Characters.Wide_Wide_Latin_1.LF;
               Multiplikator := Multiplikator + 1.00;
            
            else
               null;
            end if;
            
         end loop EinheitenTextbereichSchleife;
            
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (ZusatztextEinheiten),
                                            str  => To_Wide_Wide_String (Source => AktuellerTextbereichZwei));
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.EinheitenzusatztextAccess (ZusatztextEinheiten));
         
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



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (0),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (0),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      return True;

   end SchriftgrößenFestlegen;

end BauAuswahlAnzeigeSFML;
