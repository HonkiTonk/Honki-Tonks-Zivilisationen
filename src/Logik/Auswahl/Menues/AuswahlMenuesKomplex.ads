pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

package AuswahlMenuesKomplex is

   function AuswahlMenüsKomplex
     (WelchesMenüExtern : in MenueDatentypen.Menü_Komplex_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenuesKomplex;
