pragma SPARK_Mode (On);

package body GrafikEinstellungenSFML is

   procedure StandardGrafikEinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Schriftfarben := SchriftfarbenStandard;
      RassenFarben := RassenFarbenStandard;
      RassenFarbenRahmen := RassenFarbenRahmenStandard;
      
   end StandardGrafikEinstellungenLaden;

end GrafikEinstellungenSFML;
