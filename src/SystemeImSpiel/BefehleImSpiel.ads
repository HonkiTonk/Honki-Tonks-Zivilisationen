with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, KartenDatenbank, Karte, EinheitenDatenbank, GlobaleVariablen, Karten, NaechstesObjekt, Verbesserungen,
     Anzeige, Diplomatie, SchleifenPruefungen, GlobaleDatentypen, Cheat;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer;

private

   Wahl : Boolean;
   Nullwert : Boolean;
         
   Taste : Wide_Wide_Character;

   WertEinheit : Integer;
   WertStadt : Integer;
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt (RasseExtern : GlobaleDatentypen.Rassen; Auswahl, StadtNummer, EinheitNummer : in Integer);
   
end BefehleImSpiel;
