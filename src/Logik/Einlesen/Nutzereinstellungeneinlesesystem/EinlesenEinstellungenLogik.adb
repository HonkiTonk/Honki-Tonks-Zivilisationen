with EinlesenGrafikeinstellungenLogik;
with EinlesenNutzereinstellungenLogik;
with EinlesenTastatureinstellungenLogik;
with EinlesenToneinstellungenLogik;
with EinlesenSonstigeEinstellungenLogik;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
-- Änderungen an den zu ladenden Datentypen kann jederzeit Probleme bei laden verursachen.
package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      EinlesenNutzereinstellungenLogik.Nutzereinstellungen;
      EinlesenGrafikeinstellungenLogik.Grafikeinstellungen;
      EinlesenToneinstellungenLogik.Toneinstelllungen;
      EinlesenTastatureinstellungenLogik.Tastatureinstellungen;
      EinlesenSonstigeEinstellungenLogik.SonstigeEinstellungen;
      
   end EinlesenEinstellungen;

end EinlesenEinstellungenLogik;
