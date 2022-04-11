pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package SpielEinstellungen is

   function Spieleinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   RassenVorhanden : Boolean;

   Auswahl : SystemDatentypen.Rückgabe_Werte_Enum;

   function AutomatischeEinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum;

end SpielEinstellungen;
