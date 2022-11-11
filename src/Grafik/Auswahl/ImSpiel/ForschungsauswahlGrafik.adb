with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;
with GrafikDatentypen;
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
with ViewsEinstellenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;
with AllgemeineViewsGrafik;
with ZeilenumbruchberechnungGrafik;
with TextfarbeGrafik;

package body ForschungsauswahlGrafik is

   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageForschungsprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                          SpielenamenExtern => False);
            
      AktuelleAuswahl := ForschungenDatentypen.ForschungIDMitNullWert (AktuelleAuswahlExtern);
      
      Auswahlmöglichkeiten (AuswahlExtern    => AktuelleAuswahl,
                             ViewnummerExtern => 1,
                             RasseExtern      => RasseExtern);
      
      Ermöglicht (ZusatztextExtern => AktuelleAuswahl,
                   RasseExtern      => RasseExtern,
                   ViewnummerExtern => 2);
      Beschreibung (ZusatztextExtern => AktuelleAuswahl,
                    ViewnummerExtern => 3,
                    RasseExtern      => RasseExtern);
      
      Aktuell (RasseExtern      => RasseExtern,
               ViewnummerExtern => 4);
      
   end ForschungAnzeige;
   
   
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
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
                                                      TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert));
               
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                             position => Textposition);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop AnzeigeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).height));
      
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
            
            Forschungswert := LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                             IDExtern                => TechnologieSchleifenwert,
                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert);
            
            if
              Forschungswert = ZusatztextExtern
            then
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                             position => Textposition);
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                  str  => ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => TechnologieSchleifenwert,
                                                                                                           RasseExtern => RasseExtern));
               
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
           ZusatztextExtern = LeseEinheitenDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                    IDExtern    => EinheitenSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => EinheitenSchleifenwert,
                                                                                                       RasseExtern => RasseExtern));
               
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
           ZusatztextExtern = LeseGebaeudeDatenbank.Anforderungen (RasseExtern => RasseExtern,
                                                                   IDExtern    => GebäudeSchleifenwert)
         then
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                          position => Textposition);
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                               str  => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern    => GebäudeSchleifenwert,
                                                                                                      RasseExtern => RasseExtern));
            
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
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Ermöglicht;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                          position => Textposition);
      
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => ForschungsbeschreibungenGrafik.Langbeschreibung (IDExtern    => ZusatztextExtern,
                                                                                                                                                                                       RasseExtern => RasseExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewnummerExtern).x / 2.00 - Textposition.x));
      
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern));
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, ZusatztextExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
            Viewfläche (ViewnummerExtern) := Textposition;
      end case;
              
   end Beschreibung;
   
   
   
   procedure Aktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => AktuellesForschungsprojekt,
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
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
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
                                                                              ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                  TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Aktuell;

end ForschungsauswahlGrafik;
