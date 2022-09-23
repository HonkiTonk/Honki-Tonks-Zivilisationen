pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package DatenbankeneditorenLogik is

   function DatenbankenEditoren
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlleAufStandard;

end DatenbankeneditorenLogik;
