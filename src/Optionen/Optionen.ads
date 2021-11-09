pragma SPARK_Mode (On);

with SystemDatentypen;

package Optionen is

   function Optionen
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   Taste : Wide_Wide_Character;

   Auswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   Rückgabe : SystemDatentypen.Rückgabe_Werte_Enum;

end Optionen;
