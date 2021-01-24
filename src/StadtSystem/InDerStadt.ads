with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, GlobaleDatentypen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, GlobaleVariablen, Einlesen,
     Eingabe, EinheitenDatenbank, BewegungssystemCursor, Anzeige, Karten, GlobaleRecords;
use GlobaleDatentypen;

package InDerStadt is

   procedure InDerStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure StadtProduktionPrüfen (RasseExtern : in GlobaleDatentypen.RassenMitNullwert; StadtNummer : in Natural);
   procedure BelegteStadtfelderFreigeben (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

   function StadtBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;
   function StadtBauenPrüfen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;
   Wahl : Integer;

   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionY : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionX : GlobaleDatentypen.Kartenfeld;

   KartenWert : GlobaleRecords.AchsenAusKartenfeld;

   procedure StadtProduktionPrüfenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

end InDerStadt;
