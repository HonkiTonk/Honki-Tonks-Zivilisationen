pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;
with GrafikDatentypen;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with ForschungAllgemein;
with InteraktionAuswahl;
with TextaccessVariablen;
with Fehler;
with TextberechnungenHoeheSFML;
with HintergrundSFML;

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
            HintergrundSFML.StandardHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum);
      end case;
      
      -- NachGrafiktastk verschieben. äöü
      AktuelleAuswahl := ForschungAllgemein.AktuelleAuswahl;
      
      TextPosition := StartPositionText;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                    position => (TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung)), TextPosition.y));
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      -- Diesen Wert nicht löschen, bestimmt später den Abstand der Zusatztextbox von der Überschrift.
      AbstandÜberschrift := TextPosition.y;
                  
      WelcherZusatztext := ForschungKonstanten.LeerForschung;
      
      -- Hier auch HintergrundSFML.TextHintergrund verwenden? Müsste mit immer rechts funktionieren. äöü
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
               
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                             position => TextPosition);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
               
      end loop AnzeigeSchleife;
            
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
