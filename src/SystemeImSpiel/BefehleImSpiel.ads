with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9, ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, KartenDatenbank,
     Karte, EinheitenDatenbank, GlobaleVariablen, Karten, NaechstesObjekt, VerbesserungenDatenbank, Ausgabe, Diplomatie, SchleifenPruefungen;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

package BefehleImSpiel is

   function Befehle return Integer;

private

   Wahl : Boolean;
         
   Taste : Wide_Wide_Character;

   WertEinheit : Integer;
   WertStadt : Integer;
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;

   procedure EinheitOderStadt (Auswahl, StadtNummer, EinheitNummer : in Integer);
   
end BefehleImSpiel;
