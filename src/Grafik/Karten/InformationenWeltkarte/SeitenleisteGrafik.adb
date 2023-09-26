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

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.Städtebereich;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).width,
                                                                                            GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      
      Textinformationen := WichtigesSeitenleisteGrafik.WichtigesInformationen (SpeziesExtern            => SpeziesExtern,
                                                                               KoordinatenExtern        => AktuelleKoordinaten,
                                                                               MaximaleTextbreiteExtern => Viewfläche.x);
      
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
        or
          False = LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                          SpeziesExtern     => SpeziesExtern)
      then
         Textinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                                                     TextpositionsinformationenExtern => Textinformationen,
                                                                                     MaximaleTextbreiteExtern         => Viewfläche.x);
            
         Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                             StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt),
                                                             TextpositionsinformationenExtern => Textinformationen,
                                                             MaximaleTextbreiteExtern         => Viewfläche.x);
            
         Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesKonstanten.LeerSpezies,
                                                                     EinheitSpeziesNummerExtern       => EinheitenKonstanten.LeerEinheit,
                                                                     TextpositionsinformationenExtern => Textinformationen,
                                                                     MaximaleTextbreiteExtern         => Viewfläche.x);
            
      else
         Textinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern                    => SpeziesExtern,
                                                                                     TextpositionsinformationenExtern => Textinformationen,
                                                                                     MaximaleTextbreiteExtern         => Viewfläche.x);
            
         StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten);
         EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                         TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
         if
           StadtSpeziesNummer.Nummer = StadtKonstanten.LeerNummer
           and
             EinheitSpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
         then
            Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesExtern,
                                                                        EinheitSpeziesNummerExtern       => EinheitSpeziesNummer,
                                                                        TextpositionsinformationenExtern => Textinformationen,
                                                                        MaximaleTextbreiteExtern         => Viewfläche.x);
               
            Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesExtern,
                                                                StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                TextpositionsinformationenExtern => Textinformationen,
                                                                MaximaleTextbreiteExtern         => Viewfläche.x);
               
         else
            Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern                    => SpeziesExtern,
                                                                StadtauswahlExtern               => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                TextpositionsinformationenExtern => Textinformationen,
                                                                MaximaleTextbreiteExtern         => Viewfläche.x);
               
            Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern                    => SpeziesExtern,
                                                                        EinheitSpeziesNummerExtern       => EinheitSpeziesNummer,
                                                                        TextpositionsinformationenExtern => Textinformationen,
                                                                        MaximaleTextbreiteExtern         => Viewfläche.x);
         end if;
      end if;
      
      LeerzeilenSchleife:
      while Textinformationen.Leerzeilen > 0 loop
         
         Textinformationen.Textpositionsinformationen.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textinformationen.Textpositionsinformationen.y,
                                                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textinformationen.Leerzeilen := Textinformationen.Leerzeilen - 1;
         
      end loop LeerzeilenSchleife;
      
      -- .x = Textanfangsposition XAchse, .y = Aktuellen Textposition YAchse, .z = Aktuelle Textbreite
      Viewfläche.y := Textinformationen.Textpositionsinformationen.y;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
