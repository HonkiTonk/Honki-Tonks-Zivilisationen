pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with FarbgebungSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with Kartenkoordinatenberechnungssystem;
with StadtInformationenSFML;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with Warnung;

package body KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
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
              SpielVariablen.Debug.Allgemeines
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Kartenfeld := LeseKarten.AktuellerGrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetStadtgrund (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld),
                                                              PositionExtern     => AnfangGrafikPosition)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtKarte,
                                                  PositionExtern       => AnfangGrafikPosition,
                                                  FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                                  RechteckAccessExtern => RechteckAccess);
         
            Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.GrafischeDarstellung - Sprite ist null: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image & " - " & StadtRasseNummerExtern.Nummer'Wide_Wide_Image);
      end case;
      
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
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
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
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => KarteKoordinatenExtern,
                             RasseExtern       => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                               PositionExtern    => PositionExtern);
            
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Kartenfeld := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                             TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld),
                                                             PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                                  RechteckAccessExtern => RechteckAccess);
            
            Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.KartenfeldZeichnen - Sprite nicht vorhanden: " & Kartenfeld'Wide_Wide_Image);
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldFluss = KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                                    TexturAccessExtern => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 5.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfBlue,
                                               RechteckAccessExtern => RechteckAccess);
         
         Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.FlussZeichnen - Sprite nicht vorhanden: " & KartenfeldFluss'Wide_Wide_Image);
      end if;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                                    TexturAccessExtern => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
         
      else
         ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                            PositionExtern    => PositionExtern,
                                            FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                            KreisAccessExtern => KreisAccess);
         
         Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.RessourceZeichnen - Sprite nicht vorhanden: " & KartenfeldRessource'Wide_Wide_Image);
      end if;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      if
        Wegfeld = KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                                    TexturAccessExtern => EingeleseneTexturenSFML.WegeAccess (Wegfeld),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfRed,
                                               RechteckAccessExtern => RechteckAccess);
         
         Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.WegZeichnen - Sprite nicht vorhanden: " & Wegfeld'Wide_Wide_Image);
      end if;
   
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      if
        Verbesserungsfeld = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                                    TexturAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                               RechteckAccessExtern => RechteckAccess);
            
         Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.VerbesserungZeichnen - Sprite nicht vorhanden: " & Verbesserungsfeld'Wide_Wide_Image);
      end if;
      
   end VerbesserungZeichnen;
      
   
   
   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        YAchseExtern = 1
        and
          XAchseExtern <= 12
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern);
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern <= 12
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern) + 12;
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern) + 24;

      else
         return;
      end if;
      
      case
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => GebäudeID)
      is
         when True =>
            if
              True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (SpriteAccesExtern  => SpriteAccess,
                                                                          TexturAccessExtern => EingeleseneTexturenSFML.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID),
                                                                          PositionExtern     => PositionExtern)
            then
               null;
               
            else
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                                    PositionExtern      => PositionExtern,
                                                    AnzahlEckenExtern   => 3,
                                                    FarbeExtern         => Sf.Graphics.Color.sfMagenta,
                                                    PolygonAccessExtern => PolygonAccess);
            
               Warnung.GrafikWarnung (WarnmeldungExtern => "KarteStadtSFML.DarstellungGebäude - Sprite nicht vorhanden: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image & " - " & GebäudeID'Wide_Wide_Image);
            end if;
            
         when False =>
            null;
      end case;
      
   end DarstellungGebäude;

end KarteStadtSFML;
