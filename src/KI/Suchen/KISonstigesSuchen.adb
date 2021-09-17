pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseKarten;

with KartePositionPruefen, BewegungPassierbarkeitPruefen;

package body KISonstigesSuchen is

   function EigenesFeldSuchen
     (AktuellePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      Bereich := 1;
      BereichGeprüft := Bereich - 1;
      
      FeldSuchenSchleife:
      loop
         
         Ziel := ZielSuchen (AktuellePositionExtern   => AktuellePositionExtern,
                             EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         exit FeldSuchenSchleife when Ziel.XAchse /= GlobaleKonstanten.LeerYXKartenWert;
         exit FeldSuchenSchleife when Bereich = GlobaleDatentypen.Sichtweite'Last;
         
         Bereich := Bereich + 1;
         BereichGeprüft := Bereich - 1;
      
      end loop FeldSuchenSchleife;
              
      return Ziel;
   
   end EigenesFeldSuchen;
   
   
   
   function ZielSuchen
     (AktuellePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Bereich .. Bereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Bereich .. Bereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => AktuellePositionExtern,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                        KoordinatenExtern => KartenWert)
              = True
              and
                BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                           NeuePositionExtern       => KartenWert)
              = True
            then
               return KartenWert;
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.LeerKoordinate;
      
   end ZielSuchen;

end KISonstigesSuchen;
