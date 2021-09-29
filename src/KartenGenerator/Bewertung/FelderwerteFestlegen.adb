pragma SPARK_Mode (On);

with GlobaleVariablen, KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartePositionPruefen, KartenAllgemein;

package body FelderwerteFestlegen is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in LoopRangeMinusDreiZuDrei'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in LoopRangeMinusDreiZuDrei'Range loop
                  
            KartenWertEins (KoordinatenExtern.EAchse) := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                       ÄnderungExtern    => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
            
            case
              KartenWertEins (KoordinatenExtern.EAchse).XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                     
               when others =>                  
                  Karten.Weltkarte (KartenWertEins (KoordinatenExtern.EAchse).EAchse,
                                    KartenWertEins (KoordinatenExtern.EAchse).YAchse,
                                    KartenWertEins (KoordinatenExtern.EAchse).XAchse).Felderwertung := (others => 0);
                  KartenfelderBewertenKleineSchleife (KoordinatenExtern => KartenWertEins (KoordinatenExtern.EAchse),
                                                      RasseExtern       => GlobaleDatentypen.Leer);
            end case;
            
         end loop XAchseÄnderungSchleife;
      end loop YAchseÄnderungSchleife;
      
   end EinzelnesKartenfeldBewerten;
   


   procedure KartenfelderBewertenKleineSchleife
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum)
   is begin
      
      BewertungYÄnderungSchleife:
      for BewertungYÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         BewertungXÄnderungSchleife:
         for BewertungXÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWertZwei (KoordinatenExtern.EAchse) := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                       ÄnderungExtern    => (0, BewertungYÄnderungSchleifenwert, BewertungXÄnderungSchleifenwert));

            case
              KartenWertZwei (KoordinatenExtern.EAchse).XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  if
                    BewertungYÄnderungSchleifenwert = 0
                    and
                      BewertungXÄnderungSchleifenwert = 0
                  then
                     BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                      KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                      RasseExtern               => RasseExtern,
                                      TeilerExtern              => 1);

                  elsif
                  abs (BewertungYÄnderungSchleifenwert) > abs (BewertungXÄnderungSchleifenwert)
                  then
                     BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                      KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                      RasseExtern               => RasseExtern,
                                      TeilerExtern              => abs (BewertungYÄnderungSchleifenwert));
                        
                  else
                     BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                      KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                      RasseExtern               => RasseExtern,
                                      TeilerExtern              => abs (BewertungXÄnderungSchleifenwert));
                  end if;
            end case;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;
   
   
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      KoordinatenUmgebungExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum;
      TeilerExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Spieler_KI
           and
             (RasseExtern = GlobaleDatentypen.Leer
              or
                RasseExtern = RasseSchleifenwert)
         then
            SchreibeKarten.Bewertung (PositionExtern  => KoordinatenFeldExtern,
                                      RasseExtern     => RasseSchleifenwert,
                                      BewertungExtern =>
                                        LeseKarten.Bewertung (PositionExtern => KoordinatenFeldExtern,
                                                              RasseExtern    => RasseSchleifenwert)
                                      + KartenAllgemein.GrundBewertung (PositionExtern => KoordinatenUmgebungExtern,
                                                                        RasseExtern    => RasseSchleifenwert)
                                      / GesamtproduktionStadt (TeilerExtern)
                                     );

            case
              LeseKarten.Fluss (PositionExtern => KoordinatenUmgebungExtern)
            is
               when GlobaleDatentypen.Leer =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (PositionExtern  => KoordinatenFeldExtern,
                                            RasseExtern     => RasseSchleifenwert,
                                            BewertungExtern =>
                                               LeseKarten.Bewertung (PositionExtern => KoordinatenFeldExtern,
                                                                     RasseExtern    => RasseSchleifenwert)
                                            + KartenAllgemein.FlussBewertung (PositionExtern => KoordinatenUmgebungExtern,
                                                                              RasseExtern    => RasseSchleifenwert)
                                            / GesamtproduktionStadt (TeilerExtern)
                                           );
            end case;

            case
              LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenUmgebungExtern)
            is
               when GlobaleDatentypen.Leer =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (PositionExtern  => KoordinatenFeldExtern,
                                            RasseExtern     => RasseSchleifenwert,
                                            BewertungExtern =>
                                               LeseKarten.Bewertung (PositionExtern => KoordinatenFeldExtern,
                                                                     RasseExtern    => RasseSchleifenwert)
                                            + KartenAllgemein.WegBewertung (PositionExtern => KoordinatenUmgebungExtern,
                                                                            RasseExtern    => RasseSchleifenwert)
                                            / GesamtproduktionStadt (TeilerExtern)
                                           );
            end case;

            case
              LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenUmgebungExtern)
            is
               when GlobaleDatentypen.Leer =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (PositionExtern  => KoordinatenFeldExtern,
                                            RasseExtern     => RasseSchleifenwert,
                                            BewertungExtern =>
                                               LeseKarten.Bewertung (PositionExtern => KoordinatenFeldExtern,
                                                                     RasseExtern    => RasseSchleifenwert)
                                            + KartenAllgemein.VerbesserungBewertung (PositionExtern => KoordinatenUmgebungExtern,
                                                                                     RasseExtern    => RasseSchleifenwert)
                                            / GesamtproduktionStadt (TeilerExtern)
                                           );
            end case;
      
            case
              LeseKarten.Ressource (PositionExtern => KoordinatenUmgebungExtern)
            is
               when GlobaleDatentypen.Leer =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (PositionExtern  => KoordinatenFeldExtern,
                                            RasseExtern     => RasseSchleifenwert,
                                            BewertungExtern =>
                                               LeseKarten.Bewertung (PositionExtern => KoordinatenFeldExtern,
                                                                     RasseExtern    => RasseSchleifenwert)
                                            + KartenAllgemein.RessourceBewertung (PositionExtern => KoordinatenUmgebungExtern,
                                                                                  RasseExtern    => RasseSchleifenwert)
                                            / GesamtproduktionStadt (TeilerExtern)
                                           );
            end case;
               
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
