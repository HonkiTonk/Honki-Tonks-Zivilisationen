pragma Warnings (Off, "*array aggregate*");

with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body EinstellungenGrafik is

   procedure StandardeinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Grafikeinstellungen := GrafikeinstellungenStandard;
            
      TexteinstellungenGrafik.StandardLaden;
      RasseneinstellungenGrafik.StandardLaden;
      
   end StandardeinstellungenLaden;

end EinstellungenGrafik;
