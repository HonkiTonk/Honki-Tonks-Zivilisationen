pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen;
   
   procedure ZoomstufeÄndern
     (HöherTieferExtern : in Boolean);
   
   
   
   function SichtweiteLesen
      return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
      return KartenDatentypen.KartenfeldPositiv;
   
private
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 8;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := 4;

   --  SichtweitenTerminalStandard : constant SichtweitenArray := (1 => (0, 6, 8),
   --                                                             2 => (0, 6, 16),
   --                                                             3 => (0, 6, 24));
   
   --  BewegungsfeldTerminal : constant SichtweitenArray := (1 => (0, SichtweitenTerminalStandard (1).YAchse - 1, SichtweitenTerminalStandard (1).XAchse - 1),
   --                                                       2 => (0, SichtweitenTerminalStandard (2).YAchse - 1, SichtweitenTerminalStandard (2).XAchse - 1),
   --                                                       3 => (0, SichtweitenTerminalStandard (3).YAchse - 1, SichtweitenTerminalStandard (3).XAchse - 1));

end Sichtweiten;
