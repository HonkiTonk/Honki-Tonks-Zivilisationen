pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, KartePositionPruefen, RasseEntfernen;

package body StadtEntfernen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BelegteStadtfelderFreigeben (StadtRasseNummerExtern => StadtRasseNummerExtern);
      HeimatstädteEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeerStadt;
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end StadtEntfernen;
   
   
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YUmgebungFreigebenSchleife:
      for YUmgebungFreigebenSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XUmgebungFreigebenSchleife:
         for XUmgebungFreigebenSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern   => (0, YUmgebungFreigebenSchleifenwert, XUmgebungFreigebenSchleifenwert));
         
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
              = GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse)) * GlobaleKonstanten.RassenMulitplikationWert
              + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
            
            else
               null;
            end if;
         
         end loop XUmgebungFreigebenSchleife;
      end loop YUmgebungFreigebenSchleife;
      
   end BelegteStadtfelderFreigeben;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
         
         if
           GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).Heimatstadt = StadtRasseNummerExtern.Platznummer
         then
            GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).Heimatstadt := 0;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end HeimatstädteEntfernen;

end StadtEntfernen;
