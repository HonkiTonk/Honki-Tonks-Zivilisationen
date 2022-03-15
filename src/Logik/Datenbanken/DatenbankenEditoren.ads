pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package DatenbankenEditoren is

   function DatenbankenEditoren
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;

end DatenbankenEditoren;
