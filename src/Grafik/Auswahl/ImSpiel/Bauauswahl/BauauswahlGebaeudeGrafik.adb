pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Meldungstexte;
with TextaccessVariablen;
with ProduktionDatentypen;
with KartenDatentypen;

with LeseGebaeudeDatenbank;

with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with TextfarbeGrafik;
with ZeilenumbruchberechnungGrafik;
with EinstellungenGrafik;
with GebaeudebeschreibungenGrafik;

package body BauauswahlGebaeudeGrafik is

   procedure Gebäudeinformationen
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
                  
      ViewflächeInformationen := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeInformationen,
                                                                                     VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                           GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => ViewflächeInformationen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeInformationen);
      
      Gebäudetexte (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.Produktionskosten (RasseExtern => RasseExtern,
                                                                                                                             IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Gebäudetexte (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                             IDExtern           => AuswahlExtern,
                                                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                         IDExtern           => AuswahlExtern,
                                                                                                                                         WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                                                                IDExtern           => AuswahlExtern,
                                                                                                                                                WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetexte (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                            IDExtern               => AuswahlExtern,
                                                                                                                                            WWirtschaftBonusExtern => KartenDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                               IDExtern               => AuswahlExtern,
                                                                                                                                               WWirtschaftBonusExtern => KartenDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetexte (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                        IDExtern               => AuswahlExtern,
                                                                                                                                        WWirtschaftBonusExtern => KartenDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => RasseExtern,
                                                                                                                                          IDExtern               => AuswahlExtern,
                                                                                                                                          WWirtschaftBonusExtern => KartenDatentypen.Forschung_Enum)'Wide_Wide_Image;
      Gebäudetexte (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => RasseExtern,
                                                                                                                                            IDExtern         => AuswahlExtern,
                                                                                                                                            KampfBonusExtern => KartenDatentypen.Verteidigung_Enum)'Wide_Wide_Image;
      Gebäudetexte (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => RasseExtern,
                                                                                                                                        IDExtern         => AuswahlExtern,
                                                                                                                                        KampfBonusExtern => KartenDatentypen.Angriff_Enum)'Wide_Wide_Image;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
      InformationenSchleife:
      for InformationSchleifenwert in GebäudetexteArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => To_Wide_Wide_String (Source => Gebäudetexte (InformationSchleifenwert)));
         
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
      
      ViewflächeInformationen := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Gebäudebeschreibung (AuswahlExtern    => AuswahlExtern,
                            ViewnummerExtern => ViewnummerExtern + 1,
                            RasseExtern      => RasseExtern);
            
   end Gebäudeinformationen;
   
   
   
   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      ViewflächeBeschreibung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBeschreibung,
                                                                                    VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width,
                                                                                                          GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => ViewflächeBeschreibung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBeschreibung);
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                    position => Textposition);
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                         str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => GebaeudebeschreibungenGrafik.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                               RasseExtern => RasseExtern),
                                                                                                        TextfeldbreiteExtern => ViewflächeBeschreibung.x / 2.00 - Textposition.x));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern));
            
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      ViewflächeBeschreibung := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Gebäudebeschreibung;

end BauauswahlGebaeudeGrafik;
