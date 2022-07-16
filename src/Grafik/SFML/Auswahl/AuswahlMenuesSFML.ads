pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Enum);

end AuswahlMenuesSFML;
