pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package AuswahlMenuesKomplexSFML is

   procedure AuswahlMenüsKomplex
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum);

end AuswahlMenuesKomplexSFML;
