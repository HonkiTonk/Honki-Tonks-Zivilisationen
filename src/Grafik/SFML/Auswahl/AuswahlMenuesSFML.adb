pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfachSFML;
with AuswahlMenueKartenformSFML;
with AuswahlMenueSteuerungSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Leer_Menü_Enum =>
            return;
            
         when MenueDatentypen.Menü_Einfach_Enum =>
            AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AuswahlMenueKartenformSFML.AuswahlMenüKartenform;
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AuswahlMenueSteuerungSFML.AuswahlMenüSteuerung;
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
