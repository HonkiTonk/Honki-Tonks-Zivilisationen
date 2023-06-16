with EinlesenGrafikeinstellungenLogik;
with EinlesenNutzereinstellungenLogik;
with EinlesenTastatureinstellungenLogik;
with EinlesenToneinstellungenLogik;
with EinlesenSonstigeEinstellungenLogik;

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
