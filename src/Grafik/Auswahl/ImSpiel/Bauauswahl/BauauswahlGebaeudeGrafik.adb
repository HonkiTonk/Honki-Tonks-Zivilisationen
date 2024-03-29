with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Spieltexte;
with TextaccessVariablen;
with ProduktionDatentypen;
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
with TextaccessverwaltungssystemEinfachGrafik;

package body BauauswahlGebaeudeGrafik is

   procedure Gebäudeinformationen
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
            Gebäudetexte (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                                  IDExtern      => AuswahlExtern)'Wide_Wide_Image;
            Gebäudetexte (2) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                                IDExtern           => AuswahlExtern,
                                                                                                                                                WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
            Gebäudetexte (3) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                            IDExtern           => AuswahlExtern,
                                                                                                                                            WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
            Gebäudetexte (4) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten)
              & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                        IDExtern           => AuswahlExtern,
                                                        WelcheKostenExtern => ProduktionDatentypen.Material_Enum)'Wide_Wide_Image;
            Gebäudetexte (5) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus)
              & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                        IDExtern               => AuswahlExtern,
                                                        ProduktionsbonusExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
            Gebäudetexte (6) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus)
              & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                        IDExtern               => AuswahlExtern,
                                                        ProduktionsbonusExtern => ProduktionDatentypen.Material_Enum)'Wide_Wide_Image;
            Gebäudetexte (7) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                                                                                                            IDExtern               => AuswahlExtern,
                                                                                                                                            ProduktionsbonusExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
            Gebäudetexte (8) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus)
              & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                        IDExtern               => AuswahlExtern,
                                                        ProduktionsbonusExtern => ProduktionDatentypen.Forschung_Enum)'Wide_Wide_Image;
            
            Gebäudetexte (9) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & " "
              & KommazahlAlsString (KommazahlExtern => (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                          IDExtern         => AuswahlExtern,
                                                                                          KampfBonusExtern => KampfDatentypen.Verteidigung_Enum)));
            Gebäudetexte (10) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & " "
              & KommazahlAlsString (KommazahlExtern => (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                          IDExtern         => AuswahlExtern,
                                                                                          KampfBonusExtern => KampfDatentypen.Angriff_Enum)));
            
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            Textbreite := GrafikKonstanten.Nullwert;
      end case;
            
      InformationenSchleife:
      for InformationSchleifenwert in Gebäudetexte'Range loop
         
         TextaccessverwaltungssystemEinfachGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.GebäudebauinformationenAccess,
                                                                             TextExtern       => To_Wide_Wide_String (Source => Gebäudetexte (InformationSchleifenwert)),
                                                                             PositionExtern   => Textposition,
                                                                             FarbeExtern      => TextfarbeGrafik.Standardfarbe);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudebauinformationenAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      ViewflächeInformationen := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      Gebäudebeschreibung (AuswahlExtern     => AuswahlExtern,
                            SpeziesExtern     => SpeziesExtern,
                            ViewbereichExtern => ViewbereichExtern + 1);
      
   end Gebäudeinformationen;
   
   
   
   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ViewbereichExtern : in Positive)
   is
      use type Sf.System.Vector2.sfVector2f;
   begin
      
      ViewbereichBeschreibung.Viewbereich := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewbereichBeschreibung.Viewbereich,
                                                                                                VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).width,
                                                                                                                      GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern).height));
      
      if
        ViewbereichBeschreibung.Viewbereich /= ViewbereichBeschreibung.ViewbereichAlt
      then
         ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewbereichExtern),
                                               GrößeExtern          => ViewbereichBeschreibung.Viewbereich,
                                               AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewbereichExtern));
         
         ViewbereichBeschreibung.ViewbereichAlt := ViewbereichBeschreibung.Viewbereich;
         
      else
         ViewsEinstellenGrafik.ViewSetzen (ViewExtern => Views.BauviewAccesse (ViewbereichExtern));
      end if;
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewbereichBeschreibung.Viewbereich);
      
      case
        AuswahlExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            null;
         
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            
            TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                           TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                             (TextExtern           => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern    => AuswahlExtern,
                                                                                                                                                     SpeziesExtern => SpeziesExtern),
                                                                              TextfeldbreiteExtern => ViewbereichBeschreibung.Viewbereich.x,
                                                                              BreitenabzugExtern   => Textposition.x),
                                                                           PositionExtern   => Textposition);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
            ViewbereichBeschreibung.Viewbereich := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      end case;
      
   end Gebäudebeschreibung;

end BauauswahlGebaeudeGrafik;
