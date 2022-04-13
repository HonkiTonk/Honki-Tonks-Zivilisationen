pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package AuswahlMenuesZusatztext is

   function AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenuesZusatztext;
