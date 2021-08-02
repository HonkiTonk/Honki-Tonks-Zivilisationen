pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, BewegungPassierbarkeitPruefen, FeldTesten, EinheitSuchen;

package body UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      NotwendigeFelderExtern : in Positive)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      GefundeneFelder := 1;
      Umgebung := 1;
      YAchseBereitsGetestet := Umgebung - 1;
      XAchseBereitsGetestet := Umgebung - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
                           
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
               
               if
                 KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                 or
                   (YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = 0)
                 or
                   (YAchseBereitsGetestet >= abs (YÄnderungSchleifenwert)
                    and
                      XAchseBereitsGetestet >= abs (XÄnderungSchleifenwert))
               then
                  null;
                     
               elsif
                 FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                                 KoordinatenExtern => KartenWert) = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                          IDExtern           => IDExtern,
                                                                          NeuePositionExtern => KartenWert) = True
                 and
                   NochErreichbar (AktuellePositionExtern => KartenWert,
                                   RasseExtern            => RasseExtern,
                                   IDExtern               => IDExtern) = True
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                                 KoordinatenExtern => KartenWert) = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                          IDExtern           => IDExtern,
                                                                          NeuePositionExtern => KartenWert) = True
                 and
                   NochErreichbar (AktuellePositionExtern => KartenWert,
                                   RasseExtern            => RasseExtern,
                                   IDExtern               => IDExtern) = True
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Last;
         
         Umgebung := Umgebung + 1;
         YAchseBereitsGetestet := Umgebung - 1;
         XAchseBereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
      
      return GlobaleKonstanten.LeerKartenPosition;
      
   end UmgebungErreichbarTesten;
   
   
   
   function NochErreichbar
     (AktuellePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWertZwei := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => AktuellePositionExtern,
                                                                            ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWertZwei.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                              KoordinatenExtern => KartenWertZwei) = True
              and
                BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                       IDExtern           => IDExtern,
                                                                       NeuePositionExtern => KartenWertZwei) = True
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
        
   end NochErreichbar;

end UmgebungErreichbarTesten;
