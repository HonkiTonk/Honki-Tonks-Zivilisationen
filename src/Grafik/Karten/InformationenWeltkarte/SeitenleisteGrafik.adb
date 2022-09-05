pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with EinheitenKonstanten;

with LeseKarten;

with StadtSuchen;
with EinheitSuchen;
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
            WichtigesSeitenleisteGrafik.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                KoordinatenExtern  => AktuelleKoordinaten);
      end case;
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            AllgemeinesSeitenleisteGrafik.AllgemeineInformationen (RasseExtern => RasseExtern);
                                    
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten);
      
            case
              StadtRasseNummer.Nummer
            is
               when StadtKonstanten.LeerNummer =>
                  StadtseitenleisteGrafik.Leer;
                  StadtVorhanden := False;
            
               when others =>
                  StadtseitenleisteGrafik.Stadt (RasseExtern            => RasseExtern,
                                                 StadtRasseNummerExtern => StadtRasseNummer);
                  StadtVorhanden := True;
            end case;
            
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten,
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
            AllgemeinesSeitenleisteGrafik.Leer;
            StadtseitenleisteGrafik.Leer;
            EinheitenseitenleisteGrafik.Leer (AnzeigebereichExtern => 4);
      end case;
      
   end SeitenleisteGrafik;

end SeitenleisteGrafik;
