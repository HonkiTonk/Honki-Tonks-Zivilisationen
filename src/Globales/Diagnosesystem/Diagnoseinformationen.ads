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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord);
   
   procedure Grundinformationen
     (GrundExtern : in KartenRecords.KartengrundRecord);
   
private
      
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;

end Diagnoseinformationen;
