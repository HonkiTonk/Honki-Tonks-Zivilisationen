pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;
with StadtKonstanten;
with EinheitenKonstanten;
with ProduktionDatentypen;
with KartenDatentypen;

with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseEinheitenDatenbank;

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
      
      case
        AktuelleAuswahlExtern.Gebäude
      is
         when StadtKonstanten.LeerGebäudeID =>
            Einheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                       ViewnummerExtern => 2,
                       RasseExtern      => StadtRasseNummerExtern.Rasse);
            
         when others =>
            Gebäudeinformationen (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                                   ViewnummerExtern => 3,
                                   RasseExtern      => StadtRasseNummerExtern.Rasse);
            Gebäudebeschreibung (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                                  ViewnummerExtern => 4,
                                  RasseExtern      => StadtRasseNummerExtern.Rasse);
      end case;
      
      case
        AktuelleAuswahlExtern.Einheit
      is
         when EinheitenKonstanten.LeerID =>
            Gebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                      ViewnummerExtern => 1,
                      RasseExtern      => StadtRasseNummerExtern.Rasse);
            
         when others =>
            Einheiteninformationen (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                                    ViewnummerExtern => 5,
                                    RasseExtern      => StadtRasseNummerExtern.Rasse);
            Einheitenbeschreibung (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                                   ViewnummerExtern => 6,
                                   RasseExtern      => StadtRasseNummerExtern.Rasse);
      end case;
      
      Aktuell (StadtRasseNummerExtern => StadtRasseNummerExtern,
               ViewnummerExtern       => 7);
      
   end Bauauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
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
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
               
               InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Gebäude;
   
   
   
   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
          
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
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      Viewfläche (ViewnummerExtern) := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheiten;



   procedure Gebäudeinformationen
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
                  
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Gebäudetext (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                                                            IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Gebäudetext (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                            IDExtern           => AuswahlExtern,
                                                                                                                                            WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetext (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                        IDExtern           => AuswahlExtern,
                                                                                                                                        WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetext (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                               IDExtern           => AuswahlExtern,
                                                                                                                                               WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetext (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                           IDExtern               => AuswahlExtern,
                                                                                                                                           WWirtschaftBonusExtern => KartenDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetext (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                              IDExtern               => AuswahlExtern,
                                                                                                                                              WWirtschaftBonusExtern => KartenDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetext (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                       IDExtern               => AuswahlExtern,
                                                                                                                                       WWirtschaftBonusExtern => KartenDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetext (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                         IDExtern               => AuswahlExtern,
                                                                                                                                         WWirtschaftBonusExtern => KartenDatentypen.Forschung_Enum)'Wide_Wide_Image;
      Gebäudetext (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => RasseExtern,
                                                                                                                                           IDExtern         => AuswahlExtern,
                                                                                                                                           KampfBonusExtern => KartenDatentypen.Verteidigung_Enum)'Wide_Wide_Image;
      Gebäudetext (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => RasseExtern,
                                                                                                                                       IDExtern         => AuswahlExtern,
                                                                                                                                       KampfBonusExtern => KartenDatentypen.Angriff_Enum)'Wide_Wide_Image;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
      InformationenSchleife:
      for InformationSchleifenwert in Gebäudetext'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => To_Wide_Wide_String (Source => Gebäudetext (InformationSchleifenwert)));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => Textposition);
         
         TextfarbeGrafik.Standardfarbe (TextaccessExtern => TextaccessVariablen.TextAccess);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      Viewfläche (ViewnummerExtern) := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
   end Gebäudeinformationen;
   
   
   
   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
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
      
      Viewfläche (ViewnummerExtern) := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Gebäudebeschreibung;



   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Einheitentext (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                                                              IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Einheitentext (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                              IDExtern           => AuswahlExtern,
                                                                                                                                              WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Einheitentext (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                          IDExtern           => AuswahlExtern,
                                                                                                                                          WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Einheitentext (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                                 IDExtern           => AuswahlExtern,
                                                                                                                                                 WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Einheitentext (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => RasseExtern,
                                                                                                                                      IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Einheitentext (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => RasseExtern,
                                                                                                                                            IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Einheitentext (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) & LeseEinheitenDatenbank.Angriff (RasseExtern => RasseExtern,
                                                                                                                    IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Einheitentext (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & LeseEinheitenDatenbank.Verteidigung (RasseExtern => RasseExtern,
                                                                                                                              IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Einheitentext (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung) & LeseEinheitenDatenbank.Transportkapazität (RasseExtern => RasseExtern,
                                                                                                                                       IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
      InformationenSchleife:
      for InformationSchleifenwert in Einheitentext'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => To_Wide_Wide_String (Source => Einheitentext (InformationSchleifenwert)));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => Textposition);
         
         TextfarbeGrafik.Standardfarbe (TextaccessExtern => TextaccessVariablen.TextAccess);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      Viewfläche (ViewnummerExtern) := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
   end Einheiteninformationen;
   
   
   
   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
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
      
      Viewfläche (ViewnummerExtern) := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheitenbeschreibung;
   
   
   
   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
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
         return;
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                              ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                          TextbreiteExtern => Textbreite);
      
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
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                          TextbreiteExtern => Textbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
            
      Viewfläche (ViewnummerExtern) := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Aktuell;

end BauauswahlGrafik;
