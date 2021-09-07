pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseKarten, LeseEinheitenGebaut;

with KartePositionPruefen, EinheitSuchen;

package body KIFeindlicheEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      FeindExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => EinheitRasseNummerExtern.Rasse)
              = False
            then
               null;
                  
            else
               FeindlicheEinheit := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindExtern,
                                                                                    KoordinatenExtern => KartenWert);
               case
                 FeindlicheEinheit
               is
                  when GlobaleKonstanten.LeerEinheitStadtNummer =>
                     null;
                     
                  when others =>
                     return KartenWert;
               end case;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return GlobaleKonstanten.LeerKartenPosition;
      
   end FeindlicheEinheitInUmgebungSuchen;

end KIFeindlicheEinheitSuchen;
