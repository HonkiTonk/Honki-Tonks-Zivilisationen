pragma SPARK_Mode (On);

with KartenKonstanten, EinheitenKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;

with KartePositionPruefen, StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      MindestBewertungKartenfeld := KIKonstanten.KartenfeldBewertungStadtBauenMinimum (EinheitRasseNummerExtern.Rasse);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                              
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                           ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                     
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                     
               elsif
                 StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                       KoordinatenExtern => KartenWert).Platznummer
                 = EinheitenKonstanten.LeerNummer
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
