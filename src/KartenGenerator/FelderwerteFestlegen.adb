pragma SPARK_Mode (On);

with GlobaleKonstanten;

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
                        Karten.Weltkarte (KartenWertEins (KoordinatenExtern.EAchse).EAchse, KartenWertEins (KoordinatenExtern.EAchse).YAchse, KartenWertEins (KoordinatenExtern.EAchse).XAchse).Felderwertung := 0;
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

            if
              KartenWertZwei (KoordinatenExtern.EAchse).XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
            
            elsif
            abs (BewertungYÄnderungSchleifenwert) = 3
              or
            abs (BewertungXÄnderungSchleifenwert) = 3
            then
               BewertungSelbst (KoordinatenExtern         => KoordinatenExtern,
                                YAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).YAchse,
                                XAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).XAchse,
                                TeilerExtern              => 3);

            elsif
            abs (BewertungYÄnderungSchleifenwert) = 2
              or
            abs (BewertungXÄnderungSchleifenwert) = 2
            then
               BewertungSelbst (KoordinatenExtern         => KoordinatenExtern,
                                YAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).YAchse,
                                XAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).XAchse,
                                TeilerExtern              => 2);

               

            else
               BewertungSelbst (KoordinatenExtern         => KoordinatenExtern,
                                YAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).YAchse,
                                XAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).XAchse,
                                TeilerExtern              => 1);
            end if;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;
   
   
   
   procedure BewertungSelbst
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern : in GlobaleDatentypen.KartenfeldPositiv;
      TeilerExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
            
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
        := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
        + (KartenAllgemein.GrundNahrung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
           + KartenAllgemein.GrundRessourcen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
           + KartenAllgemein.GrundGeld (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
           + KartenAllgemein.GrundWissen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
           + KartenAllgemein.GrundVerteidigung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))) / GesamtproduktionStadt (TeilerExtern);

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (KartenAllgemein.FlussNahrung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.FlussRessourcen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.FlussGeld (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.FlussWissen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.FlussVerteidigung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))) / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (KartenAllgemein.StraßeNahrung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.StraßeRessourcen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.StraßeGeld (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.StraßeWissen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.StraßeVerteidigung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))) / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (KartenAllgemein.VerbesserungNahrung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.VerbesserungRessourcen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.VerbesserungGeld (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.VerbesserungWissen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))) / GesamtproduktionStadt (TeilerExtern);
      end case;
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Ressource
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (KartenAllgemein.RessourceNahrung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.RessourceRessourcen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.RessourceGeld (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.RessourceWissen (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))
                 + KartenAllgemein.RessourceVerteidigung (PositionExtern => (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern))) / GesamtproduktionStadt (TeilerExtern);
      end case;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
