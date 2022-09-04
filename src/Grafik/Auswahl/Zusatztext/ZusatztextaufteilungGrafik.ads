pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with MenueDatentypen;

package ZusatztextaufteilungGrafik is

   function Zusatztextaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float;
      AnzeigebereichbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 AnzeigebereichbreiteExtern > 0.00
              ),

       Post => (
                  Zusatztextaufteilung'Result.x > 0.00
                and
                  Zusatztextaufteilung'Result.y > 0.00
               );

private

   AnzahlKartengrößen : constant Positive := 9;
   MaximaleKartenformen : constant Positive := 10;

   AktuelleAuswahl : Natural;

end ZusatztextaufteilungGrafik;