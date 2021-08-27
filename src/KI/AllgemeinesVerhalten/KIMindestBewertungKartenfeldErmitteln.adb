pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;

with KartePositionPruefen, StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MindestBewertungKartenfeld := KIKonstanten.KartenfeldBewertungStadtBauenMinimum (EinheitRasseNummerExtern.Rasse);
      
      EAchseSchleife:
      for EAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                              
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                           ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                     
               case
                 KartenWert.XAchse
               is
                  when GlobaleKonstanten.LeerYXKartenWert =>
                     null;
                     
                  when others =>               
                     if
                       StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => KartenWert).Platznummer
                       = GlobaleKonstanten.LeerEinheitStadtNummer
                     then
                        null;
                        
                     else
                        MindestBewertungKartenfeld := MindestBewertungKartenfeld + 2;
                     end if;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return MindestBewertungKartenfeld;
      
   end MindestBewertungKartenfeldStadtBauen;

end KIMindestBewertungKartenfeldErmitteln;
