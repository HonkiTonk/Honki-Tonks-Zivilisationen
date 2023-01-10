with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Meldungstexte;
with TextaccessVariablen;
with ProduktionDatentypen;
with KampfDatentypen;
with ViewKonstanten;

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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
                  
      ViewflächeInformationen := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeInformationen,
                                                                                     VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeinformationen).width,
                                                                                                           GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeinformationen).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudeinformationen),
                                            GrößeExtern          => ViewflächeInformationen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeinformationen));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeInformationen);
      
      Gebäudetexte (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                             IDExtern    => AuswahlExtern)'Wide_Wide_Image;
      Gebäudetexte (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern        => SpeziesExtern,
                                                                                                                                             IDExtern           => AuswahlExtern,
                                                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern        => SpeziesExtern,
                                                                                                                                         IDExtern           => AuswahlExtern,
                                                                                                                                         WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern        => SpeziesExtern,
                                                                                                                                                IDExtern           => AuswahlExtern,
                                                                                                                                                WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetexte (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern            => SpeziesExtern,
                                                                                                                                            IDExtern               => AuswahlExtern,
                                                                                                                                            WirtschaftBonusExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus)
        & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern            => SpeziesExtern,
                                                 IDExtern               => AuswahlExtern,
                                                 WirtschaftBonusExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Gebäudetexte (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern            => SpeziesExtern,
                                                                                                                                        IDExtern               => AuswahlExtern,
                                                                                                                                        WirtschaftBonusExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern            => SpeziesExtern,
                                                                                                                                          IDExtern               => AuswahlExtern,
                                                                                                                                          WirtschaftBonusExtern => ProduktionDatentypen.Forschung_Enum)'Wide_Wide_Image;
      Gebäudetexte (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern      => SpeziesExtern,
                                                                                                                                            IDExtern         => AuswahlExtern,
                                                                                                                                            KampfBonusExtern => KampfDatentypen.Verteidigung_Enum)'Wide_Wide_Image;
      Gebäudetexte (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern      => SpeziesExtern,
                                                                                                                                        IDExtern         => AuswahlExtern,
                                                                                                                                        KampfBonusExtern => KampfDatentypen.Angriff_Enum)'Wide_Wide_Image;
      
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
                            SpeziesExtern      => SpeziesExtern);
            
   end Gebäudeinformationen;
   
   
   
   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      ViewflächeBeschreibung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBeschreibung,
                                                                                    VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudebeschreibung).width,
                                                                                                          GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudebeschreibung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudebeschreibung),
                                            GrößeExtern          => ViewflächeBeschreibung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudebeschreibung));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBeschreibung);
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                    position => Textposition);
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                         str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern    => AuswahlExtern,
                                                                                                                                                                               SpeziesExtern => SpeziesExtern),
                                                                                                        TextfeldbreiteExtern => ViewflächeBeschreibung.x / 2.00 - Textposition.x));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern));
            
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      ViewflächeBeschreibung := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Gebäudebeschreibung;

end BauauswahlGebaeudeGrafik;
