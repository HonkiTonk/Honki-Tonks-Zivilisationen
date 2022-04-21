pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfach;
with AuswahlMenuesKomplex;

package body AuswahlMenues is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum =>
            return AuswahlMenuesEinfach.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Menü_Komplex_Enum =>
            return AuswahlMenuesKomplex.AuswahlMenüsKomplex (WelchesMenüExtern => WelchesMenüExtern);
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenues;
