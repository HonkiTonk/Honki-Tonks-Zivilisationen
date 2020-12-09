with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, GlobaleDatentypen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, GlobaleVariablen, Einlesen,
     Eingabe, EinheitenDatenbank, BewegungssystemCursor, Anzeige, Karten;
use GlobaleDatentypen;

package InDerStadt is

   procedure InDerStadt (Rasse, StadtNummer : in Integer);
   procedure StadtBauen (Rasse, EinheitNummer : in Integer);
   procedure StadtProduktionPrüfen (Rasse, StadtNummer : in Integer);

   function StadtBauenPrüfen (Y, X : in GlobaleDatentypen.Kartenfeld) return Boolean;

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;
   Wahl : Integer;
   NutzbarerBereich : Integer;
   RelativeCursorPositionY : Integer;
   RelativeCursorPositionX : Integer;

   KartenWert : GlobaleDatentypen.YWertXWertAusKartenfeld;

   procedure StadtProduktionPrüfenBerechnung (Rasse, StadtNummer : in Integer);

end InDerStadt;
