pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfachSFML;
with AuswahlMenuesZusatztextSFML;
with AuswahlMenuesKomplexSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Einfach_Enum =>
            AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Zusatztext_Enum =>
            AuswahlMenuesZusatztextSFML.AuswahlMenüsZusatztext (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Komplex_Enum =>
            AuswahlMenuesKomplexSFML.AuswahlMenüsKomplex (WelchesMenüExtern => WelchesMenüExtern);
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
