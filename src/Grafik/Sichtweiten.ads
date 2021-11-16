pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

package Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen;
   
   
   
   function SichtweiteLesen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;
   
private
   
   SichtweiteFestlegen : Positive;
   BewegungsfeldFestlegen : Positive;
   
   type SichtweitenArray is array (1 .. 3) of KartenRecords.AchsenKartenfeldPositivRecord;
   SichtweitenStandard : constant SichtweitenArray := (1 => (0, 6, 6),
                                                       2 => (0, 10, 10),
                                                       3 => (0, 15, 15));

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, SichtweitenStandard (1).YAchse - 1, SichtweitenStandard (1).XAchse - 1),
                                                 2 => (0, SichtweitenStandard (2).YAchse - 1, SichtweitenStandard (2).XAchse - 1),
                                                 3 => (0, SichtweitenStandard (3).YAchse - 1, SichtweitenStandard (3).XAchse - 1));

   SichtweitenKonsoleStandard : constant SichtweitenArray := (1 => (0, 6, 8),
                                                              2 => (0, 6, 16),
                                                              3 => (0, 6, 24));

end Sichtweiten;
