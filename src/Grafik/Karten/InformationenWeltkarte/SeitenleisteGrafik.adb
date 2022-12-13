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

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (RasseExtern => RasseExtern);
      
      -- Ist der Cursor jemals Leer? Wenn nein, dann eventuell einbauen? äöü
      if
        AktuelleKoordinaten = KartenRecordKonstanten.LeerKoordinate
      then
         return;
            
      else
         WichtigesSeitenleisteGrafik.WichtigesInformationen (RasseExtern       => RasseExtern,
                                                             KoordinatenExtern => AktuelleKoordinaten);
      end if;
      
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => AktuelleKoordinaten,
                                RasseExtern       => RasseExtern)
      is
         when True =>
            AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (RasseExtern => RasseExtern);
                                    
            StadtRasseNummer := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten);
      
            case
              StadtRasseNummer.Nummer
            is
               when StadtKonstanten.LeerNummer =>
                  Leerwert := StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                            ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltStadt),
                                                            ViewflächeExtern     => GrafikRecordKonstanten.LeerView);
                  StadtVorhanden := False;
            
               when others =>
                  StadtseitenleisteGrafik.Stadt (RasseExtern            => RasseExtern,
                                                 StadtRasseNummerExtern => StadtRasseNummer,
                                                 AnzeigebereichExtern   => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                 ViewExtern             => Views.WeltkarteAccess (ViewKonstanten.WeltStadt));
                  StadtVorhanden := True;
            end case;
            
            EinheitRasseNummer := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                        LogikGrafikExtern => False);
      
            case
              EinheitRasseNummer.Nummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltEinheit,
                                                             ViewflächeExtern     => GrafikRecordKonstanten.LeerView);
            
               when others =>
                  EinheitenseitenleisteGrafik.Einheiten (RasseExtern              => RasseExtern,
                                                         EinheitRasseNummerExtern => EinheitRasseNummer,
                                                         StadtVorhandenExtern     => StadtVorhanden);
            end case;
            
         when False =>
            Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltAllgemeines,
                                                       ViewflächeExtern     => GrafikRecordKonstanten.LeerView);
            
            Leerwert := StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt),
                                                      ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltStadt),
                                                      ViewflächeExtern     => GrafikRecordKonstanten.LeerView);
            
            Leerwert := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltEinheit,
                                                       ViewflächeExtern     => GrafikRecordKonstanten.LeerView);
            
      end case;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
