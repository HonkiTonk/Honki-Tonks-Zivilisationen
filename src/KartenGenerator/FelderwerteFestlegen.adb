pragma SPARK_Mode (On);

with KartenDatenbank, VerbesserungenDatenbank;
  
with KartenPruefungen;

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

                  KartenWertEins (KoordinatenExtern.EAchse) := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                                                                         ÄnderungExtern       => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));

                  exit XAchseÄnderungSchleife when KartenWertEins (KoordinatenExtern.EAchse).YAchse = 0;
                  
                  Karten.Weltkarte (KartenWertEins (KoordinatenExtern.EAchse).EAchse, KartenWertEins (KoordinatenExtern.EAchse).YAchse, KartenWertEins (KoordinatenExtern.EAchse).XAchse).Felderwertung := 0;
                  KartenfelderBewertenKleineSchleife (KoordinatenExtern => KartenWertEins (KoordinatenExtern.EAchse));
                                                            
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
                     
            KartenWertZwei (KoordinatenExtern.EAchse) := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                                                                   ÄnderungExtern       => (0, BewertungYÄnderungSchleifenwert, BewertungXÄnderungSchleifenwert));
            
            exit BewertungXÄnderungSchleife when KartenWertZwei (KoordinatenExtern.EAchse).YAchse = 0;

            if
              BewertungYÄnderungSchleifenwert = 2
              or
                BewertungYÄnderungSchleifenwert = -2
                or
                  BewertungXÄnderungSchleifenwert = 2
                  or
                    BewertungXÄnderungSchleifenwert = -2
            then
               BewertungSelbst (KoordinatenExtern         => KoordinatenExtern,
                                YAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).YAchse,
                                XAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).XAchse,
                                TeilerExtern              => 2);

            elsif
              BewertungYÄnderungSchleifenwert = 3
              or
                BewertungYÄnderungSchleifenwert = -3
                or
                  BewertungXÄnderungSchleifenwert = 3
                  or
                    BewertungXÄnderungSchleifenwert = -3
            then
               BewertungSelbst (KoordinatenExtern         => KoordinatenExtern,
                                YAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).YAchse,
                                XAchseFeldAufschlagExtern => KartenWertZwei (KoordinatenExtern.EAchse).XAchse,
                                TeilerExtern              => 3);

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
        + (KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Grund).Nahrungsgewinnung
           + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Grund).Ressourcengewinnung
           + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Grund).Geldgewinnung
           + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Grund).Wissensgewinnung
           + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Grund).Verteidigungsbonus) / GesamtproduktionStadt (TeilerExtern);

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss
      is
         when 0 =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss).Nahrungsgewinnung
                 + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss).Ressourcengewinnung
                 + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss).Geldgewinnung
                 + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss).Wissensgewinnung
                 + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).Fluss).Verteidigungsbonus) / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße
      is
         when 0 =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße).Nahrungsbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße).Ressourcenbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße).Geldbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße).Wissensbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungStraße).Verteidigungsbonus)
              / GesamtproduktionStadt (TeilerExtern);
      end case;

      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet
      is
         when 0 =>
            null;
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung
              + (VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet).Nahrungsbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet).Ressourcenbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet).Geldbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet).Wissensbonus
                 + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern).VerbesserungGebiet).Verteidigungsbonus)
              / GesamtproduktionStadt (TeilerExtern);
      end case;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
