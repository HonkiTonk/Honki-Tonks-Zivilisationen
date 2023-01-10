with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with WeltkarteRecords;

package body Diagnoseinformationen is

   procedure Größenprüfung
   is begin
      
      Put_Line (Item => "Bits:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000)'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (5 * WeltkarteRecords.WeltkarteRecord'Size * 1_000_000 / MegabyteTeiler)'Wide_Wide_Image);
      
   end Größenprüfung;
   
   
   
   procedure Zahl
     (ZahlExtern : in Integer)
   is begin
      
      Put_Line (ZahlExtern'Wide_Wide_Image);
      
   end Zahl;
   
   

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

end Diagnoseinformationen;
