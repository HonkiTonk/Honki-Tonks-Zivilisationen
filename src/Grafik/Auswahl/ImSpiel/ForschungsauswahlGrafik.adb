with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungKonstanten;
with GrafikDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with TextaccessVariablen;
with Views;
with ViewKonstanten;

with LeseForschungenDatenbank;
with LeseEinheitenDatenbank;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with InteraktionAuswahl;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;
with AllgemeineViewsGrafik;
with ZeilenumbruchberechnungGrafik;
with TextfarbeGrafik;

package body ForschungsauswahlGrafik is

   procedure ForschungAnzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageForschungsprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                          SpielenamenExtern => False);
            
      AktuelleAuswahl := ForschungenDatentypen.ForschungIDMitNullWert (AktuelleAuswahlExtern);
      
      Auswahlmöglichkeiten (AuswahlExtern => AktuelleAuswahl,
                             SpeziesExtern   => SpeziesExtern);
      
      Ermöglicht (ZusatztextExtern => AktuelleAuswahl,
                   SpeziesExtern      => SpeziesExtern);
      Beschreibung (ZusatztextExtern => AktuelleAuswahl,
                    SpeziesExtern      => SpeziesExtern);
      
      Aktuell (SpeziesExtern => SpeziesExtern);
      
   end ForschungAnzeige;
   
   
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüForschungsliste),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste));
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
            
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (ForschungSchleifenwert),
                                                      AuswahlExtern    => Natural (AuswahlExtern),
                                                      TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert));
               
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert),
                                             position => Textposition);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop AnzeigeSchleife;
      
      Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüErmöglicht),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            AktuelleTextbreite := 0.00;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugWirdBenötigt)));
               
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
      end case;
      
      ErmöglichtSchleife:
      for NeueForschungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
         TechnologienSchleife:
         for TechnologieSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
            
            Forschungswert := LeseForschungenDatenbank.AnforderungForschung (SpeziesExtern             => SpeziesExtern,
                                                                             IDExtern                => TechnologieSchleifenwert,
                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert);
            
            if
              Forschungswert = ZusatztextExtern
            then
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                             position => Textposition);
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                  str  => ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => TechnologieSchleifenwert,
                                                                                                           SpeziesExtern => SpeziesExtern));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                           TextbreiteExtern => AktuelleTextbreite);
                  
            else
               null;
            end if;
         
         end loop TechnologienSchleife;
      end loop ErmöglichtSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
         
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
            
         if
           ZusatztextExtern = LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => SpeziesExtern,
                                                                    IDExtern    => EinheitenSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => EinheitenSchleifenwert,
                                                                                                       SpeziesExtern => SpeziesExtern));
               
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
            
         else
            null;
         end if;
               
      end loop EinheitenSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
         
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
            
         if
           ZusatztextExtern = LeseGebaeudeDatenbank.Anforderungen (SpeziesExtern => SpeziesExtern,
                                                                   IDExtern    => GebäudeSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern    => GebäudeSchleifenwert,
                                                                                                      SpeziesExtern => SpeziesExtern));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
         
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
            
      end loop GebäudeSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Ermöglicht;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüBeschreibung),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, ZusatztextExtern),
                                          position => Textposition);
      
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, ZusatztextExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => ForschungsbeschreibungenGrafik.Langbeschreibung (IDExtern    => ZusatztextExtern,
                                                                                                                                                                                       SpeziesExtern => SpeziesExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung).x / 2.00 - Textposition.x));
      
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, ZusatztextExtern));
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, ZusatztextExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
            Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung) := Textposition;
      end case;
              
   end Beschreibung;
   
   
   
   procedure Aktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüAktuell)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüAktuell),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüAktuell),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => AktuellesForschungsprojekt,
                                                                                                                                                       SpeziesExtern => SpeziesExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                              ViewbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                  TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
      Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit);
      
      case
        Forschungszeit
      is
         when ProduktionDatentypen.Lagermenge'Last =>
            Text := Text & " ∞";
            
         when others =>
            Text := Text & Forschungszeit'Wide_Wide_Image;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                              ViewbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                  TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
      Viewfläche (ViewKonstanten.ForschungsmenüAktuell) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Aktuell;

end ForschungsauswahlGrafik;
