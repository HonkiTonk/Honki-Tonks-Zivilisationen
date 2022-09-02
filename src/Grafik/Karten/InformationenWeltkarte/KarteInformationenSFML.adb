pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with EinheitenKonstanten;

with LeseKarten;

with StadtSuchen;
with EinheitSuchen;
with StadtInformationenSFML;
with InformationenEinheitenSFML;
with KarteWichtigesSFML;
with KarteAllgemeinesSFML;
with Vergleiche;

package body KarteInformationenSFML is

   procedure KarteInformationenSFML
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
            KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                       KoordinatenExtern  => AktuelleKoordinaten);
      end case;
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            KarteAllgemeinesSFML.AllgemeineInformationen (RasseExtern => RasseExtern);
                                    
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten);
      
            case
              StadtRasseNummer.Nummer
            is
               when StadtKonstanten.LeerNummer =>
                  StadtInformationenSFML.Leer;
                  StadtVorhanden := False;
            
               when others =>
                  StadtInformationenSFML.Stadt (RasseExtern            => RasseExtern,
                                                StadtRasseNummerExtern => StadtRasseNummer);
                  StadtVorhanden := True;
            end case;
            
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => AktuelleKoordinaten,
                                                                                   LogikGrafikExtern => False);
      
            case
              EinheitRasseNummer.Nummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  InformationenEinheitenSFML.Leer (AnzeigebereichExtern => 4);
            
               when others =>
                  InformationenEinheitenSFML.Einheiten (RasseExtern              => RasseExtern,
                                                        EinheitRasseNummerExtern => EinheitRasseNummer,
                                                        StadtVorhandenExtern     => StadtVorhanden);
            end case;
            
         when False =>
            KarteAllgemeinesSFML.Leer;
            StadtInformationenSFML.Leer;
            InformationenEinheitenSFML.Leer (AnzeigebereichExtern => 4);
      end case;
      
   end KarteInformationenSFML;

end KarteInformationenSFML;
