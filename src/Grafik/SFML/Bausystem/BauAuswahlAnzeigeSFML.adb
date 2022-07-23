pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with TextKonstanten;

with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with TextberechnungenBreiteSFML;
with InDerStadtBauen;
with InteraktionAuswahl;
with Fehler;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;
with GebaeudeAllgemein;
with EinheitenBeschreibungen;
with HintergrundSFML;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
            Fehler.GrafikFehler (FehlermeldungExtern => "BauAuswahlAnzeigeSFML.BauAuswahlAnzeige - Baumenü ohne Rasse aufgerufen.");
                     
         when others =>
            null;
      end case;
      
      SchriftgrößenFestlegen;
      
      -- Hier Aufruf für Hintergrundbild einbauen. äöü
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      AktuelleAuswahl := InDerStadtBauen.AktuelleAuswahl;
      
      Grundposition := StartPositionText;
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.BaumenüÜberschriftAccess,
                                    position => (TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.BaumenüÜberschriftAccess), Grundposition.y));
            
      Grundposition.y := Grundposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (0),
                                    position => (TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (0),
                                                                                                      LinksRechtsExtern => True),
                                                 Grundposition.y));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (0),
                                    position => (TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (0),
                                                                                                      LinksRechtsExtern => False),
                                                 Grundposition.y));
            
      Grundposition.y := Grundposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      TextPosition := Grundposition;
      AbstandÜberschrift := TextPosition.y;

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
                                                position => (AnfangsabstandExtratext + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
                  HintergrundSFML.TextHintergrund (GebäudeEinheitExtern     => True,
                                                   AbstandÜberschriftExtern => AbstandÜberschrift,
                                                   VerhältnisTextfeldExtern => VerhältnisTextfeld,
                                                   StartpositionExtern      => StartPositionText.x);
            
               else
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
               
               TextPosition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                                                                      LinksRechtsExtern => True);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                             position => TextPosition);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert));

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
                                                position => (AnfangsabstandExtratext + StartPositionText.x, AbstandÜberschrift));
                  HintergrundSFML.TextHintergrund (GebäudeEinheitExtern     => False,
                                                   AbstandÜberschriftExtern => AbstandÜberschrift,
                                                   VerhältnisTextfeldExtern => VerhältnisTextfeld,
                                                   StartpositionExtern      => StartPositionText.x);
            
               else
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
                  
               TextPosition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                                                                      LinksRechtsExtern => False);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                             position => TextPosition);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
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
      BreiteTextfeld := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * VerhältnisTextfeld.x - EndabstandExtratext;
      
      if
        ZusatztextGebäude /= 0
        and
          ZusatztextEinheiten /= 0
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "BauAuswahlAnzeigeSFML.BauAuswahlAnzeige - Zwei Projekte sind gleichzeitig ausgewählt.");
         
         -- Wenn ich die Zusatztexte jetzt ja immer neu setzen, dann reicht da auch ein einzelner Access ohne Schleife, oder? äöü
      elsif
        ZusatztextGebäude /= 0
      then
         Multiplikator := 1.00;
                    
         GebäudeTextbereichSchleife:
         for TextbereichSchleifenwert in 1 .. GebaeudeAllgemein.BeschreibungLang (IDExtern => ZusatztextGebäude)'Last loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & GebaeudeAllgemein.BeschreibungLang (IDExtern => ZusatztextGebäude) (TextbereichSchleifenwert);
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & GebaeudeAllgemein.BeschreibungLang (IDExtern => ZusatztextGebäude) (TextbereichSchleifenwert);
            
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
         
         -- Wenn ich die Zusatztexte jetzt ja immer neu setzen, dann reicht da auch ein einzelner Access ohne Schleife, oder? äöü
      elsif
        ZusatztextEinheiten /= 0
      then
         Multiplikator := 1.00;
                    
         EinheitenTextbereichSchleife:
         for TextbereichSchleifenwert in 1 .. EinheitenBeschreibungen.BeschreibungLang (IDExtern => ZusatztextEinheiten)'Last loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & EinheitenBeschreibungen.BeschreibungLang (IDExtern => ZusatztextEinheiten) (TextbereichSchleifenwert);
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & EinheitenBeschreibungen.BeschreibungLang (IDExtern => ZusatztextEinheiten) (TextbereichSchleifenwert);
            
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



   procedure SchriftgrößenFestlegen
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (0),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (0),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);

   end SchriftgrößenFestlegen;

end BauAuswahlAnzeigeSFML;
