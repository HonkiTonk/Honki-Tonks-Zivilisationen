pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum);

end AuswahlMenuesZusatztextSFML;
