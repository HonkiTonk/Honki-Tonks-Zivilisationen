with RueckgabeDatentypen;

package OptionenLogik is
   pragma Elaborate_Body;

   function Optionen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end OptionenLogik;
