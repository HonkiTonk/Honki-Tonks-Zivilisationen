with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with System;

with Sf.System.Vector2;
with Sf.Graphics.Rect;
with Sf.Graphics.Color;

with KartenRecords;
with EinheitenRecords;
with StadtRecords;

private with WeltkarteRecords;
private with StadtDatentypen;

package DiagnosesystemZusatzinformationen is
   pragma Elaborate_Body;
      
   procedure GrößenprüfungKartenfeld;
   procedure GrößenprüfungDatei;
   
   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord);
   
   procedure Einheiteninformationen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord);
   
   procedure Stadtinformationen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord);
   
   procedure Grundinformationen
     (GrundExtern : in KartenRecords.KartengrundRecord);
   
   procedure Positionsinformationen
     (PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure Boxinformationen
     (BoxExtern : in Sf.Graphics.Rect.sfIntRect);
   
   procedure KommaBoxinformationen
     (BoxExtern : in Sf.Graphics.Rect.sfFloatRect);
   
   procedure Farbinformationen
     (FarbeExtern : in Sf.Graphics.Color.sfColor);
   
private
   
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;
   
   Kartenfeld : constant Positive := WeltkarteRecords.WeltkarteRecord'Size;
   ZuPrüfendeGröße : constant Positive := StadtDatentypen.Städtebereich'Size;
         
   DateiSpeichern : File_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end DiagnosesystemZusatzinformationen;
