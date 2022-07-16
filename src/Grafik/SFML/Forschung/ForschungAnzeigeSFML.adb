pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;

with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with TextberechnungenBreiteSFML;
with ForschungAllgemein;
with InteraktionAuswahl;
with TextaccessVariablen;
with Fehler;

package body ForschungAnzeigeSFML is

   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Forschungsmenü ohne Rasse aufgerufen.");
                     
         when others =>
            null;
      end case;
      
      ----------------------- Hier Aufruf für Hintergrundbild einbauen.
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
      AktuelleAuswahl := ForschungAllgemein.AktuelleAuswahl;
      
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      case
        InteraktionAuswahl.PositionenForschungFestgelegt
      is
         when False =>
            TextPosition := StartPositionText;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                          position => (TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung)),
                                                       StartPositionText.y));
      
            TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung)).height + 10.00 * Zeilenabstand;
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
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (WelcherZusatztext),
                                                position => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, AbstandÜberschrift));
            
               else
                  Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                             color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               end if;
               
               if
                 InteraktionAuswahl.PositionenForschungFestgelegt = False
               then
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                                position => TextPosition);
         
                  TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert)).height + 3.00 * Zeilenabstand;
               
                  InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert));
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
               
      end loop AnzeigeSchleife;
      
      InteraktionAuswahl.PositionenForschungFestgelegt := True;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range loop
         
         if
           TextSchleifenwert = ForschungKonstanten.LeerForschung
           or else
             InteraktionAuswahl.MöglicheForschungen (TextSchleifenwert) = True
         then
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüAccess (TextSchleifenwert));

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
                                               text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (WelcherZusatztext));
      end case;
      
   end ForschungAnzeige;

end ForschungAnzeigeSFML;
