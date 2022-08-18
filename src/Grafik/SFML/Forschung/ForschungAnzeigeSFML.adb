pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;
with GrafikDatentypen;
with TextKonstanten;
with GlobaleTexte;
with TextnummernKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;

with LeseForschungenDatenbank;
with LeseEinheitenDatenbank;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with NachGrafiktask;
with InteraktionAuswahl;
with TextaccessVariablen;
with Fehler;
with TextberechnungenHoeheSFML;
with HintergrundSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with ForschungAllgemein;
with EinheitenBeschreibungen;
with GebaeudeAllgemein;

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
      
      ViewflächenSchleife:
      for ViewflächenSchleifenwert in ViewflächenArray'Range loop
         
         null;
         -- Viewfläche (ViewflächenSchleifenwert) := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche (ViewflächenSchleifenwert));
         -- Viewfläche (ViewflächenSchleifenwert) := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche (ViewflächenSchleifenwert));
         
      end loop ViewflächenSchleife;
      
      Überschrift;
      WelcherZusatztext := Auswahlmöglichkeiten;
      Beschreibung (ZusatztextExtern => WelcherZusatztext);
      Ermöglicht (ZusatztextExtern => WelcherZusatztext,
                   RasseExtern      => RasseExtern);
      Aktuell (RasseExtern => RasseExtern);
      
   end ForschungAnzeige;
   
   
   
   procedure Überschrift
   is begin
            
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (1),
                                          GrößeExtern          => Viewfläche (1),
                                          AnzeigebereichExtern => Anzeigebereich (1));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (1));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextnummernKonstanten.FrageForschungsprojekt)));
      
      TextPosition.x := Viewfläche (1).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess);
      TextPosition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => TextPosition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);

      Viewfläche (1) := (TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).width,
                          TextPosition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).height);
      
   end Überschrift;
   
   
   
   function Auswahlmöglichkeiten
     return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      Viewfläche (2) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (2),
                                                                          VerhältnisExtern => (0.50, 1.00));
      Viewfläche (2) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (2),
                                                                          VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (2),
                                          GrößeExtern          => Viewfläche (2),
                                          -- Für den Anzeigebereich später ein konstantes Array festlegen.
                                          AnzeigebereichExtern => Anzeigebereich (2));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (2));
      
      TextPosition := TextKonstanten.StartpositionText;
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      -- Darf nicht auch 0.00 gesetzt werden, da es sonst zu Abstürzen kommt wenn alle technologien erforscht wurden.äöü
      -- Später eine bessere Lösung bauen. äöü
      AktuelleTextbreite := 0.01;
      
      -- Die aktuelle Auswahl auch immer mitübergeben? Auch in anderen Menüs? äöü
      AktuelleAuswahl := ForschungenDatentypen.ForschungIDNichtMöglich (NachGrafiktask.AktuelleAuswahl);
      Zusatztext := ForschungKonstanten.LeerForschung;
      
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 AktuelleAuswahl = ForschungSchleifenwert
               then
                  Zusatztext := ForschungSchleifenwert;
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
               end if;
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                          color => Farbe);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                             position => TextPosition);
               
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop AnzeigeSchleife;
      
      Viewfläche (2) := (AktuelleTextbreite, TextPosition.y);
      
      return Zusatztext;
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
   is begin
      
      Viewfläche (3) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (3),
                                                                          VerhältnisExtern => (0.50, 0.50));
      Viewfläche (3) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (3),
                                                                          VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (3),
                                          GrößeExtern          => Viewfläche (3),
                                          -- Für den Anzeigebereich später ein konstantes Array festlegen.
                                          AnzeigebereichExtern => Anzeigebereich (3));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (3));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            TextPosition := TextKonstanten.StartpositionText;
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern),
                                          position => TextPosition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern));
            
            Viewfläche (3) := (Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern)).width + TextKonstanten.TextbreiteZusatzwert,
                                TextPosition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern)).height);
      end case;
              
   end Beschreibung;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus? äöü
      Viewfläche (4) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (4),
                                                                          VerhältnisExtern => (0.50, 0.50));
      Viewfläche (4) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (4),
                                                                          VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (4),
                                          GrößeExtern          => Viewfläche (4),
                                          AnzeigebereichExtern => Anzeigebereich (4));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (4));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            TextPosition := TextKonstanten.StartpositionText;
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            AktuelleTextbreite := 0.01;
      end case;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextnummernKonstanten.ZeugWirdBenötigt)));
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      ErmöglichtSchleife:
      for NeueForschungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
         TechnologienSchleife:
         for TechnologieSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
            
            Forschungswert := LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                             IDExtern                => TechnologieSchleifenwert,
                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert);
            
            if
              Forschungswert = ZusatztextExtern
            then
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                             position => TextPosition);
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                  str  => ForschungAllgemein.Beschreibung (IDExtern    => TechnologieSchleifenwert,
                                                                                           RasseExtern => RasseExtern));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                         TextbreiteExtern => AktuelleTextbreite);
                  
            else
               null;
            end if;
         
         end loop TechnologienSchleife;
      end loop ErmöglichtSchleife;
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
            
         if
           ZusatztextExtern = LeseEinheitenDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                    IDExtern    => EinheitenSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => TextPosition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => EinheitenSchleifenwert));
               
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
            
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                      TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
               
      end loop EinheitenSchleife;
         
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
            
         if
           ZusatztextExtern = LeseGebaeudeDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                   IDExtern    => GebäudeSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => TextPosition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => GebaeudeAllgemein.BeschreibungKurz (IDExtern => GebäudeSchleifenwert));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                      TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
            
      end loop GebäudeSchleife;
         
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Viewfläche (4) := (AktuelleTextbreite, TextPosition.y);
      
   end Ermöglicht;
   
   
   
   procedure Aktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (5) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (5),
      --                                                                     VerhältnisExtern => (0.10, 0.10));
      --  Viewfläche (5) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (5),
      --                                                                      VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (5),
                                          GrößeExtern          => Viewfläche (5),
                                          -- Für den Anzeigebereich später ein konstantes Array festlegen.
                                          AnzeigebereichExtern => Anzeigebereich (5));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (5));
      
      TextPosition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := 0.01;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungAllgemein.Beschreibung (IDExtern    => AktuellesForschungsprojekt,
                                                                                                                                      RasseExtern => RasseExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      TextPosition.x := Viewfläche (5).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit) & LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)'Wide_Wide_Image;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      TextPosition.x := Viewfläche (5).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      Viewfläche (5) := (AktuelleTextbreite, TextPosition.y);
      
   end Aktuell;

end ForschungAnzeigeSFML;
