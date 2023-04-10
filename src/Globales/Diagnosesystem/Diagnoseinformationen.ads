with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with System;

with Sf.System.Vector2;
with Sf.Graphics.Rect;

with KartenRecords;
with EinheitenRecords;
with StadtRecords;

package Diagnoseinformationen is
   pragma Elaborate_Body;
   
   procedure Größenprüfung;
   procedure Zeilenabstand;
   
   procedure Zahl
     (ZahlExtern : in Integer);
   
   procedure Kommazahl
     (ZahlExtern : in Float);
   
   procedure Text
     (TextExtern : in Wide_Wide_String)
     with
       Pre => (
                 TextExtern'Length > 0
              );
   
   procedure UngebundenerText
     (TextExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              );

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
