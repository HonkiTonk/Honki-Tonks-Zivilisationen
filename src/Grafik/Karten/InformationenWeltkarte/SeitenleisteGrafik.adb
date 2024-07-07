with StadtKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with ViewKonstanten;
with SystemDatentypen;
with SpeziesKonstanten;
with StadtDatentypen;
with EinheitenDatentypen;
with Views;
with GrafikDatentypen;

with LeseWeltkarte;
with LeseCursor;

with StadtSuchenLogik;
with EinheitSuchenLogik;
with StadtseitenleisteGrafik;
with EinheitenseitenleisteGrafik;
with WichtigesSeitenleisteGrafik;
with AllgemeinesSeitenleisteGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with UebergabeRecordErmittelnGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with ViewbereicheBerechnenGrafik;

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.Städtebereich;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      Viewbereich.Viewbereich := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => Viewbereich.Viewbereich,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).width,
                                                                                                        GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).height));
            
      case
        ViewbereicheBerechnenGrafik.ViewbereicheVergleichen (ViewbereicheExtern => Viewbereich)
      is
         when False =>
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste),
                                                  GrößeExtern          => Viewbereich.Viewbereich,
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste));
         
            Viewbereich.ViewbereichAlt := Viewbereich.Viewbereich;
         
         when True =>
            ViewsEinstellenGrafik.ViewSetzen (ViewExtern => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste));
      end case;
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewbereich.Viewbereich);
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      Textposition := (TextberechnungenBreiteGrafik.WinzigerSpaltenabstand, TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      Textposition.y := WichtigesSeitenleisteGrafik.WichtigesInformationen (SpeziesExtern            => SpeziesExtern,
                                                                            KoordinatenExtern        => AktuelleKoordinaten,
                                                                            TextpositionExtern       => Textposition,
                                                                            MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
      
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
        or
          False = LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                          SpeziesExtern     => SpeziesExtern)
      then
         Textposition.y := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern            => SpeziesKonstanten.LeerSpezies,
                                                                                  TextpositionExtern       => Textposition,
                                                                                  MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
            
         Textposition.y := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesKonstanten.LeerSpezies,
                                                          StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt),
                                                          TextpositionExtern       => Textposition,
                                                          MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
         
         -- Wie bei der Stadt einfach die ganze Einheit übergeben? äöü
         Textposition.y := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesKonstanten.LeerSpezies,
                                                                  EinheitSpeziesNummerExtern => EinheitenKonstanten.LeerEinheit,
                                                                  TextpositionExtern         => Textposition,
                                                                  MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
            
      else
         Textposition.y := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern            => SpeziesExtern,
                                                                                  TextpositionExtern       => Textposition,
                                                                                  MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
            
         StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten);
         EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                         TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
         
         if
           StadtSpeziesNummer.Nummer = StadtKonstanten.LeerNummer
           and
             EinheitSpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
         then
            Textposition.y := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesExtern,
                                                                     EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                                     TextpositionExtern         => Textposition,
                                                                     MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
               
            Textposition.y := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesExtern,
                                                             StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                             TextpositionExtern       => Textposition,
                                                             MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
               
         else
            Textposition.y := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesExtern,
                                                             StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                             TextpositionExtern       => Textposition,
                                                             MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
               
            Textposition.y := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesExtern,
                                                                     EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                                     TextpositionExtern         => Textposition,
                                                                     MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
         end if;
      end if;
      
      Viewbereich.Viewbereich.y := Textposition.y;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
