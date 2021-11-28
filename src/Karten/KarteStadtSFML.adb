pragma SPARK_Mode (On);

with Sf.Graphics.Color;

with KartenDatentypen; use KartenDatentypen;

with LeseKarten;
with LeseStadtGebaut;
with KarteSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with Karten;

package body KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
            
      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
            
            if
              GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = YAchseSchleifenwert
              and
                GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse = XAchseSchleifenwert
            then
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00,
                                                    PositionExtern      => (XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x, YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                                    AnzahlEckenExtern   => 3,
                                                    FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                    PolygonAccessExtern => PolygonAccess);
               
            else
               XMultiplikator := XMultiplikator + 1.00;
            end if;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
      -- Hier Baumenü und alles andere einbauen.
      
   end AnzeigeStadt;
   
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtKarte,
                                            PositionExtern       => (0.00, 0.00),
                                            FarbeExtern          => KarteSFML.FarbeKartenfeldErmitteln (GrundExtern => LeseKarten.Grund
                                                                                                        (PositionExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern))),
                                            RechteckAccessExtern => RechteckAccess);
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtAnzeige.x - BerechnungenKarteSFML.StadtKarte.x, BerechnungenKarteSFML.StadtAnzeige.y),
                                            PositionExtern       => (BerechnungenKarteSFML.StadtKarte.x, 0.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
   end GrafischeDarstellung;

end KarteStadtSFML;
