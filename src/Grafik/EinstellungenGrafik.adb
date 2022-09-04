pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body EinstellungenGrafik is

   procedure StandardeinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      
      TexteinstellungenGrafik.StandardLaden;
      RasseneinstellungenGrafik.StandardLaden;
      
   end StandardeinstellungenLaden;

end EinstellungenGrafik;