with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with SchleifenPruefungen, GlobaleDatentypen, GlobaleVariablen, KartenDatenbank, Karten, Karte, EinheitenDatenbank, Kampfsystem, Diplomatie, Auswahl, Sichtbarkeit;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (Rasse, EinheitNummer : in Integer);
   
private

subtype Änderung is GlobaleDatentypen.Kartenfeld range -1 .. 1;

   Angreifen : Boolean;
   Gewonnen : Boolean;

   Richtung : Wide_Wide_Character;
      
   XÄnderung : Änderung;
   YÄnderung : Änderung;
   
   Wahl : Integer;
   BereitsImKrieg : Integer;

   Stadtnummer : Integer;

   KartenWert : GlobaleDatentypen.YWertXWertAusKartenfeld;
   GegnerEinheitWert : GlobaleDatentypen.RasseUndPlatznummerRecord;
   GegnerStadtWert : GlobaleDatentypen.RasseUndPlatznummerRecord;
   
   procedure BewegungEinheitenBerechnung (Rasse, EinheitNummer : in Integer; YÄnderung, XÄnderung : in Änderung);

end BewegungssystemEinheiten;
