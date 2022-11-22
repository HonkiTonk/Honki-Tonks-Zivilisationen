with StadtKonstanten;
with EinheitenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseCursor;

with StadtSuchenLogik;
with EinheitSuchenLogik;
with StadtseitenleisteGrafik;
with EinheitenseitenleisteGrafik;
with WichtigesSeitenleisteGrafik;
with AllgemeinesSeitenleisteGrafik;

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
                                                             KoordinatenExtern => AktuelleKoordinaten,
                                                             ViewbereichExtern => 1);
      end if;
      
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => LeseCursor.KoordinatenAktuell (RasseExtern => RasseExtern),
                                RasseExtern       => RasseExtern)
      is
         when True =>
            AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (RasseExtern => RasseExtern);
                                    
            StadtRasseNummer := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten);
      
            case
              StadtRasseNummer.Nummer
            is
               when StadtKonstanten.LeerNummer =>
                  StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (3),
                                                ViewExtern           => Views.SeitenleisteWeltkarteAccesse (3));
                  StadtVorhanden := False;
            
               when others =>
                  StadtseitenleisteGrafik.Stadt (RasseExtern            => RasseExtern,
                                                 StadtRasseNummerExtern => StadtRasseNummer,
                                                 AnzeigebereichExtern   => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (3),
                                                 ViewExtern             => Views.SeitenleisteWeltkarteAccesse (3));
                  StadtVorhanden := True;
            end case;
            
            EinheitRasseNummer := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                        LogikGrafikExtern => False);
      
            case
              EinheitRasseNummer.Nummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  EinheitenseitenleisteGrafik.Leer (AnzeigebereichExtern => 4);
            
               when others =>
                  EinheitenseitenleisteGrafik.Einheiten (RasseExtern              => RasseExtern,
                                                         EinheitRasseNummerExtern => EinheitRasseNummer,
                                                         StadtVorhandenExtern     => StadtVorhanden);
            end case;
            
         when False =>
            AllgemeinesSeitenleisteGrafik.Leer (ViewbereichExtern => 2);
            StadtseitenleisteGrafik.Leer (AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (3),
                                          ViewExtern           => Views.SeitenleisteWeltkarteAccesse (3));
            EinheitenseitenleisteGrafik.Leer (AnzeigebereichExtern => 4);
      end case;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
