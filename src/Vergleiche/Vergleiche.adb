pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with KartenRecordKonstanten;

package body Vergleiche is
   
   function KoordinateLeervergleich
     (KoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        KoordinateExtern /= KartenRecordKonstanten.LeerKartenKoordinaten
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
        KoordinateEinsExtern /= KoordinatenZweiExtern
      then
         return False;
         
      else
         return True;
      end if;
      
   end Koordinatenvergleich;

end Vergleiche;
