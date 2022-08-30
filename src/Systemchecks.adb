pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartenRecords;

package body Systemchecks is

   procedure Größenprüfung
   is begin
      
      New_Line;
      Put_Line (Item => "Bits:" & Integer (KartenRecords.KartengrundRecord'Size)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (KartenRecords.KartengrundRecord'Size / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (KartenRecords.KartengrundRecord'Size / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (KartenRecords.KartengrundRecord'Size / MegabyteTeiler)'Wide_Wide_Image);
      
      New_Line;
      Put_Line (Item => "Bits:" & Integer (BasisGrund'Size + AktuellerGrund'Size)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer ((BasisGrund'Size + AktuellerGrund'Size) / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer ((BasisGrund'Size + AktuellerGrund'Size) / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer ((BasisGrund'Size + AktuellerGrund'Size) / MegabyteTeiler)'Wide_Wide_Image);
      
      return;
      
   end Größenprüfung;

end Systemchecks;
