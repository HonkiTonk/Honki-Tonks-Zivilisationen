with Sf.System.Vector2;

with MenueDatentypen;

package ZusatztextaufteilungGrafik is
   pragma Elaborate_Body;

   function Zusatztextaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Zusatztextaufteilung'Result.x >= 0.00
                and
                  Zusatztextaufteilung'Result.y >= 0.00
               );

   function ZusatztextDoppelmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  ZusatztextDoppelmenü'Result.x >= 0.00
                and
                  ZusatztextDoppelmenü'Result.y >= 0.00
               );

private

   AnzahlKartengrößen : constant Positive := 9;
   MaximaleKartenformen : constant Positive := 10;

   AktuelleAuswahl : Natural;

end ZusatztextaufteilungGrafik;
