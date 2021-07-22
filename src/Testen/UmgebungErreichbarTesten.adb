pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, BewegungPassierbarkeitPruefen, FeldTesten, EinheitSuchen;

package body UmgebungErreichbarTesten is

   -- Später noch abfragen für die Technologie einbauen, wenn Schiffahrt möglich dann auch das Platzieren von Einheiten, sonst nicht
   -- Ist das sinnvooll? Eventuell braucht man dann ständig Transporter um Einheiten von einer einzelnen Insel abzuholen
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                        
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                        ÄnderungExtern   => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = 0
            then
               null;
               
            else
               Schleife:
               for A in MöglicheFelderArray'Range loop                  
                  
                  if
                    KartenWert = MöglicheFelder (A)
                    and
                      KartenWert /= GlobaleKonstanten.RückgabeKartenPositionFalsch
                  then
                     Möglich := True;
                     exit Schleife;

                  else
                     Möglich := False;
                  end if;
               end loop Schleife;

               if
                 Möglich = False
               then
                  null;

               else               
                  if
                    FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                                    KoordinatenExtern => KartenWert) = False
                  then
                     null;
               
                  elsif
                    BewegungPassierbarkeitPruefen.EinfachePassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                                   IDExtern           => IDExtern,
                                                                                   NeuePositionExtern => KartenWert) = False
                  then
                     null;
               
                  elsif
                    EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer /= GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                  then
                     null;
               
                  else
                     return KartenWert;
                  end if;
            
                  if
                    FeldTesten.BelegterGrundTesten (RasseExtern       => RasseExtern,
                                                    KoordinatenExtern => KartenWert) = False
                  then
                     null;
               
                  elsif
                    BewegungPassierbarkeitPruefen.EinfachePassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                                   IDExtern           => IDExtern,
                                                                                   NeuePositionExtern => KartenWert) = False
                  then
                     null;
               
                  else               
                     KartenWertNeu := UmgebungErreichbarTesten (AktuelleKoordinatenExtern => KartenWert,
                                                                RasseExtern               => RasseExtern,
                                                                IDExtern                  => IDExtern);
               
                     case
                       KartenWertNeu.XAchse
                     is
                        when 0 =>
                           null;
                        
                        when others =>
                           return KartenWertNeu;
                     end case;
                  end if;
               end if;
            end if;
            
         end loop XAchseÄnderungSchleife;
      end loop YAchseÄnderungSchleife;
      
      return GlobaleKonstanten.RückgabeKartenPositionFalsch;
      
   end UmgebungErreichbarTesten;

end UmgebungErreichbarTesten;
