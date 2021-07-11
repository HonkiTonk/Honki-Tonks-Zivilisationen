pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse <= 5
      then
         MindestBewertungKartenfeld := 90;
            
      else
         MindestBewertungKartenfeld := 90;
      end if;
      
      EAchseSchleife:
      for EAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                              
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                           ÄnderungExtern       => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           ZusatzYAbstandExtern => 0);
                     
               exit XAchseSchleife when KartenWert.XAchse = 0;
               
               case
                 StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                       KoordinatenExtern => KartenWert).Platznummer
               is
                  when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                     null;
                     
                  when others =>
                     MindestBewertungKartenfeld := MindestBewertungKartenfeld + 5;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return MindestBewertungKartenfeld;
      
   end MindestBewertungKartenfeldStadtBauen;

end KIMindestBewertungKartenfeldErmitteln;
