pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with EinheitenKonstanten;
with SpielVariablen;

with LeseKarten;

with GrafikEinstellungenSFML;
with StadtSuchen;
with EinheitSuchen;
with ObjekteZeichnenSFML;
with StadtInformationenSFML;
with InformationenEinheitenSFML;
with KarteWichtigesSFML;
with KarteAllgemeinesSFML;

package body KarteInformationenSFML is

   ------------------------ Den gesamten Text auf einem eigenen View schreiben und dann anzeigen. Damit sollte dann die Skalierung des Textes einfach? funktionieren.
   ------------------------ Das dann überall so machen und die Views in einer Datei schreiben um sie von der Grafik jederzeit in beliebiger Mischung anzeigen zu können?
   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      FensterInformationen := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.20, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => FensterInformationen,
                                            PositionExtern       => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAcces);
      
      Textposition := (StartpunktText.x + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, StartpunktText.y);
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      Textposition := KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                 TextpositionExtern => Textposition);
      Textposition.y := Textposition.y + 3.00 * Zeilenabstand;
      

      case
        LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            Textposition := KarteAllgemeinesSFML.AllgemeineInformationen (RasseExtern        => RasseExtern,
                                                                          TextpositionExtern => Textposition);
            Textposition.y := Textposition.y + 5.00 * Zeilenabstand;
            
            StadtInformationen (RasseExtern => RasseExtern);
              
            EinheitInformationen (RasseExtern => RasseExtern);

         when False =>
            null;
      end case;

      DebugInformationen;
      
   end KarteInformationenSFML;
   
   
   
   procedure StadtInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        StadtRasseNummer.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
            
         when others =>
            Textposition := StadtInformationenSFML.Stadt (RasseExtern            => RasseExtern,
                                                          StadtRasseNummerExtern => StadtRasseNummer,
                                                          AnzeigeAnfangenExtern  => Textposition);
            Textposition.y := Textposition.y + 5.00 * Zeilenabstand;
      end case;
      
   end StadtInformationen;
   
   
   
   procedure EinheitInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            Textposition := InformationenEinheitenSFML.Einheiten (RasseExtern              => RasseExtern,
                                                                  EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                  PositionTextExtern       => Textposition);
            Textposition.y := Textposition.y + 3.00 * Zeilenabstand;
      end case;
      
   end EinheitInformationen;
   
   
   
   procedure DebugInformationen
   is begin
      
      case
        SonstigeVariablen.Debug.Allgemeines
      is
         when False =>
            null;
            
         when True =>
            null;
      end case;
      
   end DebugInformationen;

end KarteInformationenSFML;
