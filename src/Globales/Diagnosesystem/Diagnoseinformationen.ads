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

package Diagnoseinformationen is
   pragma Elaborate_Body;
   
   
   procedure GrößenprüfungKartenfeld;
   procedure Größenprüfung;
   procedure GrößenprüfungDatei;
   procedure Zeilenabstand;
   
   procedure Zahl
     (ZahlExtern : in Integer);
   
   procedure Kommazahl
     (ZahlExtern : in Float);
   
   procedure Zeichen
     (ZeichenExtern : in Wide_Wide_Character);
   
   procedure KurzesZeichen
     (ZeichenExtern : in Character);
   
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
   
   procedure KurzerText
     (TextExtern : in String)
     with
       Pre => (
                 TextExtern'Length > 0
              );
   
   procedure Verzeichnisnamen;

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
     (BoxExtern : in Sf.Graphics.Rect.sfIntRect);
   
   procedure KommaBoxinformationen
     (BoxExtern : in Sf.Graphics.Rect.sfFloatRect);
   
   procedure Farbinformationen
     (FarbeExtern : in Sf.Graphics.Color.sfColor);
   
   procedure MaximaleDateinamenlänge;
   
private
   
   ByteTeiler : constant Positive := System.Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;
   
   Kartenfeld : constant Positive := WeltkarteRecords.WeltkarteRecord'Size;
   ZuPrüfendeGröße : constant Positive := StadtDatentypen.Städtebereich'Size;
   
   ZuSpeichern : StadtDatentypen.Städtebereich;
      
   DateiSpeichern : File_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end Diagnoseinformationen;
