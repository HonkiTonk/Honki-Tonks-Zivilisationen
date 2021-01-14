with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, GlobaleDatentypen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, GlobaleVariablen, Einlesen,
     Eingabe, EinheitenDatenbank, BewegungssystemCursor, Anzeige, Karten;
use GlobaleDatentypen;

package InDerStadt is

   procedure InDerStadt (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure StadtProduktionPrüfen (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BelegteStadtfelderFreigeben (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

   function StadtBauen (RasseExtern, EinheitNummer : in Integer) return Boolean
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   function StadtBauenPrüfen (RasseExtern, EinheitNummer : in Integer) return Boolean
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;
   Wahl : Integer;

   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionY : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionX : GlobaleDatentypen.Kartenfeld;

   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;

   procedure StadtProduktionPrüfenBerechnung (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end InDerStadt;
