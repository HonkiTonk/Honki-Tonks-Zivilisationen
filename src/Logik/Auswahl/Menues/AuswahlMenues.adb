pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfach;
with AuswahlMenuesKomplex;

package body AuswahlMenues is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Einfach_Enum =>
            return AuswahlMenuesEinfach.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Komplex_Enum =>
            return AuswahlMenuesKomplex.AuswahlMenüsKomplex (WelchesMenüExtern => WelchesMenüExtern);
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenues;
