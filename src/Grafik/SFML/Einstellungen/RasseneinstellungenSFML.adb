pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body RasseneinstellungenSFML is

   procedure StandardLaden
   is begin
      
      RassenFarben := RassenFarbenStandard;
      RassenFarbenRahmen := RassenFarbenRahmenStandard;
      
   end StandardLaden;

end RasseneinstellungenSFML;
