package body FehlermeldungssystemZusatzinformationen is

   function Koordinaten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Wide_Wide_String
   is begin
      
      return ("Koordinaten: " & KoordinatenExtern.EAchse'Wide_Wide_Image & "," & KoordinatenExtern.YAchse'Wide_Wide_Image & "," & KoordinatenExtern.XAchse'Wide_Wide_Image);
      
   end Koordinaten;
   
   
   
   function SpeziesID
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String
   is begin
      
      return ("Spezies: " & SpeziesExtern'Wide_Wide_Image & ", ID: " & IDExtern'Wide_Wide_Image);
      
   end SpeziesID;
   
   
   
   function Floatvektor
     (VektorExtern : in Sf.System.Vector2.sfVector2f)
      return Wide_Wide_String
   is begin
      
      return ("X: " & VektorExtern.x'Wide_Wide_Image & ", Y: " & VektorExtern.y'Wide_Wide_Image);
      
   end Floatvektor;

end FehlermeldungssystemZusatzinformationen;
