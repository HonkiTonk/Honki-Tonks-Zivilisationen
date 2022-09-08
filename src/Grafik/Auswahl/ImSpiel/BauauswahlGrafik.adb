pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;

with LeseStadtGebaut;

with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with InteraktionAuswahl;
with TextberechnungenHoeheGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with AllgemeineViewsGrafik;
with TextfarbeGrafik;
with ZeilenumbruchberechnungGrafik;

-- Kann man das so anpassen oder Teile davon auslagern, dass eine teilweise Verschmelzung mit VerkaufsauswahlGrafik möglich wäre? äöü
package body BauauswahlGrafik is

   procedure Bauauswahl
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageBauprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum);
      
      Gebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                ViewnummerExtern => 1,
                RasseExtern      => StadtRasseNummerExtern.Rasse);
      Einheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                 ViewnummerExtern => 2,
                 RasseExtern      => StadtRasseNummerExtern.Rasse);
      InformationenGebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                             ViewnummerExtern => 3,
                             RasseExtern      => StadtRasseNummerExtern.Rasse);
      InformationenEinheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                              ViewnummerExtern => 4,
                              RasseExtern      => StadtRasseNummerExtern.Rasse);
      Aktuell (StadtRasseNummerExtern => StadtRasseNummerExtern,
               ViewnummerExtern       => 5);
      
   end Bauauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                                                              ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                    position => Textposition);
      TextfarbeGrafik.Standardfarbe (TextaccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)));
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)));
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                                                                  TextbreiteExtern => 0.00);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                      AuswahlExtern    => Natural (AuswahlExtern),
                                                      TextaccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                       ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                             position => Textposition);
                                                                      
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Gebäude;
   
   
   
   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                                                              ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                    position => Textposition);
      TextfarbeGrafik.Standardfarbe (TextaccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)));
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)));
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                                                                  TextbreiteExtern => 0.00);
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (EinheitenSchleifenwert),
                                                      AuswahlExtern    => Natural (AuswahlExtern),
                                                      TextaccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));
               
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                                       ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                             position => Textposition);
               
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Einheiten;



   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                                 VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                  GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
            HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Meldung_Hintergrund_Enum,
                                           AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                          position => Textposition);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => GebaeudebeschreibungenGrafik.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                                     RasseExtern => RasseExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewnummerExtern).x / 2.00 - Textposition.x));
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern));
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
            Viewfläche (ViewnummerExtern) := Textposition;
      end case;
            
   end InformationenGebäude;



   procedure InformationenEinheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                                 VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                  GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
            HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Meldung_Hintergrund_Enum,
                                           AbmessungenExtern => Viewfläche (ViewnummerExtern));
            
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                          position => Textposition);

            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => EinheitenbeschreibungenGrafik.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                                      RasseExtern => RasseExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewnummerExtern).x / 2.00 - Textposition.x));
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern));
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
            Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      end case;
      
   end InformationenEinheiten;
   
   
   
   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                                    VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        AktuellesBauprojekt.Gebäude /= 0
      then
         Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GebaeudebeschreibungenGrafik.BeschreibungKurz (IDExtern    => AktuellesBauprojekt.Gebäude,
                                                                                                                                  RasseExtern => StadtRasseNummerExtern.Rasse);
         
      elsif
        AktuellesBauprojekt.Einheit /= 0
      then
         Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => AktuellesBauprojekt.Einheit,
                                                                                                                                   RasseExtern => StadtRasseNummerExtern.Rasse);
         
            
      else
         Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeines);
      end if;
      
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
      
      Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
      
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
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Aktuell;

end BauauswahlGrafik;
