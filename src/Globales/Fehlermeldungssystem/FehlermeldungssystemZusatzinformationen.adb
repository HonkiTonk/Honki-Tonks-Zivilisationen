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

end FehlermeldungssystemZusatzinformationen;
