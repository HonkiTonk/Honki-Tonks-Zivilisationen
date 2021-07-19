pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, EinheitSuchen, Karten, KIGefahrReaktion;

package body KIGefahrErmitteln is
   
   procedure KIGefahrErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            if
              KartenWert.XAchse = 0
            then
               null;
                  
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Sichtbar (EinheitRasseNummerExtern.Rasse) = False
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert);
                  
               if
                 EinheitUnzugeordnet.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
               then
                  null;
                     
               elsif
                 GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Aggressiv_Enum
               then
                  KIGefahrReaktion.KIGefahrReaktion (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     FeindlicheEinheit        => EinheitUnzugeordnet);
                  return;
                  
               else
                  null;
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end KIGefahrErmitteln;

end KIGefahrErmitteln;
