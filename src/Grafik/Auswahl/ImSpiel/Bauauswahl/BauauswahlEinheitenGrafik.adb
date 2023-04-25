with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Meldungstexte;
with TextaccessVariablen;
with ProduktionDatentypen;
with EinheitenKonstanten;
with TextKonstanten;
with ViewKonstanten;
with GrafikKonstanten;

with LeseEinheitenDatenbank;

with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with TextfarbeGrafik;
with ZeilenumbruchberechnungGrafik;
with EinheitenbeschreibungenGrafik;
with TextaccessverwaltungssystemGrafik;

package body BauauswahlEinheitenGrafik is

   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.Transport_Enum;
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      ViewflächeInformationen := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeInformationen,
                                                                                     VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheiteninformationen).width,
                                                                                                           GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheiteninformationen).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheiteninformationen),
                                            GrößeExtern          => ViewflächeInformationen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheiteninformationen));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeInformationen);
      
      Einheitentexte (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                                 IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                               IDExtern           => AuswahlExtern,
                                                                                                                                               WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Einheitentexte (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                           IDExtern           => AuswahlExtern,
                                                                                                                                           WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Einheitentexte (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                                  IDExtern           => AuswahlExtern,
                                                                                                                                                  WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)'Wide_Wide_Image;
      Einheitentexte (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => SpeziesExtern,
                                                                                                                                       IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => SpeziesExtern,
                                                                                                                                             IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) & LeseEinheitenDatenbank.Angriff (SpeziesExtern => SpeziesExtern,
                                                                                                                     IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => SpeziesExtern,
                                                                                                                               IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      
      Transportgröße := LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                                     IDExtern      => AuswahlExtern);
      
      Transportkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => SpeziesExtern,
                                                                         IDExtern      => AuswahlExtern);
      
      if
        Transportgröße = EinheitenKonstanten.LeerKannTransportieren
        or
          Transportkapazität = 0
      then
         Einheitentexte (9) := TextKonstanten.LeerUnboundedString;
         Einheitentexte (10) := TextKonstanten.LeerUnboundedString;
            
      else
         Einheitentexte (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugTransportergröße) & " "
           & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKlein - 1 + EinheitenDatentypen.Transport_Vorhanden_Enum'Pos (Transportgröße));
         Einheitentexte (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugTransportkapazität) & Transportkapazität'Wide_Wide_Image;
      end if;
      
      Transportgröße := LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                                          IDExtern      => AuswahlExtern);
      
      case
        Transportgröße
      is
         when EinheitenKonstanten.LeerKannTransportiertWerden =>
            Einheitentexte (11) := TextKonstanten.LeerUnboundedString;
            
         when others =>
            Einheitentexte (11) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinheitengröße) & " "
              & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKlein - 1 + EinheitenDatentypen.Transport_Vorhanden_Enum'Pos (Transportgröße));
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;
      
      InformationenSchleife:
      for InformationSchleifenwert in EinheitentexteArray'Range loop
         
         TextaccessverwaltungssystemGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                                      TextExtern       => To_Wide_Wide_String (Source => Einheitentexte (InformationSchleifenwert)),
                                                                      PositionExtern   => Textposition,
                                                                      FarbeExtern      => TextfarbeGrafik.Standardfarbe);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      ViewflächeInformationen := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Einheitenbeschreibung (AuswahlExtern => AuswahlExtern,
                             SpeziesExtern => SpeziesExtern);
            
   end Einheiteninformationen;
   
   
   
   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      ViewflächeBeschreibung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBeschreibung,
                                                                                    VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenbeschreibung).width,
                                                                                                          GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenbeschreibung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheitenbeschreibung),
                                            GrößeExtern          => ViewflächeBeschreibung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenbeschreibung));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBeschreibung);
            
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                              TextExtern       => 
                                                                ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => EinheitenbeschreibungenGrafik.Langbeschreibung
                                                                                                                       (IDExtern      => AuswahlExtern,
                                                                                                                        SpeziesExtern => SpeziesExtern),
                                                                                                                       TextfeldbreiteExtern => ViewflächeBeschreibung.x / GrafikKonstanten.Halbierung - Textposition.x),
                                                              PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      ViewflächeBeschreibung := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheitenbeschreibung;

end BauauswahlEinheitenGrafik;
