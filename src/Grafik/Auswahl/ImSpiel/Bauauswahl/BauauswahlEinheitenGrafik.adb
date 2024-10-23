with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with GrafikDatentypen;
with TextnummernKonstanten;
with Spieltexte;
with TextaccessVariablen;
with ProduktionDatentypen;
with EinheitenKonstanten;
with TextKonstanten;
with ViewKonstanten;

with LeseEinheitenDatenbank;

with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with ZeilenumbruchberechnungGrafik;
with EinheitenbeschreibungenGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

package body BauauswahlEinheitenGrafik is

   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type EinheitenDatentypen.Transport_Enum;
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      ViewflächeInformationen := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeInformationen,
                                                                                   VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüInformationen).width,
                                                                                                         GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüInformationen).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüInformationen),
                                            GrößeExtern          => ViewflächeInformationen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüInformationen));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                    AbmessungenExtern => ViewflächeInformationen);
      
      case
        AuswahlExtern
      is
         when EinheitenKonstanten.LeerID =>
            Einheitenbeschreibung (AuswahlExtern => AuswahlExtern,
                                   SpeziesExtern => SpeziesExtern);
            return;
         
         when others =>
            null;
      end case;
      
      Einheitentexte (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                              IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (2) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                            IDExtern           => AuswahlExtern,
                                                                                                                                            WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Einheitentexte (3) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                        IDExtern           => AuswahlExtern,
                                                                                                                                        WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Einheitentexte (4) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten) & LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                               IDExtern           => AuswahlExtern,
                                                                                                                                               WelcheKostenExtern => ProduktionDatentypen.Material_Enum)'Wide_Wide_Image;
      Einheitentexte (5) := Spieltexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => SpeziesExtern,
                                                                                                                                    IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (6) := Spieltexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => SpeziesExtern,
                                                                                                                                          IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (7) := Spieltexte.Zeug (TextnummernKonstanten.ZeugAngriff) & LeseEinheitenDatenbank.Angriff (SpeziesExtern => SpeziesExtern,
                                                                                                                  IDExtern      => AuswahlExtern)'Wide_Wide_Image;
      Einheitentexte (8) := Spieltexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => SpeziesExtern,
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
         Einheitentexte (9) := Spieltexte.Zeug (TextnummernKonstanten.ZeugTransportergröße) & " "
           & Spieltexte.Zeug (TextnummernKonstanten.ZeugKlein - 1 + EinheitenDatentypen.Transport_Vorhanden_Enum'Pos (Transportgröße));
         Einheitentexte (10) := Spieltexte.Zeug (TextnummernKonstanten.ZeugTransportkapazität) & Transportkapazität'Wide_Wide_Image;
      end if;
      
      Transportgröße := LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                                          IDExtern      => AuswahlExtern);
      
      case
        Transportgröße
      is
         when EinheitenKonstanten.LeerKannTransportiertWerden =>
            Einheitentexte (11) := TextKonstanten.LeerUnboundedString;
            
         when others =>
            Einheitentexte (11) := Spieltexte.Zeug (TextnummernKonstanten.ZeugEinheitengröße) & " "
              & Spieltexte.Zeug (TextnummernKonstanten.ZeugKlein - 1 + EinheitenDatentypen.Transport_Vorhanden_Enum'Pos (Transportgröße));
      end case;
      
      YPosition := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      InformationenSchleife:
      for InformationSchleifenwert in Einheitentexte'Range loop
         
         YPosition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Einheitentexte (InformationSchleifenwert)),
                                                                                        TextpositionExtern       => (TextberechnungenBreiteGrafik.WinzigerSpaltenabstand, YPosition),
                                                                                        MaximaleTextbreiteExtern => ViewflächeInformationen.x,
                                                                                        TextAccessExtern         => TextaccessVariablen.EinheitenbauinformationenAccess);
         
      end loop InformationenSchleife;
      
      ViewflächeInformationen.y := YPosition + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Einheitenbeschreibung (AuswahlExtern => AuswahlExtern,
                             SpeziesExtern => SpeziesExtern);
            
   end Einheiteninformationen;
   
   
   
   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      ViewflächeBeschreibung := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeBeschreibung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).width,
                                                                                                        GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüBeschreibung),
                                            GrößeExtern          => ViewflächeBeschreibung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                    AbmessungenExtern => ViewflächeBeschreibung);
      
      case
        AuswahlExtern
      is
         when EinheitenKonstanten.LeerID =>
            null;
            
         when others =>
            YPosition := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
            -- Sollche Konstrukte mal auseinanderziehen, damit es übersichtlicher ist. äöü
            YPosition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               =>
                                                                                              ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                                             (TextExtern           => EinheitenbeschreibungenGrafik.Langbeschreibung (IDExtern      => AuswahlExtern,
                                                                                                                                                                      SpeziesExtern => SpeziesExtern),
                                                                                              TextfeldbreiteExtern => ViewflächeBeschreibung.x,
                                                                                              BreitenabzugExtern   => TextberechnungenBreiteGrafik.WinzigerSpaltenabstand),
                                                                                           TextpositionExtern       => (TextberechnungenBreiteGrafik.WinzigerSpaltenabstand, YPosition),
                                                                                           MaximaleTextbreiteExtern => ViewflächeBeschreibung.x,
                                                                                           TextAccessExtern         => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesExtern, AuswahlExtern));
      
            ViewflächeBeschreibung.y := YPosition + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      end case;
      
   end Einheitenbeschreibung;

end BauauswahlEinheitenGrafik;
