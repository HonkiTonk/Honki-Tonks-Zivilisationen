with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Meldungstexte;
with TextaccessVariablen;
with ProduktionDatentypen;
with KampfDatentypen;
with StadtKonstanten;
with GrafikKonstanten;

with LeseGebaeudeDatenbank;

with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with TextfarbeGrafik;
with ZeilenumbruchberechnungGrafik;
with GebaeudebeschreibungenGrafik;
with TextaccessverwaltungssystemGrafik;

package body BauauswahlGebaeudeGrafik is

   procedure Gebäudeinformationen
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ViewbereichExtern : in Positive)
   is begin
                  
      ViewflächeInformationen := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeInformationen,
                                                                                     VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).width,
                                                                                                           GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewbereichExtern),
                                            GrößeExtern          => ViewflächeInformationen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeInformationen);
      
      case
        AuswahlExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            Gebäudebeschreibung (AuswahlExtern     => AuswahlExtern,
                                  SpeziesExtern     => SpeziesExtern,
                                  ViewbereichExtern => ViewbereichExtern + 1);
            return;
         
         when others =>
            Gebäudetexte (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                                     IDExtern      => AuswahlExtern)'Wide_Wide_Image;
            Gebäudetexte (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                                   IDExtern           => AuswahlExtern,
                                                                                                                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
            Gebäudetexte (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                               IDExtern           => AuswahlExtern,
                                                                                                                                               WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
            Gebäudetexte (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten)
              & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                        IDExtern           => AuswahlExtern,
                                                        WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
            Gebäudetexte (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => SpeziesExtern,
                                                                                                                                                  IDExtern              => AuswahlExtern,
                                                                                                                                                  WirtschaftBonusExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
            Gebäudetexte (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus)
              & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => SpeziesExtern,
                                                       IDExtern              => AuswahlExtern,
                                                       WirtschaftBonusExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
            Gebäudetexte (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => SpeziesExtern,
                                                                                                                                              IDExtern              => AuswahlExtern,
                                                                                                                                              WirtschaftBonusExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
            Gebäudetexte (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus) & LeseGebaeudeDatenbank.WirtschaftBonus (SpeziesExtern         => SpeziesExtern,
                                                                                                                                                IDExtern              => AuswahlExtern,
                                                                                                                                                WirtschaftBonusExtern => ProduktionDatentypen.Forschung_Enum)'Wide_Wide_Image;
            Gebäudetexte (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                                  IDExtern         => AuswahlExtern,
                                                                                                                                                  KampfBonusExtern => KampfDatentypen.Verteidigung_Enum)'Wide_Wide_Image;
            Gebäudetexte (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                              IDExtern         => AuswahlExtern,
                                                                                                                                              KampfBonusExtern => KampfDatentypen.Angriff_Enum)'Wide_Wide_Image;
      
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            Textbreite := GrafikKonstanten.Nullwert;
      end case;
      
      InformationenSchleife:
      for InformationSchleifenwert in GebäudetexteArray'Range loop
         
         TextaccessverwaltungssystemGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                                      TextExtern       => To_Wide_Wide_String (Source => Gebäudetexte (InformationSchleifenwert)),
                                                                      PositionExtern   => Textposition,
                                                                      FarbeExtern      => TextfarbeGrafik.Standardfarbe);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      ViewflächeInformationen := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Gebäudebeschreibung (AuswahlExtern     => AuswahlExtern,
                            SpeziesExtern     => SpeziesExtern,
                            ViewbereichExtern => ViewbereichExtern + 1);
      
   end Gebäudeinformationen;
   
   
   
   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ViewbereichExtern : in Positive)
   is begin
      
      ViewflächeBeschreibung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBeschreibung,
                                                                                    VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).width,
                                                                                                          GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewbereichExtern),
                                            GrößeExtern          => ViewflächeBeschreibung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBeschreibung);
      
      case
        AuswahlExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            null;
         
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
            
            TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                    TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                      (TextExtern           => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern    => AuswahlExtern,
                                                                                                                                              SpeziesExtern => SpeziesExtern),
                                                                       TextfeldbreiteExtern => ViewflächeBeschreibung.x / GrafikKonstanten.Halbierung - Textposition.x),
                                                                    PositionExtern   => Textposition);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
            ViewflächeBeschreibung := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      end case;
      
   end Gebäudebeschreibung;

end BauauswahlGebaeudeGrafik;
