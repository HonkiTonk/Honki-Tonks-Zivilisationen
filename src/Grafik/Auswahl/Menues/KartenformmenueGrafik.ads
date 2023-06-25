with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with MenueDatentypen;

package KartenformmenueGrafik is
   pragma Elaborate_Body;

   function Kartenformmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenformmenü'Result.x >= 0.00
                and
                  Kartenformmenü'Result.y >= 0.00
               );

private

   -- Ist um eins verschoben, da die Textdateien ja noch eine Überschrift enthalten.
   -- Später mit ZusatztextaufteilungGrafik zusammenführen? äöü
   EbeneOben : constant Positive := 2;
   EbeneUnten : constant Positive := 3;
   Norden : constant Positive := 4;
   Süden : constant Positive := 5;
   Westen : constant Positive := 6;
   Osten : constant Positive := 7;
   KeinÜbergang : constant Positive := 11;
   Übergang : constant Positive := 12;
   RückwärtsVerschobenerÜbergang : constant Positive := 13;
   VerschobenerÜbergang : constant Positive := 14;
   WelcherZusatztext : Positive;

   Textbreite : Float;

   Zusatztext : Unbounded_Wide_Wide_String;

   Textposition : Sf.System.Vector2.sfVector2f;



   function TextEinlesen
     (SchleifenwertExtern : in Positive)
      return Wide_Wide_String;

end KartenformmenueGrafik;
