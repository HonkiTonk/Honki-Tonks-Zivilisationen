pragma SPARK_Mode (On);

with GlobaleKonstanten;

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
            return KartenPositionXZylinder (KoordinatenExtern    => KoordinatenExtern,
                                            ÄnderungExtern       => ÄnderungExtern);
            
         when GlobaleDatentypen.Y_Zylinder =>
            return KartenPositionYZylinder (KoordinatenExtern    => KoordinatenExtern,
                                            ÄnderungExtern       => ÄnderungExtern);
            
         when GlobaleDatentypen.Torus =>
            return KartenPositionTorus (KoordinatenExtern    => KoordinatenExtern,
                                        ÄnderungExtern       => ÄnderungExtern);
            
         when GlobaleDatentypen.Kugel =>
            return KartenPositionKugel (KoordinatenExtern    => KoordinatenExtern,
                                        ÄnderungExtern       => ÄnderungExtern);
            
         when GlobaleDatentypen.Viereck =>
            return KartenPositionViereck (KoordinatenExtern    => KoordinatenExtern,
                                          ÄnderungExtern       => ÄnderungExtern);
            
         when GlobaleDatentypen.Leer =>
            return KartenPositionXZylinder (KoordinatenExtern    => KoordinatenExtern,
                                            ÄnderungExtern       => ÄnderungExtern);
      end case;
      
   end KartenPositionBestimmen;
   
   
   
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
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                        ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

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
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                        ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert =>
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

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
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenYAchse (KoordinatenExtern => KoordinatenExtern,
                                                                                 ÄnderungExtern   => ÄnderungExtern);
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenXAchse (KoordinatenExtern => (0, PositionAchse (KoordinatenExtern.EAchse).YAchse, PositionAchse (KoordinatenExtern.EAchse).XAchse),
                                                                                 ÄnderungExtern   => ÄnderungExtern);

      PositionAchse (KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse + ÄnderungExtern.EAchse;

      return PositionAchse (KoordinatenExtern.EAchse);
      
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
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                        ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
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
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                        ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;
      
      XAchse (KoordinatenExtern.EAchse) := PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                        ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert =>
            return GlobaleKonstanten.RückgabeKartenPositionFalsch;

         when others =>
            null;
      end case;

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionViereck;
   
   
   
   -- Nicht löschen, siehe Kommentar in der Funktion
   function KartenPositionBestimmena
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Das ist kein Torus sondern halb Torus und halb Kugel, also ein Tugel
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenYAchse (KoordinatenExtern => KoordinatenExtern,
                                                                                 ÄnderungExtern   => ÄnderungExtern);
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenXAchse (KoordinatenExtern => (0, PositionAchse (KoordinatenExtern.EAchse).YAchse, PositionAchse (KoordinatenExtern.EAchse).XAchse),
                                                                                 ÄnderungExtern   => ÄnderungExtern);

      PositionAchse (KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse + ÄnderungExtern.EAchse;

      return PositionAchse (KoordinatenExtern.EAchse);
      
   end KartenPositionBestimmena;
   
   
   
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
         while ÜberhangXAchse (ArrayPositionExtern) < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (ArrayPositionExtern) := ÜberhangXAchse (ArrayPositionExtern) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

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
         while ÜberhangYAchse (ArrayPositionExtern) < Integer (Karten.WeltkarteArray'First (2)) loop
            
            ÜberhangYAchse (ArrayPositionExtern) := ÜberhangYAchse (ArrayPositionExtern) + Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

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
   
   
   
   function KartenPositionBestimmenYAchse
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
                      
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (2)) loop
                                                                  
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
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
         
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
      else
         return (0, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   end KartenPositionBestimmenYAchse;
   
   
   
   function KartenPositionBestimmenXAchse
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
                                                                  
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (0, KoordinatenExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (0, KoordinatenExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (0, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionBestimmenXAchse;
   
end KartePositionPruefen;
