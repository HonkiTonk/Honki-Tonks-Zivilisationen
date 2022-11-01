pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Diagnoseinformationen is

   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Put_Line (Item => "EAchse: " & KoordinatenExtern.EAchse'Wide_Wide_Image & "    YAchse: " & KoordinatenExtern.YAchse'Wide_Wide_Image & "    XAchse: " & KoordinatenExtern.XAchse'Wide_Wide_Image);
      
   end Koordinateninformationen;
   
   
   
   procedure Einheiteninformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Put_Line (Item => "Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image & "    Nummer: " & EinheitRasseNummerExtern.Nummer'Wide_Wide_Image);
      
   end Einheiteninformationen;

end Diagnoseinformationen;
