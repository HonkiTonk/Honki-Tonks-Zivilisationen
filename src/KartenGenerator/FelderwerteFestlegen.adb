pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleVariablen;

with KartePositionPruefen, KartenAllgemein;

package body FelderwerteFestlegen is

   procedure KartenfelderBewerten
     (GenerierungExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      case GenerierungExtern is
         when False =>
            YAchseÄnderungSchleife:
            for YAchseÄnderungSchleifenwert in LoopRangeMinusDreiZuDrei'Range loop
               XAchseÄnderungSchleife:
               for XAchseÄnderungSchleifenwert in LoopRangeMinusDreiZuDrei'Range loop
                  
                  KartenWertEins (KoordinatenExtern.EAchse) := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                             ÄnderungExtern    => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
                  
                  case
                    KartenWertEins (KoordinatenExtern.EAchse).XAchse
                  is
                     when GlobaleKonstanten.LeerYXKartenWert =>
                        null;
                     
                     when others =>                  
                        Karten.Weltkarte (KartenWertEins (KoordinatenExtern.EAchse).EAchse,
                                          KartenWertEins (KoordinatenExtern.EAchse).YAchse,
                                          KartenWertEins (KoordinatenExtern.EAchse).XAchse).Felderwertung := (others => 0);
                        KartenfelderBewertenKleineSchleife (KoordinatenExtern => KartenWertEins (KoordinatenExtern.EAchse));
                  end case;
                  
               end loop XAchseÄnderungSchleife;
            end loop YAchseÄnderungSchleife;
            
         when True =>
            KartenfelderBewertenKleineSchleife (KoordinatenExtern => KoordinatenExtern);
      end case;
      
   end KartenfelderBewerten;
   


   procedure KartenfelderBewertenKleineSchleife
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
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
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  RassenSchleife:
                  for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
                     
                     case
                       GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
                     is
                        when GlobaleDatentypen.Spieler_KI =>
                           if
                             BewertungYÄnderungSchleifenwert = 0
                             and
                               BewertungXÄnderungSchleifenwert = 0
                           then
                              BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                               KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                               RasseExtern               => RasseSchleifenwert,
                                               TeilerExtern              => 1);

                           elsif
                           abs (BewertungYÄnderungSchleifenwert) > abs (BewertungXÄnderungSchleifenwert)
                           then
                              BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                               KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                               RasseExtern               => RasseSchleifenwert,
                                               TeilerExtern              => abs (BewertungYÄnderungSchleifenwert));
                              
                           else
                              BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                               KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                               RasseExtern               => RasseSchleifenwert,
                                               TeilerExtern              => abs (BewertungXÄnderungSchleifenwert));
                           end if;
                           
                        when others =>
                           null;
                     end case;
                     
                  end loop RassenSchleife;
            end case;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;
   
   
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern, KoordinatenUmgebungExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      TeilerExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
        := Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
        + (KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenUmgebungExtern,
                                         RasseExtern    => RasseExtern)
           + KartenAllgemein.GrundProduktion (PositionExtern => KoordinatenUmgebungExtern,
                                              RasseExtern    => RasseExtern)
           + KartenAllgemein.GrundGeld (PositionExtern => KoordinatenUmgebungExtern,
                                        RasseExtern    => RasseExtern)
           + KartenAllgemein.GrundWissen (PositionExtern => KoordinatenUmgebungExtern,
                                          RasseExtern    => RasseExtern)
           + KartenAllgemein.GrundVerteidigung (PositionExtern => KoordinatenUmgebungExtern,
                                                RasseExtern    => RasseExtern))
        / GesamtproduktionStadt (TeilerExtern);

      case
        Karten.Weltkarte (KoordinatenUmgebungExtern.EAchse, KoordinatenUmgebungExtern.YAchse, KoordinatenUmgebungExtern.XAchse).Fluss
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              := Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              + (KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenUmgebungExtern,
                                               RasseExtern    => RasseExtern)
                 + KartenAllgemein.FlussProduktion (PositionExtern => KoordinatenUmgebungExtern,
                                                    RasseExtern    => RasseExtern)
                 + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenUmgebungExtern,
                                              RasseExtern    => RasseExtern)
                 + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenUmgebungExtern,
                                                RasseExtern    => RasseExtern)
                 + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenUmgebungExtern,
                                                      RasseExtern    => RasseExtern))
              / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenUmgebungExtern.EAchse, KoordinatenUmgebungExtern.YAchse, KoordinatenUmgebungExtern.XAchse).VerbesserungStraße
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              := Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              + (KartenAllgemein.StraßeNahrung (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.StraßeRessourcen (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.StraßeGeld (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.StraßeWissen (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.StraßeVerteidigung (PositionExtern => KoordinatenUmgebungExtern)) / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenUmgebungExtern.EAchse, KoordinatenUmgebungExtern.YAchse, KoordinatenUmgebungExtern.XAchse).VerbesserungGebiet
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              := Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              + (KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.VerbesserungRessourcen (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenUmgebungExtern)
                 + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenUmgebungExtern)) / GesamtproduktionStadt (TeilerExtern);
      end case;
      
      case
        Karten.Weltkarte (KoordinatenUmgebungExtern.EAchse, KoordinatenUmgebungExtern.YAchse, KoordinatenUmgebungExtern.XAchse).Ressource
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              := Karten.Weltkarte (KoordinatenFeldExtern.EAchse, KoordinatenFeldExtern.YAchse, KoordinatenFeldExtern.XAchse).Felderwertung (RasseExtern)
              + (KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenUmgebungExtern,
                                                   RasseExtern    => RasseExtern)
                 + KartenAllgemein.RessourceProduktion (PositionExtern => KoordinatenUmgebungExtern,
                                                        RasseExtern    => RasseExtern)
                 + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenUmgebungExtern,
                                                  RasseExtern    => RasseExtern)
                 + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenUmgebungExtern,
                                                    RasseExtern    => RasseExtern)
                 + KartenAllgemein.RessourceVerteidigung (PositionExtern => KoordinatenUmgebungExtern,
                                                          RasseExtern    => RasseExtern))
              / GesamtproduktionStadt (TeilerExtern);
      end case;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
