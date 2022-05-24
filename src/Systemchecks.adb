pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Systemchecks is

   procedure Größenprüfung
   is begin
      
      -- New_Line;
      -- Put_Line (Item => "Bits:" & Integer (KartenRecords.FelderwertungArray'Size)'Image);
      -- Put_Line (Item => "Bytes:" & Integer (KartenRecords.FelderwertungArray'Size / ByteTeiler)'Image);
      -- Put_Line (Item => "Kilobytes:" & Integer (KartenRecords.FelderwertungArray'Size / KilobyteTeiler)'Image);
      -- Put_Line (Item => "Megabytes:" & Integer (KartenRecords.FelderwertungArray'Size / MegabyteTeiler)'Image);
      
      return;
      
   end Größenprüfung;

end Systemchecks;
