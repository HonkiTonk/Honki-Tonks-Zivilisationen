pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body GrafikEinstellungenSFML is

   procedure StandardGrafikEinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Schriftfarben := SchriftfarbenStandard;
      RassenFarben := RassenFarbenStandard;
      RassenFarbenRahmen := RassenFarbenRahmenStandard;
      
   end StandardGrafikEinstellungenLaden;

end GrafikEinstellungenSFML;