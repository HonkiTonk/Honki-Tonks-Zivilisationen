pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with MenueDatentypen;

package AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum);

private

   Viewfläche : Sf.System.Vector2.sfVector2f := (5.00, 5.00);

end AuswahlMenuesSFML;
