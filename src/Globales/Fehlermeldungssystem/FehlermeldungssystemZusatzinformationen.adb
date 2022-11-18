package body FehlermeldungssystemZusatzinformationen is

   function Koordinaten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Wide_Wide_String
   is begin
      
      return ("Koordinaten: " & KoordinatenExtern.EAchse'Wide_Wide_Image & "," & KoordinatenExtern.YAchse'Wide_Wide_Image & "," & KoordinatenExtern.XAchse'Wide_Wide_Image);
      
   end Koordinaten;

end FehlermeldungssystemZusatzinformationen;
