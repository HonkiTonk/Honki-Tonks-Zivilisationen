pragma SPARK_Mode (On);

with System;

with GlobaleRecords;

with Karten;

package Programmanalyse is

   procedure Auswahl;

private
   
   Taste : Wide_Wide_Character;

   Bit : constant Float := Float (Karten.WeltkarteArray'Size);
   Byte : constant Float := Bit / Float (System.Storage_Unit);
   Kilobyte : constant Float := Bit / Float ((System.Storage_Unit * 1_024));
   Megabyte : constant Float := Bit / Float ((System.Storage_Unit * 1_024**2));

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure DatentypGröße;
   
   procedure KartenfelderBewertenTesten;

end Programmanalyse;
