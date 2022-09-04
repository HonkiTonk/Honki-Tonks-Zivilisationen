pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;
with GrafikDatentypen;
with TextKonstanten;
with Meldungstexte;
with TextnummernKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with TextaccessVariablen;
with Views;

with LeseForschungenDatenbank;
with LeseEinheitenDatenbank;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with InteraktionAuswahl;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with TexteinstellungenGrafik;
with ViewsEinstellenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;
with AllgemeineViewsGrafik;
with ZeilenumbruchberechnungGrafik;

package body ForschungsauswahlGrafik is

   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageForschungsprojekt)),
                                        HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum);
            
      AktuelleAuswahl := ForschungenDatentypen.ForschungIDMitNullWert (AktuelleAuswahlExtern);
      
      Auswahlmöglichkeiten (AuswahlExtern    => AktuelleAuswahl,
                             ViewnummerExtern => 1,
                             RasseExtern      => RasseExtern);
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
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition := TextKonstanten.StartpositionText;
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
            
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = ForschungSchleifenwert
               then
                  Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
               end if;
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                          color => Farbe);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                             position => Textposition);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
         
               Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop AnzeigeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Textposition := TextKonstanten.StartpositionText;
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                          position => Textposition);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                         str  => ZeilenumbruchberechnungGrafik.ZeilenumbruchBerechnen (TextExtern   => ForschungsbeschreibungenGrafik.BeschreibungLang (IDExtern    => ZusatztextExtern,
                                                                                                                                                                        RasseExtern => RasseExtern),
                                                                                                         BreiteExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).width));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern));
      
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      Textposition.y := Textposition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern)).height + TextberechnungenHoeheGrafik.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
              
   end Beschreibung;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus?
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 0.50));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Textposition := TextKonstanten.StartpositionText;
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      end case;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugWirdBenötigt)));
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
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
                                             position => Textposition);
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                  str  => ForschungsbeschreibungenGrafik.BeschreibungKurz (IDExtern    => TechnologieSchleifenwert,
                                                                                                         RasseExtern => RasseExtern));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
               Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                         TextbreiteExtern => AktuelleTextbreite);
                  
            else
               null;
            end if;
         
         end loop TechnologienSchleife;
      end loop ErmöglichtSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
         
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
            
         if
           ZusatztextExtern = LeseEinheitenDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                    IDExtern    => EinheitenSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => EinheitenSchleifenwert,
                                                                                                     RasseExtern => RasseExtern));
               
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                      TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
               
      end loop EinheitenSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
         
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
            
         if
           ZusatztextExtern = LeseGebaeudeDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                   IDExtern    => GebäudeSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => GebaeudebeschreibungenGrafik.BeschreibungKurz (IDExtern    => GebäudeSchleifenwert,
                                                                                                    RasseExtern => RasseExtern));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                      TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
            
      end loop GebäudeSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Ermöglicht;
   
   
   
   procedure Aktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                     VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungsbeschreibungenGrafik.BeschreibungKurz (IDExtern    => AktuellesForschungsprojekt,
                                                                                                                                                    RasseExtern => RasseExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit) & LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)'Wide_Wide_Image;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Aktuell;

end ForschungsauswahlGrafik;