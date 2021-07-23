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
                           
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => AktuelleKoordinatenExtern,
                                                                           ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
               
               if
                 KartenWert.YAchse = 0            
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
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                 and
                   BewegungPassierbarkeitPruefen.EinfachePassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                                  IDExtern           => IDExtern,
                                                                                  NeuePositionExtern => KartenWert) = True
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                                 KoordinatenExtern => KartenWert) = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                 and
                   BewegungPassierbarkeitPruefen.EinfachePassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                                  IDExtern           => IDExtern,
                                                                                  NeuePositionExtern => KartenWert) = True
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = 3;
         
         Umgebung := Umgebung + 1;
         YAchseBereitsGetestet := Umgebung - 1;
         XAchseBereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
      
      return GlobaleKonstanten.RückgabeKartenPositionFalsch;
      
   end UmgebungErreichbarTesten;

end UmgebungErreichbarTesten;
