pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

with SchreibeKarten;
with LeseKarten;

with KarteKoordinatenPruefen;
with KartenAllgemein;

package body FelderwerteFestlegen is
   
   -- Bei Bewertung auch die EAchse berücksichtigen? Mal drüber nachdenken ob das sinnvoll ist.
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                  
            KartenWertEins (KoordinatenExtern.EAchse) := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                          ÄnderungExtern    => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert),
                                                                                                          LogikGrafikExtern => True);
            
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
                                                      RasseExtern       => EinheitenKonstanten.LeerRasse);
            end case;
            
         end loop XAchseÄnderungSchleife;
      end loop YAchseÄnderungSchleife;
      
   end EinzelnesKartenfeldBewerten;
   


   procedure KartenfelderBewertenKleineSchleife
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
      BewertungYÄnderungSchleife:
      for BewertungYÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         BewertungXÄnderungSchleife:
         for BewertungXÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWertZwei (KoordinatenExtern.EAchse) := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                          ÄnderungExtern    => (0, BewertungYÄnderungSchleifenwert, BewertungXÄnderungSchleifenwert),
                                                                                                          LogikGrafikExtern => True);

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
      RasseExtern : in SystemDatentypen.Rassen_Enum;
      TeilerExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_KI_Enum
           and
             (RasseExtern = EinheitenKonstanten.LeerRasse
              or
                RasseExtern = RasseSchleifenwert)
         then
            SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenFeldExtern,
                                      RasseExtern        => RasseSchleifenwert,
                                      BewertungExtern    =>
                                        LeseKarten.Bewertung (KoordinatenExtern => KoordinatenFeldExtern,
                                                              RasseExtern       => RasseSchleifenwert)
                                      + KartenAllgemein.GrundBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                        RasseExtern       => RasseSchleifenwert)
                                      / KartenDatentypen.BewertungFeld (TeilerExtern)
                                     );

            case
              LeseKarten.Fluss (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenGrundDatentypen.Leer_Fluss_Enum =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenFeldExtern,
                                            RasseExtern        => RasseSchleifenwert,
                                            BewertungExtern    =>
                                               LeseKarten.Bewertung (KoordinatenExtern => KoordinatenFeldExtern,
                                                                     RasseExtern       => RasseSchleifenwert)
                                            + KartenAllgemein.FlussBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                              RasseExtern       => RasseSchleifenwert)
                                            / KartenDatentypen.BewertungFeld (TeilerExtern)
                                           );
            end case;

            case
              LeseKarten.Weg (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenFeldExtern,
                                            RasseExtern        => RasseSchleifenwert,
                                            BewertungExtern    =>
                                               LeseKarten.Bewertung (KoordinatenExtern => KoordinatenFeldExtern,
                                                                     RasseExtern       => RasseSchleifenwert)
                                            + KartenAllgemein.WegBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                            RasseExtern       => RasseSchleifenwert)
                                            / KartenDatentypen.BewertungFeld (TeilerExtern)
                                           );
            end case;

            case
              LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenFeldExtern,
                                            RasseExtern        => RasseSchleifenwert,
                                            BewertungExtern    =>
                                               LeseKarten.Bewertung (KoordinatenExtern => KoordinatenFeldExtern,
                                                                     RasseExtern       => RasseSchleifenwert)
                                            + KartenAllgemein.VerbesserungBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                     RasseExtern       => RasseSchleifenwert)
                                            / KartenDatentypen.BewertungFeld (TeilerExtern)
                                           );
            end case;
      
            case
              LeseKarten.Ressource (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenGrundDatentypen.Leer_Ressource_Enum =>
                  null;
            
               when others =>
                  SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenFeldExtern,
                                            RasseExtern        => RasseSchleifenwert,
                                            BewertungExtern    =>
                                               LeseKarten.Bewertung (KoordinatenExtern => KoordinatenFeldExtern,
                                                                     RasseExtern       => RasseSchleifenwert)
                                            + KartenAllgemein.RessourceBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                  RasseExtern       => RasseSchleifenwert)
                                            / KartenDatentypen.BewertungFeld (TeilerExtern)
                                           );
            end case;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
