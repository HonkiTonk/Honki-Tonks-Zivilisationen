pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Karten;

package body KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmenYAchse
     (KoordinatenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.YXAchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
        or
          KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            return KoordinatenExtern.YAchse - KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            return KoordinatenExtern.YAchse + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;    
         
      else
         return KoordinatenExtern.YAchse;
      end if;
      
   end PositionBestimmenYAchse;
   
   
   
   function PositionBestimmenXAchse
     (KoordinatenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.YXAchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            return KoordinatenExtern.XAchse - KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            return KoordinatenExtern.XAchse + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
               
      else
         return KoordinatenExtern.XAchse;
      end if;
      
   end PositionBestimmenXAchse;

end KartePositionVerschobenerUebergangBerechnungen;
