pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with EinheitenKonstanten;

with LeseKarten;

with GrafikEinstellungenSFML;
with StadtSuchen;
with EinheitSuchen;
with ObjekteZeichnenSFML;
with StadtInformationenSFML;
with InformationenEinheitenSFML;
with KarteWichtigesSFML;
with KarteAllgemeinesSFML;
with TextberechnungenHoeheSFML;

package body KarteInformationenSFML is

   -- Den gesamten Text auf einem eigenen View schreiben und dann anzeigen. Damit sollte dann die Skalierung des Textes einfach? funktionieren. äöü
   -- Das dann überall so machen und die Views in einer Datei schreiben um sie von der Grafik jederzeit in beliebiger Mischung anzeigen zu können? äöü
   -- Diese ganzen Prüfungen in den Unterbereichen rauswerfen und immer alles neu berechnen lassen? äöü
   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      FensterInformationen := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.20, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      -- Farbkonstanten anlegen? Habe ich sowas nicht schon? äöü
      -- Das alles mal verschieben? äöü
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => FensterInformationen,
                                            PositionExtern       => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAcces);
      
      Textposition := (StartpunktText.x + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, StartpunktText.y);
      
      Textposition := KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                 TextpositionExtern => Textposition);
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.GroßerZeilenabstand;
            
            Textposition := KarteAllgemeinesSFML.AllgemeineInformationen (RasseExtern        => RasseExtern,
                                                                          TextpositionExtern => Textposition);
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.GroßerZeilenabstand;
            
            Textposition := StadtInformationen (RasseExtern        => RasseExtern,
                                                TextpositionExtern => Textposition);
              
            Textposition := EinheitInformationen (RasseExtern        => RasseExtern,
                                                  TextpositionExtern => Textposition);

         when False =>
            null;
      end case;
      
   end KarteInformationenSFML;
   
   
   
   function StadtInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        StadtRasseNummer.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            return TextpositionExtern;
            
         when others =>
            TextpositionStadt := StadtInformationenSFML.Stadt (RasseExtern            => RasseExtern,
                                                               StadtRasseNummerExtern => StadtRasseNummer,
                                                               AnzeigeAnfangenExtern  => Textposition);
            return (TextpositionStadt.x, TextpositionStadt.y + TextberechnungenHoeheSFML.GroßerZeilenabstand);
      end case;
      
   end StadtInformationen;
   
   
   
   function EinheitInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return TextpositionExtern;
            
         when others =>
            TextpositionEinheit := InformationenEinheitenSFML.Einheiten (RasseExtern              => RasseExtern,
                                                                         EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                         TextpositionExtern       => Textposition);
            return (TextpositionEinheit.x, TextpositionEinheit.y + TextberechnungenHoeheSFML.GroßerZeilenabstand);
      end case;
      
   end EinheitInformationen;

end KarteInformationenSFML;
