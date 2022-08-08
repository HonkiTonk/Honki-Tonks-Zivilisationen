pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TexteinstellungenSFML;
with RasseneinstellungenSFML;

package body GrafikEinstellungenSFML is

   procedure StandardGrafikEinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      
      TexteinstellungenSFML.StandardLaden;
      RasseneinstellungenSFML.StandardLaden;
      
   end StandardGrafikEinstellungenLaden;

end GrafikEinstellungenSFML;
