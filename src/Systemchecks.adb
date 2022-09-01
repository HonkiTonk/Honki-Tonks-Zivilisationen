pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartenRecords;

package body Systemchecks is

   procedure Größenprüfung
   is begin
      
      New_Line;
      Put_Line (Item => "Bits:" & Integer (WeltkarteRecords.WeltkarteRecord'Size * 5_000_000)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (WeltkarteRecords.WeltkarteRecord'Size * 5_000_000 / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (WeltkarteRecords.WeltkarteRecord'Size * 5_000_000 / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (WeltkarteRecords.WeltkarteRecord'Size * 5_000_000 / MegabyteTeiler)'Wide_Wide_Image);
      
   end Größenprüfung;

end Systemchecks;
