pragma SPARK_Mode (On);

package body KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartenform
      is
         when GlobaleDatentypen.X_Zylinder =>
            return KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                            ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Y_Zylinder =>
            return KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                            ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Torus =>
            return KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                        ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Kugel =>
            return KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                        ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Viereck =>
            return KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                          ÄnderungExtern    => ÄnderungExtern);

         when GlobaleDatentypen.Kugel_Gedreht =>
            return KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                               ÄnderungExtern    => ÄnderungExtern);
            
            -- Hier soll er die Sachen aus Kugel und Torus zusammen machen
         when GlobaleDatentypen.Tugel =>
            return KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                        ÄnderungExtern    => ÄnderungExtern);
      end case;
      
   end KartenPositionBestimmen;
   
   
   
   -- Kartenformen
   function KartenPositionXZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                        ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                      ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
      
   end KartenPositionXZylinder;
   
   
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                        ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                      ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionYZylinder;
   
   
   
   function KartenPositionTorus
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                      ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                      ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTorus;
   
   
   
   function KartenPositionKugel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (KoordinatenExtern.EAchse) := PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                         ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := ZwischenPositionAchse (KoordinatenExtern.EAchse).YAchse;
      
      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                      ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionKugel;
   
   
   
   function KartenPositionViereck
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                        ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
      
      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                        ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionViereck;
   
   
   
   function KartenPositionKugelGedreht
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (KoordinatenExtern.EAchse) := PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                         ÄnderungExtern    => ÄnderungExtern);
      
      XAchse (KoordinatenExtern.EAchse) := ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse;
      
      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).YAchse,
                                                                      ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionKugelGedreht;
   
   
   
   function KartenPositionTugel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return GlobaleKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (KoordinatenExtern.EAchse) := PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                         ÄnderungExtern    => ÄnderungExtern);
      
      ZwischenPositionTugelAchse (KoordinatenExtern.EAchse) := PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                              ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (KoordinatenExtern.EAchse).YAchse,
                                                                      ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
            
      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                      ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTugel;
   -- Kartenformen
   
   
   
   -- Berechnungen
   function PositionBestimmenEAchseFest
     (EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
        or
          EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleDatentypen.Ebene'First;
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end PositionBestimmenEAchseFest;
   
   
   
   function PositionBestimmenYAchseFest
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
        or
          YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         return GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end PositionBestimmenYAchseFest;
   
   
   
   function PositionBestimmenXAchseFest
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
        or
          XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end PositionBestimmenXAchseFest;



   function PositionBestimmenXWechsel
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv
   is begin

      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (ArrayPositionExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (ArrayPositionExtern) := ÜberhangXAchse (ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (ArrayPositionExtern));
               
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (ArrayPositionExtern) := ÜberhangXAchse (ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (ArrayPositionExtern));
               
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;

   end PositionBestimmenXWechsel;



   function PositionBestimmenYWechsel
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv
   is begin

      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
      then
         ÜberhangYAchse (ArrayPositionExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (2)) loop
            
            ÜberhangYAchse (ArrayPositionExtern) := ÜberhangYAchse (ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (ArrayPositionExtern));
               
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         ÜberhangYAchse (ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (ArrayPositionExtern) := ÜberhangYAchse (ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (ArrayPositionExtern));
               
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;

   end PositionBestimmenYWechsel;
   
   
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;

         if
           KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = GlobaleKonstanten.LeerYXKartenWert
         then
            return (0, 1, PolXAchse (KoordinatenExtern.EAchse));

         else
            return (0, abs (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse), PolXAchse (KoordinatenExtern.EAchse));
         end if;
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             ÄnderungExtern.YAchse = 1
         then
            return (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, PolXAchse (KoordinatenExtern.EAchse));
            
         else
            return (0, abs (KoordinatenExtern.YAchse - ÄnderungExtern.YAchse), PolXAchse (KoordinatenExtern.EAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = GlobaleKonstanten.LeerYXKartenWert
      then
         return (0, 1, KoordinatenExtern.XAchse);

      else
         return (0, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   end PositionBestimmen_Y_X_Wechsel;
   
   
   
   function PositionBestimmen_X_Y_Wechsel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;

         if
           KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = GlobaleKonstanten.LeerYXKartenWert
         then
            return (0, PolYAchse (KoordinatenExtern.EAchse), 1);

         else
            return (0, PolYAchse (KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse));
         end if;
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
           and
             ÄnderungExtern.XAchse = 1
         then
            return (0, PolYAchse (KoordinatenExtern.EAchse), Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         else
            return (0, PolYAchse (KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse - ÄnderungExtern.XAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = GlobaleKonstanten.LeerYXKartenWert
      then
         return (0, KoordinatenExtern.YAchse, 1);

      else
         return (0, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end PositionBestimmen_X_Y_Wechsel;
   -- Berechnungen
   
end KartePositionPruefen;
