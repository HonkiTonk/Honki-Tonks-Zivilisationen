pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body RasseneinstellungenGrafik is

   procedure StandardLaden
   is begin
      
      Rassenfarben := RassenfarbenStandard;
      RassenfarbenRahmen := RassenfarbenRahmenStandard;
      
   end StandardLaden;

end RasseneinstellungenGrafik;
