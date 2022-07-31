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
with ViewsEinstellenSFML;

package body KarteInformationenSFML is

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
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern    => ViewsSFML.SeitenleisteKartenviewAccess,
                                                GrößeExtern   => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                                ZentrumExtern => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
            HintergrundSFML.SeitenleisteHintergrund;
      
            Textposition := StartpunktText;
            Textposition := KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                       TextpositionExtern => Textposition,
                                                                       KoordinatenExtern  => AktuelleKoordinaten);
      end case;
      
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
      
      -- YWert verdoppeln? äöü
      -- Da gibt es bestimmt einen besseren Weg. äöü
      -- Gewissen Länge/Breite anlegen und bei erreichen von dieser einfach den View nachträglich vergrößern? äöü
      -- Würde das gehen? Wenn ja den Stadtnamen ignorieren? äöü
      -- Forschungs- und Stadtname in eigene Zeile? Stadtname kann auch ganz raus, wird ja auf der Weltkarte angezeigt und die Terminalversion braucht später eh was eigenes. äöä
      -- Aktuelle Forschung mit Fortschritt und Zielmenge in das Forschungsmenü einbauen. äöü
      Sf.Graphics.View.setViewport (view     => ViewsSFML.SeitenleisteKartenviewAccess,
                                    viewport => (0.80, 0.00, 0.80, 1.00));
      
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
