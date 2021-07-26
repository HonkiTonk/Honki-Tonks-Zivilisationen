package Notizen is

   -- Wenn man das in die KartePositionPruefen einbaut erhält man einen Tugel, später als alternatives Planetenmodell einbauen?
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
   -- Wenn man das in die KartePositionPruefen einbaut erhält man einen Torus, später als alternatives Planetenmodell einbauen?

end Notizen;
