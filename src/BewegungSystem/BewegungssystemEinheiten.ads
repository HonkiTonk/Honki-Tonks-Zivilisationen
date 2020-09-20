with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, SchleifenPruefungen, GlobaleDatentypen, GlobaleVariablen, KartenDatenbank, Karten, Karte, EinheitenDatenbank, Kampfsystem, Diplomatie, Auswahl, Sichtbarkeit;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (Rasse, EinheitNummer : in Integer);
   
private

   Angreifen : Boolean;
   Gewonnen : Boolean;

   Richtung : Wide_Wide_Character;
   
   XÄnderung : Integer;
   YÄnderung : Integer;
   GegnerischeEinheitOderStadt : Integer; -- 0 = Spieler, 1 = Gegnerische Einheit, 2 = Gegnerische Stadt, 3 = Gegnerische Einheit in gegnerische Stadt 
   
   Wahl : Integer;
   BereitsImKrieg : Integer;

   Stadtnummer : Integer;

   KartenWert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;
   GegnerWert : GlobaleDatentypen.RasseUndPlatznummerRecord;
   
   procedure BewegungEinheitenBerechnung (Rasse, EinheitNummer, YÄnderung, XÄnderung : in Integer);

end BewegungssystemEinheiten;
