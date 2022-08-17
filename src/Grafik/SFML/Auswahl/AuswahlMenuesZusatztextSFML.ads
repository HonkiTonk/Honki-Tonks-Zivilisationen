pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with MenueDatentypen;

package AuswahlMenuesZusatztextSFML is

   function MenüsZusatztextAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f;

private

   -- Das mal auslagern, damit es auch in den Untermenüs verwendet werden kann? äöü
   MaximaleRassen : constant Positive := 18;
   AnzahlKartengrößen : constant Positive := 9;
   MaximaleKartenformen : constant Positive := 10;

   AktuelleAuswahl : Natural;

end AuswahlMenuesZusatztextSFML;
