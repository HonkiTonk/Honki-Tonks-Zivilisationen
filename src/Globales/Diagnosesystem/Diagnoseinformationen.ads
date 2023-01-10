private with System;

with KartenRecords;
with EinheitenRecords;
with StadtRecords;

package Diagnoseinformationen is
   pragma Elaborate_Body;
   
   procedure Größenprüfung;
   
   procedure Zahl
     (ZahlExtern : in Integer);

   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure Einheiteninformationen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord);
   
   procedure Stadtinformationen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord);
   
   procedure Grundinformationen
     (GrundExtern : in KartenRecords.KartengrundRecord);
   
private
      
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;

end Diagnoseinformationen;
