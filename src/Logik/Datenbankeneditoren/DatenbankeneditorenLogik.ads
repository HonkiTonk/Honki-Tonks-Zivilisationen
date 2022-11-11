with RueckgabeDatentypen;

package DatenbankeneditorenLogik is
   pragma Elaborate_Body;

   function DatenbankenEditoren
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlleAufStandard;

end DatenbankeneditorenLogik;
