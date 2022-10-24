pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with System;

private with KartengrundDatentypen;

package Systemchecks is

   procedure Größenprüfung;
   
private
   
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;
   
   BasisGrund : KartengrundDatentypen.Kartengrund_Enum;
   AktuellerGrund : KartengrundDatentypen.Kartengrund_Enum;

end Systemchecks;
