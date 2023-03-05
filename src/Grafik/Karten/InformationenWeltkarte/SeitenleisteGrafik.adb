with StadtKonstanten;
with EinheitenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartenRecordKonstanten;
with ViewKonstanten;

with LeseWeltkarte;
with LeseCursor;

with StadtSuchenLogik;
with EinheitSuchenLogik;
with StadtseitenleisteGrafik;
with EinheitenseitenleisteGrafik;
with WichtigesSeitenleisteGrafik;
with AllgemeinesSeitenleisteGrafik;
with SeitenleisteLeerenGrafik;
with UebergabeRecordErmittelnGrafik;

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      
      -- Ist der Cursor jemals Leer? Wenn nein, dann eventuell einbauen? äöü
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
      then
         return;
            
      else
         WichtigesSeitenleisteGrafik.WichtigesInformationen (SpeziesExtern     => SpeziesExtern,
                                                             KoordinatenExtern => AktuelleKoordinaten);
      end if;
      
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                SpeziesExtern     => SpeziesExtern)
      is
         when True =>
            AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (SpeziesExtern => SpeziesExtern);
                                    
            StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten);
      
            case
              StadtSpeziesNummer.Nummer
            is
               when StadtKonstanten.LeerNummer =>
                  Leerwert := StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                            ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltStadt),
                                                            ViewflächeExtern     => GrafikRecordKonstanten.StartView);
                  StadtVorhanden := False;
            
               when others =>
                  StadtseitenleisteGrafik.Stadt (SpeziesExtern        => SpeziesExtern,
                                                 StadtauswahlExtern   => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => StadtSpeziesNummer),
                                                 AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                 ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltStadt));
                  StadtVorhanden := True;
            end case;
            
            EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                            LogikGrafikExtern => False);
      
            case
              EinheitSpeziesNummer.Nummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltEinheit,
                                                             ViewflächeExtern     => GrafikRecordKonstanten.StartView);
            
               when others =>
                  EinheitenseitenleisteGrafik.Einheiten (SpeziesExtern              => SpeziesExtern,
                                                         EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                         StadtVorhandenExtern       => StadtVorhanden);
            end case;
            
         when False =>
            Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltAllgemeines,
                                                       ViewflächeExtern     => GrafikRecordKonstanten.StartView);
            
            Leerwert := StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                      ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltStadt),
                                                      ViewflächeExtern     => GrafikRecordKonstanten.StartView);
            
            Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltEinheit,
                                                       ViewflächeExtern     => GrafikRecordKonstanten.StartView);
            
      end case;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
