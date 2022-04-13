pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package AuswahlMenuesKomplex is

   function AuswahlMenüsKomplex
     (WelchesMenüExtern : in SystemDatentypen.Menü_Komplex_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenuesKomplex;
