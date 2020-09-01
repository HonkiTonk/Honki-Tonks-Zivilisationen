with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, GebaeudeDatenbank, Karte, GlobaleVariablen, Eingabe, EinheitenDatenbank, BewegungssystemCursor, Fehlermeldungen, Karten;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling;

package InDerStadt is

   procedure InDerStadt (Rasse, StadtPositionInListe : in Integer);
   procedure StadtBauen (Rasse, Listenplatz : in Integer);

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;

   function StadtBauenPrüfen (Y, X : in Integer) return Boolean;

end InDerStadt;
