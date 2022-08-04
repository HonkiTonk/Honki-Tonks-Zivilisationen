pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with StadtKonstanten;
with EinheitenKonstanten;
with EinheitenDatentypen;

with LeseKarten;

with GrafikEinstellungenSFML;
with StadtSuchen;
with EinheitSuchen;
with StadtInformationenSFML;
with InformationenEinheitenSFML;
with KarteWichtigesSFML;
with KarteAllgemeinesSFML;
with Vergleiche;
with HintergrundSFML;
with ViewsSFML;
with ViewsEinstellenSFML;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;

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
            Viewfläche.y := StartpunktText.y + Float ((TextaccessVariablen.KarteWichtigesAccessArray'Last + TextaccessVariablen.KarteAllgemeinesAccessArray'Last + TextaccessVariablen.StadtInformationenAccessArray'Last
                                                       + TextaccessVariablen.EinheitenInformationenAccessArray'Last + Natural (EinheitenDatentypen.Transportplätze'Last)
                                                       -- Sollte ich später nach EinheitInformationen noch mehr hinzufügen, oder später Dinge entfernen, dann muss die 4 erhöht/gesenkt werden!
                                                       + 4)) * TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern    => ViewsSFML.SeitenleisteKartenviewAccess,
                                                GrößeExtern   => Viewfläche,
                                                ZentrumExtern => (Viewfläche.x / 2.00, Viewfläche.y / 2.00));
            HintergrundSFML.SeitenleisteHintergrund (AbmessungenExtern => Viewfläche);
      
            Textposition := KarteWichtigesSFML.WichtigesInformationen (RasseExtern        => RasseExtern,
                                                                       TextpositionExtern => StartpunktText,
                                                                       KoordinatenExtern  => AktuelleKoordinaten);
            BreiteText := Textposition.x;
      end case;
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            Textposition := KarteAllgemeinesSFML.AllgemeineInformationen (RasseExtern        => RasseExtern,
                                                                          TextpositionExtern => (StartpunktText.x, Textposition.y));
            
            if
              Textposition.x > BreiteText
            then
               BreiteText := Textposition.x;
               
            else
               null;
            end if;
            
            Textposition := StadtInformationen (RasseExtern        => RasseExtern,
                                                TextpositionExtern => (StartpunktText.x, Textposition.y),
                                                KoordinatenExtern  => AktuelleKoordinaten);
            
            if
              Textposition.x > BreiteText
            then
               BreiteText := Textposition.x;
               
            else
               null;
            end if;
              
            Textposition := EinheitInformationen (RasseExtern        => RasseExtern,
                                                  TextpositionExtern => (StartpunktText.x, Textposition.y),
                                                  KoordinatenExtern  => AktuelleKoordinaten);
            
            if
              Textposition.x > BreiteText
            then
               BreiteText := Textposition.x;
               
            else
               null;
            end if;

         when False =>
            null;
      end case;
      
      Viewfläche.x := BreiteText;
      
      -- Forschungs- und Stadtname in eigene Zeile? Stadtname kann auch ganz raus, wird ja auf der Weltkarte angezeigt und die Terminalversion braucht später eh was eigenes. äöä
      -- Aktuelle Forschung mit Fortschritt und Zielmenge in das Forschungsmenü einbauen. äöü
      Sf.Graphics.View.setViewport (view     => ViewsSFML.SeitenleisteKartenviewAccess,
                                    viewport => (0.80, 0.00, 0.20, 1.00));
      
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
            return StadtInformationenSFML.Stadt (RasseExtern            => RasseExtern,
                                                 StadtRasseNummerExtern => StadtRasseNummer,
                                                 AnzeigeAnfangenExtern  => TextpositionExtern);
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
            return InformationenEinheitenSFML.Einheiten (RasseExtern              => RasseExtern,
                                                         EinheitRasseNummerExtern => EinheitRasseNummer,
                                                         TextpositionExtern       => TextpositionExtern);
      end case;
      
   end EinheitInformationen;

end KarteInformationenSFML;
