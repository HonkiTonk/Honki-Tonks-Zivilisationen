pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with StadtKonstanten;
with EinheitenKonstanten;

with LeseKarten;

with GrafikEinstellungenSFML;
with StadtSuchen;
with EinheitSuchen;
with StadtInformationenSFML;
with InformationenEinheitenSFML;
with KarteWichtigesSFML;
with KarteAllgemeinesSFML;
with TextberechnungenHoeheSFML;
with Vergleiche;
with HintergrundSFML;
with ViewsSFML;

package body KarteInformationenSFML is

   -- Den gesamten Text auf einem eigenen View schreiben und dann anzeigen. Damit sollte dann die Skalierung des Textes einfach? funktionieren. äöü
   -- Das dann überall so machen und die Views in einer Datei schreiben um sie von der Grafik jederzeit in beliebiger Mischung anzeigen zu können? äöü
   -- Diese ganzen Prüfungen in den Unterbereichen rauswerfen und immer alles neu berechnen lassen? äöü
   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => AktuelleKoordinaten)
      is
         when True =>
            return;
            
         when False =>
            Sf.Graphics.View.setSize (view => ViewsSFML.SeitenleisteKartenviewAccess,
                                      size => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y))); -- YWert verdoppeln?
            Sf.Graphics.View.setCenter (view   => ViewsSFML.SeitenleisteKartenviewAccess,
                                        center => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00)); -- YWert verdoppeln?
            Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              view         => ViewsSFML.SeitenleisteKartenviewAccess);
      end case;
      
      
      HintergrundSFML.SeitenleisteHintergrund;
      
      Textposition := StartpunktText;
      
      Textposition := KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                 TextpositionExtern => Textposition,
                                                                 KoordinatenExtern  => AktuelleKoordinaten);
      
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
                                                TextpositionExtern => Textposition,
                                                KoordinatenExtern  => AktuelleKoordinaten);
              
            Textposition := EinheitInformationen (RasseExtern        => RasseExtern,
                                                  TextpositionExtern => Textposition,
                                                  KoordinatenExtern  => AktuelleKoordinaten);

         when False =>
            null;
      end case;
      
      Sf.Graphics.View.setViewport (view     => ViewsSFML.SeitenleisteKartenviewAccess,
                                    viewport => (0.80, 0.00, 0.80, 1.00)); -- YWert verdoppeln?
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewsSFML.StandardviewAccess);
      
   end KarteInformationenSFML;
   
   
   
   function StadtInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
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
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
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
