pragma SPARK_Mode (On);

with SystemDatentypen;

package SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   RassenVorhanden : Boolean;

   Auswahl : SystemDatentypen.Rückgabe_Werte_Enum;

   function AutomatischeEinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum;

end SpielEinstellungen;
