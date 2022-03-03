pragma SPARK_Mode (On);

with KartenKonstanten;
with KartenRecordKonstanten;
with KartenGrundKonstanten;

with SchreibeKarten;
with LeseKarten;

with KarteKoordinatenPruefen;

package body KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartenGrundKonstanten.WasserKonstante =>
                  GewässerFestlegen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                     
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                           LogikGrafikExtern => True);
                        
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Grund (KoordinatenExtern => KartenWert) /= KartenGrundKonstanten.FlachlandKonstante
            then
               null;
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartenGrundKonstanten.KüstengewässerKonstante);
               return;
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GewässerFestlegen;

end KartenGeneratorKueste;
