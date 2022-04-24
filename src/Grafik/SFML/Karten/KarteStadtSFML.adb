pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with FarbgebungSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with Karten;
with Kartenkoordinatenberechnungssystem;
with StadtInformationenSFML;
with GrafikEinstellungenSFML;
with Fehler;
with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
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
            
            GrafikPosition := (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y);
            
            DarstellungUmgebung (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern           => XAchseSchleifenwert,
                                 PositionExtern         => GrafikPosition,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            DarstellungGebäude (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern          => XAchseSchleifenwert,
                                 PositionExtern        => GrafikPosition,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            case
              SonstigeVariablen.Debug
            is
               when True =>
                  MauszeigerAnzeigen (YAchseExtern   => YAchseSchleifenwert,
                                      XAchseExtern   => XAchseSchleifenwert,
                                      PositionExtern => GrafikPosition,
                                      RasseExtern    => StadtRasseNummerExtern.Rasse);
                  
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
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => AnfangGrafikPosition,
                                                   SkalierungExtern  =>
                                                     TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamteStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                           TextureAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld)));
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtKarte,
                                               PositionExtern       => AnfangGrafikPosition,
                                               FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
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
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = YAchseExtern
        and
          SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse = XAchseExtern
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                              PositionExtern      => PositionExtern,
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
      PositionExtern : in Sf.System.Vector2.sfVector2f;
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
         
         KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                              ÄnderungExtern    => (0, YAchseExtern - 4, XAchseExtern - 17),
                                                                                              LogikGrafikExtern => False);
         
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                     PositionExtern       => PositionExtern,
                                                     FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                                     RechteckAccessExtern => RechteckAccess);
               
            when others =>
               DarstellungUmgebungErweitert (KarteKoordinatenExtern => KartenWert,
                                             PositionExtern         => PositionExtern,
                                             StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;

      elsif
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern = Karten.Stadtkarte'Last (2) - 7
      then
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                               RechteckAccessExtern => RechteckAccess);

      elsif
        YAchseExtern = Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern >= Karten.Stadtkarte'Last (2) - 7
      then
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                               RechteckAccessExtern => RechteckAccess);
         
      else
         null;
      end if;
      
   end DarstellungUmgebung;
   
   
   
   procedure DarstellungUmgebungErweitert
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => KarteKoordinatenExtern,
                             RasseExtern       => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                               PositionExtern    => PositionExtern);
            
            StadtZeichnen (KoordinatenExtern      => KarteKoordinatenExtern,
                           PositionExtern         => PositionExtern,
                           StadtRasseNummerExtern => StadtRasseNummerExtern);
              
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                                  RechteckAccessExtern => RechteckAccess);
            return;
      end case;
      
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
            
            -- Den Wert hier nicht an die Ansichtsart der Weltkarte anpassen, damit man besser die vorhandenen und besetzten Kartenfelder erkennt.
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.StadtfelderAbmessung.x - 6.00, BerechnungenKarteSFML.StadtfelderAbmessung.y - 6.00));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (PositionExtern.x + 3.00, PositionExtern.y + 3.00));
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
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Kartenfeld := LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern);
      
      if
        EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                       TextureAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld)));
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldFluss = KartenGrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                       TextureAccessExtern => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss)));
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 5.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfBlue,
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      ----------------------- Unnötiges doppeltes Aufrufen von EingeleseneTexturenSFML entfernen.
      KartenfeldRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldRessource = KartenGrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  =>
                                                     TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                    TextureAccessExtern => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource)));
         
      else
         ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                            PositionExtern    => PositionExtern,
                                            FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                            KreisAccessExtern => KreisAccess);
      end if;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      if
        Wegfeld = KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.WegeAccess (Wegfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                       TextureAccessExtern => EingeleseneTexturenSFML.WegeAccess (Wegfeld)));
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfRed,
                                               RechteckAccessExtern => RechteckAccess);
      end if;
   
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      if
        Verbesserungsfeld = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  =>
                                                     TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                    TextureAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld)));
      
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end VerbesserungZeichnen;
   
   
   
   procedure StadtZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern) = KoordinatenExtern
      then
         Stadtfeld := LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
         if
           EingeleseneTexturenSFML.VerbesserungenAccess (Stadtfeld) /= null
         then
            KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                      PositionExtern    => PositionExtern,
                                                      SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                          TextureAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Stadtfeld)));
            
         elsif -- -------------------------- Mal was wegen den Positionierungen unternehmen.
           Stadtfeld = KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum
         then
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 5.00,
                                                 PositionExtern      => (PositionExtern.x + BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.50,
                                                                         PositionExtern.y + BerechnungenKarteSFML.StadtfelderAbmessung.y / 3.50),
                                                 AnzahlEckenExtern   => 5,
                                                 FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                 PolygonAccessExtern => PolygonAccess);
               
         elsif
           Stadtfeld = KartenVerbesserungDatentypen.Eigene_Stadt_Enum
         then
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 6.00,
                                                 PositionExtern      => (PositionExtern.x + BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                                                         PositionExtern.y + BerechnungenKarteSFML.StadtfelderAbmessung.y / 3.00),
                                                 AnzahlEckenExtern   => 6,
                                                 FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                 PolygonAccessExtern => PolygonAccess);
            
         else
            Fehler.GrafikFehler (FehlermeldungExtern => "KarteStadtSFML.StadtZeichnen - Vorhandene Stadt ist nicht vorhanden.");
         end if;
         
      else
         null;
      end if;
      
   end StadtZeichnen;
      
   
   
   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
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
            if
              EingeleseneTexturenSFML.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID) /= null
            then
               KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                         PositionExtern    => PositionExtern,
                                                         SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenStadtkarte
                                                           (SpriteAccessExtern  => SpriteAccess,
                                                            TextureAccessExtern => EingeleseneTexturenSFML.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID)));
               
            else
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                                    PositionExtern      => PositionExtern,
                                                    AnzahlEckenExtern   => 3,
                                                    FarbeExtern         => Sf.Graphics.Color.sfMagenta,
                                                    PolygonAccessExtern => PolygonAccess);
            end if;
            
         when False =>
            null;
      end case;
      
   end DarstellungGebäude;

end KarteStadtSFML;
