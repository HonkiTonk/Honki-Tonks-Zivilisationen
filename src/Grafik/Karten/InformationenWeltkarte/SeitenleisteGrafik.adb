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

package body SeitenleisteGrafik is

   -- Textpositionsinformationen.x = XPosition, Textpositionsinformationen.y = YPosition, Textpositionsinformationen.z = Textbreite
   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.Städtebereich;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).width,
                                                                                              GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).height));
         
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      
      Textpositionsinformationen := WichtigesSeitenleisteGrafik.WichtigesInformationen (SpeziesExtern     => SpeziesExtern,
                                                                                        KoordinatenExtern => AktuelleKoordinaten);
      
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
        or
          False = LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                          SpeziesExtern     => SpeziesExtern)
      then
         Textpositionsinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                                                              TextpositionsinformationenExtern => Textpositionsinformationen);
            
         Textpositionsinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                                      StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt),
                                                                      TextpositionsinformationenExtern => Textpositionsinformationen);
            
         Textpositionsinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                                              EinheitSpeziesNummerExtern       => EinheitenKonstanten.LeerEinheit,
                                                                              TextpositionsinformationenExtern => Textpositionsinformationen);
            
      else
         Textpositionsinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern                    => SpeziesExtern,
                                                                                              TextpositionsinformationenExtern => Textpositionsinformationen);
            
         StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten);
         EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                         TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
         if
           StadtSpeziesNummer.Nummer = StadtKonstanten.LeerNummer
           and
             EinheitSpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
         then
            Textpositionsinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesExtern,
                                                                                 EinheitSpeziesNummerExtern       => EinheitSpeziesNummer,
                                                                                 TextpositionsinformationenExtern => Textpositionsinformationen);
               
            Textpositionsinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesExtern,
                                                                         StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                         TextpositionsinformationenExtern => Textpositionsinformationen);
               
         else
            Textpositionsinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesExtern,
                                                                         StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                         TextpositionsinformationenExtern => Textpositionsinformationen);
               
            Textpositionsinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesExtern,
                                                                                 EinheitSpeziesNummerExtern       => EinheitSpeziesNummer,
                                                                                 TextpositionsinformationenExtern => Textpositionsinformationen);
         end if;
      end if;
      
      Viewfläche := (Textpositionsinformationen.z, Textpositionsinformationen.y);
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
