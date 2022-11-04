pragma Warnings (Off, "*array aggregate*");

private with System;

package Systemchecks is

   procedure Größenprüfung;
   
private
   
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;

end Systemchecks;
