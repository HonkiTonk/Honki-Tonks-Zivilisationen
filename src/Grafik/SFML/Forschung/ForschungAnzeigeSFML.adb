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
with TextaccessVariablen;

with LeseForschungenDatenbank;
with LeseEinheitenDatenbank;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with InteraktionAuswahl;
with TextberechnungenHoeheSFML;
with HintergrundSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with ForschungsbeschreibungenSFML;
with EinheitenbeschreibungenSFML;
with GebaeudebeschreibungenSFML;
with UeberschriftviewSFML;
with BeschreibungenZeilenumbruchSFML;

package body ForschungAnzeigeSFML is

   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      UeberschriftviewSFML.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextnummernKonstanten.FrageForschungsprojekt)),
                                         HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum);
            
      AktuelleAuswahl := ForschungenDatentypen.ForschungIDMitNullWert (AktuelleAuswahlExtern);
      
      Auswahlmöglichkeiten (AuswahlExtern    => AktuelleAuswahl,
                             ViewnummerExtern => 1);
      Beschreibung (ZusatztextExtern => AktuelleAuswahl,
                    ViewnummerExtern => 2,
                    RasseExtern      => RasseExtern);
      Ermöglicht (ZusatztextExtern => AktuelleAuswahl,
                   RasseExtern      => RasseExtern,
                   ViewnummerExtern => 3);
      Aktuell (RasseExtern      => RasseExtern,
               ViewnummerExtern => 4);
      
   end ForschungAnzeige;
   
   
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      TextPosition := TextKonstanten.StartpositionText;
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      -- Darf nicht auch 0.00 gesetzt werden, da es sonst zu Abstürzen kommt wenn alle Technologien erforscht wurden.äöü
      -- Später eine bessere Lösung bauen. äöü
      AktuelleTextbreite := 0.01;
            
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = ForschungSchleifenwert
               then
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
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
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
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern => ForschungsbeschreibungenSFML.BeschreibungLang (IDExtern    => ZusatztextExtern,
                                                                                                                                                                      RasseExtern => RasseExtern)));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern));
      
      AktuelleTextbreite := 0.01;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextExtern)).height + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
              
   end Beschreibung;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus? äöü
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
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
                                                  str  => ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => TechnologieSchleifenwert,
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
                                               str  => EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern => EinheitenSchleifenwert));
               
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
                                               str  => GebaeudebeschreibungenSFML.BeschreibungKurz (IDExtern => GebäudeSchleifenwert));
            
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
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Ermöglicht;
   
   
   
   procedure Aktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                     VerhältnisExtern => (0.10, 0.10));
      --  Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                      VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      TextPosition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := 0.01;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => AktuellesForschungsprojekt,
                                                                                                                                          RasseExtern => RasseExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
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
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Aktuell;

end ForschungAnzeigeSFML;
