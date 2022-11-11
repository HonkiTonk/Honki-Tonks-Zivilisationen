with RueckgabeDatentypen;

package OptionenSteuerungLogik is
   pragma Elaborate_Body;

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end OptionenSteuerungLogik;
