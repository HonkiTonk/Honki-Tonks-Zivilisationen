with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, GlobaleVariablen, KartenDatenbank, Karten, Karte, EinheitenDatenbank, Kampfsystem, Diplomatie, Auswahl;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (Rasse, EinheitenPositionInListe : in Integer);
   
private

   Angreifen : Boolean;
   Gewonnen : Boolean;

   Richtung : Wide_Wide_Character;
   
   XÄnderung : Integer;
   YÄnderung : Integer;
   NeueXPosition : Integer;
   Gegner : Integer;
   GegnerPosition : Integer;
   Wahl : Integer;
   BereitsImKrieg : Integer;
   
   procedure BewegungEinheitenBerechnung (Rasse, EinheitenPositionInListe : in Integer);

end BewegungssystemEinheiten;