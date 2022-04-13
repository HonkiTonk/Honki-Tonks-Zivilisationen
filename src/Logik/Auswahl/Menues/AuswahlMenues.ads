pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package AuswahlMenues is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenues;
