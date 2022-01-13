pragma SPARK_Mode (On);

-- with Sf.Graphics.Color;
with Sf.Graphics.RenderWindow;

with GlobaleTexte;
with StadtKonstanten;
with EinheitenKonstanten;
with TextKonstanten;

with LeseWichtiges;
with LeseKarten;

with GrafikEinstellungen;
with StadtSuchen;
with EinheitSuchen;
with GrafikTextAllgemein;
with ObjekteZeichnenSFML;
with ForschungAllgemein;
with KartenAllgemein;
with AufgabenAllgemein;
with StadtInformationenSFML;
with InformationenEinheitenSFML;

package body KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontAccessExtern   => GrafikEinstellungen.SchriftartAccess,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      
      FensterInformationen := (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) * 0.20, Float (GrafikEinstellungen.AktuelleFensterAuflösung.y));
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => FensterInformationen,
                                            PositionExtern       => (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) * 0.80, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAcces);
      
      PositionText := (StartpunktText.x + Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) * 0.80, StartpunktText.y);
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      WichtigesInformationen (RasseExtern => RasseExtern);

      -- Diese Version hier auch noch in der Konsolenversion einbauen.
      case
        LeseKarten.Sichtbar (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                             RasseExtern    => RasseExtern)
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

      CheatInformationen;
      
   end KarteInformationenSFML;
   
   
   
   procedure WichtigesInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse);
      YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse);
      XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellePosition)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ","
                                         & To_Wide_Wide_String (Source => YAchsenWert) & "," & To_Wide_Wide_String (Source => XAchsenWert));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl?
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => GlobaleVariablen.RundenAnzahl);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleRunde)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleGeldmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerGeldzuwachs)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellesForschungsprojekt) & " "
                                                                      & ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                                                                         RasseExtern => RasseExtern)));

      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugVerbleibendeForschungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleForschungsmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerForschungsgewinn)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end WichtigesInformationen;



   procedure AllgemeineInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) = True
      then      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => KartenAllgemein.Beschreibung (KartenGrundExtern => KartenDatentypen.Hügel_Mit));
      
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => PositionText);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                            text         => TextAccess);
         
         PositionText.x := PositionText.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 5.00;
         
      else
         null;
      end if;
         
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.x := StartpunktText.x + Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) * 0.80;
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
                  

      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Ressource (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Fluss (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;

   end AllgemeineInformationen;
   
   
   
   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      
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
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      
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
   
   
   
   procedure CheatInformationen
   is begin
      
      null;
      
   end CheatInformationen;

end KarteInformationenSFML;
