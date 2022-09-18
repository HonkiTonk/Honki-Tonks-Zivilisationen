pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Color;

with KartenDatentypen; use KartenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with Views;
with GrafikRecordKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;

with FarbgebungGrafik;
with KartenberechnungenGrafik;
with ObjekteZeichnenGrafik;
with EinstellungenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;

package body StadtkarteGrafik is

   -- Die Darstellung der Informationen und Gebäude auch in eigene Views? äöü
   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (1),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (1));
      
      InformationenStadtAufrufen := False;
      
      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
            
            GrafikPosition := (XMultiplikator * KartenberechnungenGrafik.StadtfelderAbmessung.x, YMultiplikator * KartenberechnungenGrafik.StadtfelderAbmessung.y);
                        
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
      
      Kartenfeld := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetStadtgrund (TexturAccessExtern => EingeleseneTexturenGrafik.KartenfelderAccess (Kartenfeld),
                                                                PositionExtern     => AnfangGrafikPosition)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => (KartenberechnungenGrafik.StadtKarte.width, KartenberechnungenGrafik.StadtKarte.height),
                                                    PositionExtern       => AnfangGrafikPosition,
                                                    FarbeExtern          => FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld));
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
        True = KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID),
                                                                      PositionExtern     => PositionExtern)
      then
         null;
               
      else
         ObjekteZeichnenGrafik.PolygonZeichnen (RadiusExtern      => KartenberechnungenGrafik.StadtfelderAbmessung.x / 2.00,
                                                PositionExtern    => PositionExtern,
                                                AnzahlEckenExtern => 3,
                                                FarbeExtern       => Sf.Graphics.Color.sfMagenta);
      end if;
      
   end DarstellungGebäude;

end StadtkarteGrafik;
