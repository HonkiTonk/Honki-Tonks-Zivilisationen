pragma SPARK_Mode (On);

with GlobaleKonstanten, KartenKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;

with KartePositionPruefen, StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
                     
               if
                 KartenWert.XAchse = KartenKonstanten.LeerYXKartenWert
               then
                  null;
                     
               elsif
                 StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                       KoordinatenExtern => KartenWert).Platznummer
                 = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                        
               else
                  MindestBewertungKartenfeld := MindestBewertungKartenfeld + 2;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return MindestBewertungKartenfeld;
      
   end MindestBewertungKartenfeldStadtBauen;

end KIMindestBewertungKartenfeldErmitteln;
