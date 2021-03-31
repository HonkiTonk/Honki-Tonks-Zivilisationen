pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenPruefungen, EinheitSuchen;

package body BewegungZwischenEbene is
   
   function Gegner (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin
      
      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);

      EinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

      if
        EinheitWert.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return -1;

      elsif
        EinheitWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         return 0;
         
      else
         return 1;
      end if;
      
   end Gegner;

end BewegungZwischenEbene;
