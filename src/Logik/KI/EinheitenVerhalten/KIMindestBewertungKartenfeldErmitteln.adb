pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;

with KarteKoordinatenPruefen;
with StadtSuchen;

package body KIMindestBewertungKartenfeldErmitteln is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.GesamtbewertungFeld
   is begin
      
      MindestBewertungKartenfeld := KIKonstanten.KartenfeldBewertungStadtBauenMinimum (EinheitRasseNummerExtern.Rasse);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                              
               KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                              ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                              LogikGrafikExtern => True);
                     
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
