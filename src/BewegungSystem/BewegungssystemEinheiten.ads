with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with SchleifenPruefungen, GlobaleDatentypen, GlobaleVariablen, KartenDatenbank, Karten, Karte, EinheitenDatenbank, Kampfsystem, Diplomatie, Auswahl, Sichtbarkeit, GlobaleRecords;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (RasseExtern : GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   
private

   Wert : Boolean;
   RückgabeWert : Boolean;

   Angreifen : Boolean;
   Gewonnen : Boolean;

   Richtung : Wide_Wide_Character;
      
   XÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   YÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   Wahl : Integer;
   BereitsImKrieg : Integer;

   Stadtnummer : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeld;
   GegnerEinheitWert : GlobaleRecords.RasseUndPlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RasseUndPlatznummerRecord;
   
   procedure BewegungEinheitenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

   function ZwischenEbeneFürDieKI (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) return Boolean with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

   function FeldFürDieseEinheitPassierbar (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

   function BefindetSichDortEineEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) return Boolean with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

end BewegungssystemEinheiten;
