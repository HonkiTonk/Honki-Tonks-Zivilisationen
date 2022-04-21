pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfachSFML;
with AuswahlMenuesKomplexSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum =>
            AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Menü_Komplex_Enum =>
            AuswahlMenuesKomplexSFML.AuswahlMenüsKomplex (WelchesMenüExtern => WelchesMenüExtern);
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
