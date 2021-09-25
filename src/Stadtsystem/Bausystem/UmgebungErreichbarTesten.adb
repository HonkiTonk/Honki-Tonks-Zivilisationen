pragma SPARK_Mode (On);

with GlobaleKonstanten, KartenKonstanten;

with LeseKarten;

with KartePositionPruefen, BewegungPassierbarkeitPruefen, EinheitSuchen;

package body UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      GefundeneFelder := 1;
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerYXKartenWert
               then
                  null;
                  
               elsif
                   (YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = 0)
                 or
                   (BereitsGetestet >= abs (YÄnderungSchleifenwert)
                    and
                      BereitsGetestet >= abs (XÄnderungSchleifenwert))
               then
                  null;
                  
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                           KoordinatenExtern => KartenWert)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                          IDExtern           => IDExtern,
                                                                          NeuePositionExtern => KartenWert)
                 = True
                 and
                   NochErreichbar (AktuellePositionExtern => KartenWert,
                                   RasseExtern            => RasseExtern,
                                   IDExtern               => IDExtern)
                 = True
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                           KoordinatenExtern => KartenWert)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                          IDExtern           => IDExtern,
                                                                          NeuePositionExtern => KartenWert)
                 = True
                 and
                   NochErreichbar (AktuellePositionExtern => KartenWert,
                                   RasseExtern            => RasseExtern,
                                   IDExtern               => IDExtern)
                 = True
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Last;
         
         Umgebung := Umgebung + 1;
         BereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
      
      return KartenKonstanten.LeerKartenPosition;
      
   end UmgebungErreichbarTesten;
   
   
   
   function NochErreichbar
     (AktuellePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
              KartenWertZwei.XAchse = KartenKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                        KoordinatenExtern => KartenWertZwei)
              = True
              and
                BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                       IDExtern           => IDExtern,
                                                                       NeuePositionExtern => KartenWertZwei)
              = True
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
