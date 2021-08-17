pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, EinheitSuchen, Karten, KIGefahrReaktion, StadtSuchen;

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
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                  
            elsif
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                      RasseExtern    => EinheitRasseNummerExtern.Rasse) = False
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert);
                  
               if
                 EinheitUnzugeordnet.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                     
               elsif
                 GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Aggressiv_Enum
                 and
                   StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                               KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position)
                     /= GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
                  
               elsif
                 GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Aggressiv_Enum
               then
                  KIGefahrReaktion.KIGefahrReaktion (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  return;
                  
               else
                  null;
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end KIGefahrErmitteln;

end KIGefahrErmitteln;
