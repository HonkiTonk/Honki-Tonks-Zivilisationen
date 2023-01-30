private with System;

with Sf.System.Vector2;
with Sf.Graphics.Rect;

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
   
   procedure Positionsinformationen
     (PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure Boxinformationen
     (BoxExtern : in Sf.Graphics.Rect.sfFloatRect);
   
private
   
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;

end Diagnoseinformationen;
