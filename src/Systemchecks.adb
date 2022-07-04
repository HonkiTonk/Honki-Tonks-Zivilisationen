pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

-- with EinheitenRecords;

package body Systemchecks is

   procedure Größenprüfung
   is begin
      
      -- New_Line;
      -- Put_Line (Item => "Bits:" & Integer (EinheitenRecords.EinheitenGebautRecord'Size)'Wide_Wide_Image);
      -- Put_Line (Item => "Bytes:" & Integer (EinheitenRecords.EinheitenGebautRecord'Size / ByteTeiler)'Wide_Wide_Image);
      -- Put_Line (Item => "Kilobytes:" & Integer (EinheitenRecords.EinheitenGebautRecord'Size / KilobyteTeiler)'Wide_Wide_Image);
      -- Put_Line (Item => "Megabytes:" & Integer (EinheitenRecords.EinheitenGebautRecord'Size / MegabyteTeiler)'Wide_Wide_Image);
      
      return;
      
   end Größenprüfung;

end Systemchecks;
