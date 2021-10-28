pragma SPARK_Mode (On);

with SystemDatentypen;

package AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü)
      return SystemDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenue;
