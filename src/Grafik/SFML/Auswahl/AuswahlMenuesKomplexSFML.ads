pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package AuswahlMenuesKomplexSFML is

   procedure AuswahlMenüsKomplex
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum);

end AuswahlMenuesKomplexSFML;
