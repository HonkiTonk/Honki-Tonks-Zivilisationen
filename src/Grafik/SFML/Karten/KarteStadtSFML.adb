pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with KarteSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with Karten;
with KarteKoordinatenPruefen;
with StadtInformationenSFML;
with GrafikEinstellungenSFML;
with Fehler;
with EingeleseneTexturenSFML;
with SkalierungKartentexturenBerechnenSFML;
with KarteGrafikenZeichnenSFML;

package body KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
            
      Stadtumgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      InformationenStadtAufrufen := False;
      YAchsenabstraktion := -Stadtumgebungsgröße;
      
      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
            
            DarstellungUmgebung (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern           => XAchseSchleifenwert,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            DarstellungGebäude (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern           => XAchseSchleifenwert,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            case
              GlobaleVariablen.Debug
            is
               when True =>
                  MauszeigerAnzeigen (YAchseExtern => YAchseSchleifenwert,
                                      XAchseExtern => XAchseSchleifenwert,
                                      RasseExtern  => StadtRasseNummerExtern.Rasse);
                  
               when False =>
                  null;
            end case;
            
            XMultiplikator := XMultiplikator + 1.00;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
      TextPosition := StadtInformationenSFML.Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                    StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    AnzeigeAnfangenExtern  => (BerechnungenKarteSFML.StadtKarte.x + 5.00, 5.00));
      
      if
        GrafikEinstellungenSFML.MausPosition.x in Sf.sfInt32 (0.00) .. Sf.sfInt32 (BerechnungenKarteSFML.StadtKarte.x)
        and
          GrafikEinstellungenSFML.MausPosition.y in Sf.sfInt32 (0.00) .. Sf.sfInt32 (BerechnungenKarteSFML.StadtKarte.y)
      then
         MausInformationen := True;
         
      else
         MausInformationen := False;
      end if;
      
      -- Werden die Mausinformationen in der SFML Version überhaupt benötigt?
      case
        MausInformationen
      is
         when True =>
            -- Hier eventuell Informationen wie den Gebäudenamen und was das Gebäude macht einbauen?
            null;
            
         when False =>
            null;
      end case;
      
   end AnzeigeStadt;
   
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Kartenfeld := LeseKarten.Grund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      if
        EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen;
         Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccess,
                                        texture => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld));
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => (0.00, 0.00));
         Sf.Graphics.Sprite.setScale (sprite => SpriteAccess,
                                      scale  => SkalierungKartentexturenBerechnenSFML.SkalierungTexturenGesamtStadtkarteBerechnen (SpriteAccessExtern => SpriteAccess));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtKarte,
                                               PositionExtern       => (0.00, 0.00),
                                               FarbeExtern          => KarteSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtAnzeige.x - BerechnungenKarteSFML.StadtKarte.x, BerechnungenKarteSFML.StadtAnzeige.y),
                                            PositionExtern       => (BerechnungenKarteSFML.StadtKarte.x, 0.00),
                                            FarbeExtern          => (105, 105, 105, 255),
                                            RechteckAccessExtern => RechteckAccess);
      
   end GrafischeDarstellung;
   
   
   
   procedure MauszeigerAnzeigen
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = YAchseExtern
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse = XAchseExtern
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                              PositionExtern      => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                              AnzahlEckenExtern   => 3,
                                              FarbeExtern         => Sf.Graphics.Color.sfRed,
                                              PolygonAccessExtern => PolygonAccess);
               
      else
         null;
      end if;
      
   end MauszeigerAnzeigen;
   
   
   
   procedure DarstellungUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern > Karten.Stadtkarte'Last (2) - 7
      then
         case
           LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    YKoordinateExtern      => YAchseExtern - 4,
                                                    XKoordinateExtern      => XAchseExtern - 17)
         is
            when True =>
               FeldBewirtschaftet := True;
               
            when False =>
               FeldBewirtschaftet := False;
         end case;
         
         KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseExtern - 4, XAchseExtern - 17),
                                                                        LogikGrafikExtern => False);
         
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                     PositionExtern       => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                     FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                                     RechteckAccessExtern => RechteckAccess);
               
            when others =>
               DarstellungUmgebungErweitert (KarteKoordinatenExtern    => KartenWert,
                                             StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;

      elsif
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern = Karten.Stadtkarte'Last (2) - 7
      then
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                               RechteckAccessExtern => RechteckAccess);

      elsif
        YAchseExtern = Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern >= Karten.Stadtkarte'Last (2) - 7
      then
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                               RechteckAccessExtern => RechteckAccess);
         
      else
         null;
      end if;
      
   end DarstellungUmgebung;
   
   
   
   procedure DarstellungUmgebungErweitert
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => KarteKoordinatenExtern,
                             RasseExtern       => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                               PositionExtern    => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y));
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                  PositionExtern       => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                                  RechteckAccessExtern => RechteckAccess);
            return;
      end case;
      
      if
        LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern) = KarteKoordinatenExtern
      then
         -- ---------------- Schöner aufbauen, PositionExtern einbauen (geht nicht so einfach wegen der Zeichnung des Vielecks).
         if
           EingeleseneTexturenSFML.VerbesserungenAccess (LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)) /= null
         then
            Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccess,
                                           texture => EingeleseneTexturenSFML.VerbesserungenAccess (LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)));
            Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                            position => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x,
                                                         YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y));
            Sf.Graphics.Sprite.setScale (sprite => SpriteAccess,
                                         scale  => SkalierungKartentexturenBerechnenSFML.SkalierungTexturenKartenfelderStadtkarteBerechnen (SpriteAccessExtern => SpriteAccess));
            
            Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                 object       => SpriteAccess);
            
         elsif
           LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern) = KartenDatentypen.Eigene_Hauptstadt
         then
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 5.00,
                                                 PositionExtern      => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x + BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.50,
                                                                         YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y + BerechnungenKarteSFML.StadtfelderAbmessung.y / 3.50),
                                                 AnzahlEckenExtern   => 5,
                                                 FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                 PolygonAccessExtern => PolygonAccess);
               
         elsif
           LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern) = KartenDatentypen.Eigene_Stadt
         then
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 6.00,
                                                 PositionExtern      => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x + BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                                                         YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y + BerechnungenKarteSFML.StadtfelderAbmessung.y / 3.00),
                                                 AnzahlEckenExtern   => 6,
                                                 FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                 PolygonAccessExtern => PolygonAccess);
               
         else
            Fehler.GrafikStopp (FehlermeldungExtern => "KarteStadtSFML.DarstellungUmgebungErweitert - Vorhandene Stadt ist nicht vorhanden.");
         end if;
         
      else
         null;
      end if;
      
      case
        LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              KoordinatenExtern      => KarteKoordinatenExtern)
      is
         when True =>
            if
              FeldBewirtschaftet
            then
               AktuelleFarbe := Sf.Graphics.Color.sfGreen;
               
            else
               AktuelleFarbe := Sf.Graphics.Color.sfBlack;
            end if;
            
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.StadtfelderAbmessung.x - 6.00, BerechnungenKarteSFML.StadtfelderAbmessung.y - 6.00));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x + 3.00, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y + 3.00));
            Sf.Graphics.RectangleShape.setFillColor (shape => RechteckRahmenAccess,
                                                     color => Sf.Graphics.Color.sfTransparent);
            Sf.Graphics.RectangleShape.setOutlineColor (shape => RechteckRahmenAccess,
                                                        color => AktuelleFarbe);
            Sf.Graphics.RectangleShape.setOutlineThickness (shape     => RechteckRahmenAccess,
                                                            thickness => 3.00);
            Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                         object       => RechteckRahmenAccess);
            
         when False =>
            null;
      end case;
         
      
   end DarstellungUmgebungErweitert;
   
   
   
   -- Die Texturen müssen dann ja auch in der Stadt angezeigt werden.
   -- Mal Farben für die einzelnen Objekte einbauen.
   -- Ist sinnvoll, wenn die Texturen nicht geladen werden können sieht man es gleich und das Spiel funktioniert immer noch.
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Kartenfeld := LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern);
      
      if
        EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld) /= null
      then
         Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccess,
                                        texture => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld));
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => PositionExtern);
         Sf.Graphics.Sprite.setScale (sprite => SpriteAccess,
                                      scale  => SkalierungKartentexturenBerechnenSFML.SkalierungTexturenKartenfelderStadtkarteBerechnen (SpriteAccessExtern => SpriteAccess));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => KarteSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
      case
        LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenKonstanten.LeerGrund =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                               PositionExtern    => PositionExtern,
                                               FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                               KreisAccessExtern => KreisAccess);
      end case;
      
      case
        LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenKonstanten.LeerGrund =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 5.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfBlue,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
                  
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenKonstanten.LeerVerbesserungWeg =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfRed,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
      case
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenKonstanten.LeerVerbesserungGebiet =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
   end AnzeigeLandschaft;
   
   
   
   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
            
      if
        YAchseExtern = 1
        and
          XAchseExtern <= 12
      then
         GebäudeID := EinheitStadtDatentypen.GebäudeID (XAchseExtern);
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern <= 12
      then
         GebäudeID := EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 12;
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeID := EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 24;

      else
         return;
      end if;
      
      case
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => GebäudeID)
      is
         when True =>
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                                 PositionExtern      => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                 AnzahlEckenExtern   => 3,
                                                 FarbeExtern         => Sf.Graphics.Color.sfMagenta,
                                                 PolygonAccessExtern => PolygonAccess);
            
         when False =>
            null;
      end case;
      
   end DarstellungGebäude;

end KarteStadtSFML;
