pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with GlobaleTexte;
with StadtKonstanten;
with EinheitenKonstanten;
with TextKonstanten;
with KartenGrundDatentypen;

with LeseWichtiges;
with LeseKarten;

with GrafikEinstellungenSFML;
with StadtSuchen;
with EinheitSuchen;
with TextAllgemeinSFML;
with ObjekteZeichnenSFML;
with ForschungAllgemein;
with KartenAllgemein;
with AufgabenAllgemein;
with StadtInformationenSFML;
with InformationenEinheitenSFML;

package body KarteInformationenSFML is

   -- Den gesamten Text auf einem eigenen View schreiben und dann anzeigen. Damit sollte dann die Skalierung des Textes einfach? funktionieren.
   -- Das dann überall so machen und die Views in einer Datei schreiben um sie von der Grafik jederzeit in beliebiger Mischung anzeigen zu können?
   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAllgemeinSFML.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                              FontAccessExtern   => GrafikEinstellungenSFML.SchriftartAccess,
                                              SchriftgrößeExtern => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße,
                                              FarbeExtern        => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      -- Sf.Graphics.View.setSize (view => InformationenViewAcces,
      --                          size => (Float (EinstellungenSFML.AktuelleFensterAuflösung.x) * 0.20, Float (EinstellungenSFML.AktuelleFensterAuflösung.y)));
      -- Sf.Graphics.RenderWindow.setView (renderWindow => EinstellungenSFML.FensterAccess,
      --                                  view         => InformationenViewAcces);
      
      FensterInformationen := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.20, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => FensterInformationen,
                                            PositionExtern       => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAcces);
      
      PositionText := (StartpunktText.x + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80, StartpunktText.y);
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      WichtigesInformationen (RasseExtern => RasseExtern);

      case
        LeseKarten.Sichtbar (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            AllgemeineInformationen (RasseExtern => RasseExtern);
            PositionText.y := PositionText.y + 3.00 * Zeilenabstand;
              
            StadtInformationen (RasseExtern => RasseExtern);
            PositionText.y := PositionText.y + 3.00 * Zeilenabstand;
              
            EinheitInformationen (RasseExtern => RasseExtern);

         when False =>
            null;
      end case;

      DebugInformationen;
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => Sf.Graphics.RenderWindow.getDefaultView (renderWindow => GrafikEinstellungenSFML.FensterAccess));
      
   end KarteInformationenSFML;
   
   
   
   procedure WichtigesInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse);
      YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse);
      XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellePosition)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ","
                                         & To_Wide_Wide_String (Source => YAchsenWert) & "," & To_Wide_Wide_String (Source => XAchsenWert));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl?
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => GlobaleVariablen.RundenAnzahl);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleRunde)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleGeldmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerGeldzuwachs)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellesForschungsprojekt) & " "
                                                                      & ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                                                                         RasseExtern => RasseExtern)));

      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugVerbleibendeForschungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleForschungsmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerForschungsgewinn)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end WichtigesInformationen;



   procedure AllgemeineInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.Hügel (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell) = True
      then      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => KartenAllgemein.Beschreibung (KartenGrundExtern => KartenGrundDatentypen.Hügel_Mit_Enum));
      
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => PositionText);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess);
         
         PositionText.x := PositionText.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 5.00;
         
      else
         null;
      end if;
         
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.x := StartpunktText.x + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * 0.80;
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
                  

      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Ressource (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  =>
                                           AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  =>
                                           AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Fluss (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;

   end AllgemeineInformationen;
   
   
   
   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        StadtRasseNummer.Platznummer
      is
         when StadtKonstanten.LeerNummer =>
            return;
            
         when others =>
            PositionText := StadtInformationenSFML.Stadt (RasseExtern            => RasseExtern,
                                                          StadtRasseNummerExtern => StadtRasseNummer,
                                                          AnzeigeAnfangenExtern  => PositionText);
      end case;
      
   end StadtInformationen;
   
   
   
   procedure EinheitInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        EinheitRasseNummer.Platznummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            PositionText := InformationenEinheitenSFML.Einheiten (RasseExtern              => RasseExtern,
                                                                  EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                  PositionTextExtern       => PositionText);
      end case;
      
   end EinheitInformationen;
   
   
   
   procedure DebugInformationen
   is begin
      
      null;
      
   end DebugInformationen;

end KarteInformationenSFML;
