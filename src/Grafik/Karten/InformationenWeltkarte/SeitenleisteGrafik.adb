with StadtKonstanten;
with EinheitenKonstanten;
with GrafikRecordKonstanten;
with Views;
with SpielVariablen;

with LeseWeltkarte;

with StadtSuchenLogik;
with EinheitSuchenLogik;
with StadtseitenleisteGrafik;
with EinheitenseitenleisteGrafik;
with WichtigesSeitenleisteGrafik;
with AllgemeinesSeitenleisteGrafik;
with Vergleiche;

package body SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      -- Ist der Cursor jemals Leer? Wenn nein, dann eventuell einbauen? äöü
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => AktuelleKoordinaten)
      is
         when True =>
            return;
            
         when False =>
            WichtigesSeitenleisteGrafik.WichtigesInformationen (RasseExtern       => RasseExtern,
                                                                KoordinatenExtern => AktuelleKoordinaten,
                                                                ViewbereichExtern => 1);
      end case;
      
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
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
