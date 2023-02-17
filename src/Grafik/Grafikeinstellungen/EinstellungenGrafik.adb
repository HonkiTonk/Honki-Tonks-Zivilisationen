with TexteinstellungenGrafik;
with SpezieseinstellungenGrafik;

package body EinstellungenGrafik is

   -- Das hier ist nach der neuesten Aufteilung eventuell auch nicht mehr so sinnvoll und sollte neu aufgeteilt werden? äöü
   procedure StandardeinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Grafikeinstellungen := GrafikeinstellungenStandard;
            
      TexteinstellungenGrafik.StandardLaden;
      SpezieseinstellungenGrafik.StandardLaden;
      
   end StandardeinstellungenLaden;

end EinstellungenGrafik;
