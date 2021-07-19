pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      case
        EinheitRasseNummerExtern.Rasse
      is
         when GlobaleDatentypen.Rasse_1 =>
            MindestBewertungKartenfeld := 90;
            
         when others =>
            MindestBewertungKartenfeld := 90;
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                              
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                           ÄnderungExtern       => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                     
               case
                 KartenWert.XAchse
               is
                  when 0 =>
                     null;
                     
                  when others =>               
                     if
                       StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                     then
                        null;
                        
                     else
                        MindestBewertungKartenfeld := MindestBewertungKartenfeld + 5;
                     end if;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return MindestBewertungKartenfeld;
      
   end MindestBewertungKartenfeldStadtBauen;

end KIMindestBewertungKartenfeldErmitteln;
