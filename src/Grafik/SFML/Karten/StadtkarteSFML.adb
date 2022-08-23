pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenKonstanten;
with GrafikRecordKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with FarbgebungSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with Kartenkoordinatenberechnungssystem;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with ViewsEinstellenSFML;
with Views;

package body StadtkarteSFML is

   -- Die Darstellung des Stadtbereichs in einen eigenen View. äöü
   -- Die Darstellung der Informationen und Gebäude auch in eigene Views? äöü
   -- Das ganze auch etwas hübscher aufbereiten, ist ja kein Terminal mehr.
   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                          GrößeExtern          => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
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
                                 XAchseExtern           => XAchseSchleifenwert,
                                 PositionExtern         => GrafikPosition,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            XMultiplikator := XMultiplikator + 1.00;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Stadtkarte;
   
   
   
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
      end case;
      
   end GrafischeDarstellung;
      
   
   
   procedure DarstellungUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      -- Diese Werte sollte man mal in Konstanten schieben. äöü
      -- Wenn ich das als eigenen View behandle dann brauch ich die Konstanten so gar nicht mehr. äöü
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
      
      if
        False = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern  => GebäudeID)
      then
         null;
         
      elsif
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
      end if;
      
   end DarstellungGebäude;

end StadtkarteSFML;
