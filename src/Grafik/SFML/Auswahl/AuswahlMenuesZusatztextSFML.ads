pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package AuswahlMenuesZusatztextSFML is

   procedure MenüsZusatztextAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural);

   procedure MenüsZusatztextZurücksetzen;

private

   -- Das mal auslagern, damit es auch in den Untermenüs verwendet werden kann? äöü
   MaximaleRassen : constant Positive := 18;
   AnzahlKartengrößen : constant Positive := 9;
   MaximaleKartenformen : constant Positive := 10;

end AuswahlMenuesZusatztextSFML;
