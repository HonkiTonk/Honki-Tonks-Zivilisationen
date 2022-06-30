pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

package body Vergleiche is
   
   function KoordinateLeervergleich
     (KoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        KoordinateExtern.EAchse /= KartenRecordKonstanten.LeerKoordinate.EAchse
        or
          KoordinateExtern.YAchse /= KartenRecordKonstanten.LeerKoordinate.YAchse
          or
            KoordinateExtern.XAchse /= KartenRecordKonstanten.LeerKoordinate.XAchse
      then
         return False;
         
      else
         return True;
      end if;
      
   end KoordinateLeervergleich;
   
   
   
   function Koordinatenvergleich
     (KoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        KoordinateEinsExtern.EAchse /= KoordinatenZweiExtern.EAchse
        or
          KoordinateEinsExtern.YAchse /= KoordinatenZweiExtern.YAchse
          or
            KoordinateEinsExtern.XAchse /= KoordinatenZweiExtern.XAchse
      then
         return False;
         
      else
         return True;
      end if;
      
   end Koordinatenvergleich;

end Vergleiche;
