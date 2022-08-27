pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Color;

with KartenDatentypen; use KartenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with Views;
with GrafikRecordKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with FarbgebungSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with ViewsEinstellenSFML;
with Karten;

package body StadtkarteSFML is

   -- Die Darstellung der Informationen und Gebäude auch in eigene Views? äöü
   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                          GrößeExtern          => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
      InformationenStadtAufrufen := False;
      
      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
            
            GrafikPosition := (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y);
                        
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
        KartenspritesZeichnenSFML.SpriteGezeichnetStadtgrund (TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld),
                                                              PositionExtern     => AnfangGrafikPosition)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtKarte.width, BerechnungenKarteSFML.StadtKarte.height),
                                                  PositionExtern       => AnfangGrafikPosition,
                                                  FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld));
      end case;
      
   end GrafischeDarstellung;
      
   
   
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
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
               
      else
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 3,
                                              FarbeExtern         => Sf.Graphics.Color.sfMagenta);
      end if;
      
   end DarstellungGebäude;

end StadtkarteSFML;
