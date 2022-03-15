pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package Optionen is

   function Optionen
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;

end Optionen;
