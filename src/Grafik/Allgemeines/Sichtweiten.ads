pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

private with KartenRecords;

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
   
   type SichtweitenArray is array (1 .. 3) of KartenRecords.AchsenKartenfeldNaturalRecord;
   SichtweitenStandard : constant SichtweitenArray := (1 => (0, 6, 6),
                                                       2 => (0, 10, 10),
                                                       3 => (0, 15, 15));

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, SichtweitenStandard (1).YAchse - 1, SichtweitenStandard (1).XAchse - 1),
                                                 2 => (0, SichtweitenStandard (2).YAchse - 1, SichtweitenStandard (2).XAchse - 1),
                                                 3 => (0, SichtweitenStandard (3).YAchse - 1, SichtweitenStandard (3).XAchse - 1));

   SichtweitenTerminalStandard : constant SichtweitenArray := (1 => (0, 6, 8),
                                                              2 => (0, 6, 16),
                                                              3 => (0, 6, 24));
   
   BewegungsfeldTerminal : constant SichtweitenArray := (1 => (0, SichtweitenTerminalStandard (1).YAchse - 1, SichtweitenTerminalStandard (1).XAchse - 1),
                                                        2 => (0, SichtweitenTerminalStandard (2).YAchse - 1, SichtweitenTerminalStandard (2).XAchse - 1),
                                                        3 => (0, SichtweitenTerminalStandard (3).YAchse - 1, SichtweitenTerminalStandard (3).XAchse - 1));

end Sichtweiten;
