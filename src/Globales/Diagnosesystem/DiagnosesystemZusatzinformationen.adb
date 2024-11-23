with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

with DateizugriffssystemHTB5;

package body DiagnosesystemZusatzinformationen is

   procedure GrößenprüfungKartenfeld
   is begin
      
      Put_Line ("Einzeln:");
      Put_Line (Item => "Bits:" & Kartenfeld'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (Kartenfeld / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (Kartenfeld / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (Kartenfeld / MegabyteTeiler)'Wide_Wide_Image);
      
      New_Line;
      
      Put_Line ("Maximale Kartengröße:");
      Put_Line (Item => "Bits:" & Integer (5 * Kartenfeld * 1_000_000)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (5 * Kartenfeld * 1_000_000 / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (5 * Kartenfeld * 1_000_000 / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (5 * Kartenfeld * 1_000_000 / MegabyteTeiler)'Wide_Wide_Image);
      
   end GrößenprüfungKartenfeld;
   
   
   
   procedure GrößenprüfungDatei
   is begin
      
      ZuSpeichern := 0;
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiSpeichern,
                                  NameExtern     => ("Test/" & "Test"));
      
      StadtDatentypen.Städtebereich'Write (Stream (File => DateiSpeichern),
                                            ZuSpeichern);
      
      Close (File => DateiSpeichern);
      
   end GrößenprüfungDatei;
               
   

   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Put_Line (Item => "Ebene: " & KoordinatenExtern.Ebene'Wide_Wide_Image & "    Senkrechte: " & KoordinatenExtern.Senkrechte'Wide_Wide_Image & "    Waagerechte: " & KoordinatenExtern.Waagerechte'Wide_Wide_Image);
      
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
     (BoxExtern : in Sf.Graphics.Rect.sfIntRect)
   is begin
      
      Put ("Left: ");
      
      Ada.Integer_Text_IO.Put (Item => BoxExtern.left);
      
      Put ("    top: ");
      
      Ada.Integer_Text_IO.Put (Item => BoxExtern.top);
      
      Put ("    width: ");
      
      Ada.Integer_Text_IO.Put (Item => BoxExtern.width);
      
      Put ("    height: ");
      
      Ada.Integer_Text_IO.Put (Item => BoxExtern.height);
      
      New_Line;
      
   end Boxinformationen;
   
   
   
   procedure KommaBoxinformationen
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
      
   end KommaBoxinformationen;
   
   
   
   procedure Farbinformationen
     (FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Put ("Rot:" & FarbeExtern.r'Wide_Wide_Image & "   Grün:" & FarbeExtern.g'Wide_Wide_Image & "   Blau:" & FarbeExtern.b'Wide_Wide_Image & "   Alpha:" & FarbeExtern.a'Wide_Wide_Image);
      
      New_Line;
      
   end Farbinformationen;

end DiagnosesystemZusatzinformationen;
