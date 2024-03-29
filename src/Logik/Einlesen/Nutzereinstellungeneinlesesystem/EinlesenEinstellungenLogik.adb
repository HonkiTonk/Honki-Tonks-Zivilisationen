with EinlesenGrafikeinstellungenLogik;
with EinlesenNutzereinstellungenLogik;
with EinlesenTastatureinstellungenLogik;
with EinlesenToneinstellungenLogik;
with EinlesenSpielendeEinstellungenLogik;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
-- Änderungen an den zu ladenden Datentypen kann jederzeit Probleme beim Laden verursachen.
package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      EinlesenNutzereinstellungenLogik.Nutzereinstellungen;
      EinlesenGrafikeinstellungenLogik.Grafikeinstellungen;
      EinlesenToneinstellungenLogik.Toneinstelllungen;
      EinlesenTastatureinstellungenLogik.Tastatureinstellungen;
      EinlesenSpielendeEinstellungenLogik.SpielendeEinstellungen;
      
   end EinlesenEinstellungen;

end EinlesenEinstellungenLogik;
