pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => Richtung = 'w' or Richtung = 'a' or Richtung = 's' or Richtung = 'd' or Richtung = '1' or Richtung = '2' or Richtung = '3' or Richtung = '4' or Richtung = '6' or Richtung = '7' or Richtung = '8' or Richtung = '9';
     
   procedure GeheZuCursor (RasseExtern : in GlobaleDatentypen.Rassen);

private

   YÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   XÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;

   YPosition : GlobaleDatentypen.KartenfeldPositiv;
   XPosition : GlobaleDatentypen.KartenfeldPositiv;

   Wert : Integer;
   Stellenanzahl : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;
   
   procedure BewegungCursorBerechnen (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

   procedure BewegungCursorBerechnenStadt (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);

end BewegungssystemCursor;
