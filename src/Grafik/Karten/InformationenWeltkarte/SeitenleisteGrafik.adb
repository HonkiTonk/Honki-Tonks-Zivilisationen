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

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.Städtebereich;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      Viewbereich.Viewbereich := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => Viewbereich.Viewbereich,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).width,
                                                                                                        GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste).height));
      
      ViewbereicheIdentisch := ViewbereicheVergleichen (ViewbereicheExtern => Viewbereich);
      
      case
        ViewbereicheIdentisch
      is
         when False =>
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste),
                                                  GrößeExtern          => Viewbereich.Viewbereich,
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltSeitenleiste));
         
            Viewbereich.ViewbereichAlt := Viewbereich.Viewbereich;
         
         when True =>
            ViewsEinstellenGrafik.ViewSetzen (ViewExtern => Views.WeltkarteAccesse (ViewKonstanten.WeltSeitenleiste));
      end case;
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewbereich.Viewbereich);
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      XPositionText := TextberechnungenBreiteGrafik.WinzigerSpaltenabstand;
      Textinformationen.YPosition := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textinformationen.Leerzeilen := 0;
      
      Textinformationen := WichtigesSeitenleisteGrafik.WichtigesInformationen (SpeziesExtern            => SpeziesExtern,
                                                                               KoordinatenExtern        => AktuelleKoordinaten,
                                                                               TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                                               LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                                               MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
      
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
        or
          False = LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                          SpeziesExtern     => SpeziesExtern)
      then
         Textinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern            => SpeziesKonstanten.LeerSpezies,
                                                                                     TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                                                     LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                                                     MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
            
         Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesKonstanten.LeerSpezies,
                                                             StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt),
                                                             TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                             LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                             MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
         
         -- Wie bei der Stadt einfach die ganze Einheit übergeben? äöü
         Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesKonstanten.LeerSpezies,
                                                                     EinheitSpeziesNummerExtern => EinheitenKonstanten.LeerEinheit,
                                                                     TextpositionExtern         => (XPositionText, Textinformationen.YPosition),
                                                                     LeerzeilenExtern           => Textinformationen.Leerzeilen,
                                                                     MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
            
      else
         Textinformationen := AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern            => SpeziesExtern,
                                                                                     TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                                                     LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                                                     MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
            
         StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten);
         EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                         TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
         if
           StadtSpeziesNummer.Nummer = StadtKonstanten.LeerNummer
           and
             EinheitSpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
         then
            Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesExtern,
                                                                        EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                                        TextpositionExtern         => (XPositionText, Textinformationen.YPosition),
                                                                        LeerzeilenExtern           => Textinformationen.Leerzeilen,
                                                                        MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
               
            Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesExtern,
                                                                StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                                LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                                MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
               
         else
            Textinformationen := StadtseitenleisteGrafik.Stadt (SpeziesExtern            => SpeziesExtern,
                                                                StadtauswahlExtern       => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                                TextpositionExtern       => (XPositionText, Textinformationen.YPosition),
                                                                LeerzeilenExtern         => Textinformationen.Leerzeilen,
                                                                MaximaleTextbreiteExtern => Viewbereich.Viewbereich.x);
               
            Textinformationen := EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesExtern,
                                                                        EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                                        TextpositionExtern         => (XPositionText, Textinformationen.YPosition),
                                                                        LeerzeilenExtern           => Textinformationen.Leerzeilen,
                                                                        MaximaleTextbreiteExtern   => Viewbereich.Viewbereich.x);
         end if;
      end if;
      
      LeerzeilenSchleife:
      while Textinformationen.Leerzeilen > 0 loop
         
         Textinformationen.YPosition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textinformationen.YPosition,
                                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
         Textinformationen.Leerzeilen := Textinformationen.Leerzeilen - 1;
         
      end loop LeerzeilenSchleife;
      
      Viewbereich.Viewbereich.y := Textinformationen.YPosition;
      
   end SeitenleisteGrafik;
   
   
   
   function ViewbereicheVergleichen
     (ViewbereicheExtern : in GrafikRecords.ViewbereichRecord)
      return Boolean
   is begin
      
      if
        ViewbereicheExtern.Viewbereich.x /= ViewbereicheExtern.ViewbereichAlt.x
        or
          ViewbereicheExtern.Viewbereich.y /= ViewbereicheExtern.ViewbereichAlt.y
      then
         return False;
         
      else
         return True;
      end if;
      
   end ViewbereicheVergleichen;

end SeitenleisteGrafik;
