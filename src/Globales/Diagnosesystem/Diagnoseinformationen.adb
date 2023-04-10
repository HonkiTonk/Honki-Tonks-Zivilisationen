with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Float_Text_IO;

with WeltkarteRecords;

package body Diagnoseinformationen is

   procedure Größenprüfung
   is begin
      
      Put_Line (Item => "Bits:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / MegabyteTeiler)'Wide_Wide_Image);
      
   end Größenprüfung;
   
   
   
   procedure Zeilenabstand
   is begin
      
      New_Line;
      
   end Zeilenabstand;
   
   
   
   procedure Zahl
     (ZahlExtern : in Integer)
   is begin
      
      Put_Line (ZahlExtern'Wide_Wide_Image);
      
   end Zahl;
   
   
   procedure Kommazahl
     (ZahlExtern : in Float)
   is begin
      
      Ada.Float_Text_IO.Put (Item => ZahlExtern,
                             Exp  => 0);
      
      New_Line;
      
   end Kommazahl;
   
   
   
   procedure Text
     (TextExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => TextExtern);
      
   end Text;
   
   
   
   procedure UngebundenerText
     (TextExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => TextExtern));
      
   end UngebundenerText;
   
   

   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Put_Line (Item => "EAchse: " & KoordinatenExtern.EAchse'Wide_Wide_Image & "    YAchse: " & KoordinatenExtern.YAchse'Wide_Wide_Image & "    XAchse: " & KoordinatenExtern.XAchse'Wide_Wide_Image);
      
   end Koordinateninformationen;
   
   
   
   procedure Einheiteninformationen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Put_Line (Item => "Spezies: " & EinheitSpeziesNummerExtern.Spezies'Wide_Wide_Image & "    Nummer: " & EinheitSpeziesNummerExtern.Nummer'Wide_Wide_Image);
      
   end Einheiteninformationen;
   
   
   
   procedure Stadtinformationen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      Put_Line (Item => "Spezies: " & StadtSpeziesNummerExtern.Spezies'Wide_Wide_Image & "    Nummer: " & StadtSpeziesNummerExtern.Nummer'Wide_Wide_Image);
      
   end Stadtinformationen;
   
   
   
   procedure Grundinformationen
     (GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      Put_Line (Item => "Basisgrund: " & GrundExtern.Basisgrund'Wide_Wide_Image & "    Zusatzgrund: " & GrundExtern.Zusatzgrund'Wide_Wide_Image);
      
   end Grundinformationen;
   
   
   
   procedure Positionsinformationen
     (PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Put ("XPosition: ");
      
      Ada.Float_Text_IO.Put (Item => PositionExtern.x,
                             Exp  => 0);
      
      Put ("    YPosition: ");
      
      Ada.Float_Text_IO.Put (Item => PositionExtern.y,
                             Exp  => 0);
      
      New_Line;
      
   end Positionsinformationen;
   
   
   
   procedure Boxinformationen
     (BoxExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      Put ("Left: ");
      
      Ada.Float_Text_IO.Put (Item => BoxExtern.left,
                             Exp  => 0);
      
      Put ("    top: ");
      
      Ada.Float_Text_IO.Put (Item => BoxExtern.top,
                             Exp  => 0);
      
      Put ("    width: ");
      
      Ada.Float_Text_IO.Put (Item => BoxExtern.width,
                             Exp  => 0);
      
      Put ("    height: ");
      
      Ada.Float_Text_IO.Put (Item => BoxExtern.height,
                             Exp  => 0);
      
      New_Line;
      
   end Boxinformationen;

end Diagnoseinformationen;
