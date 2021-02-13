pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => Richtung = 'w' or Richtung = 'a' or Richtung = 's' or Richtung = 'd' or Richtung = '1' or Richtung = '2' or Richtung = '3' or Richtung = '4' or Richtung = '6' or Richtung = '7' or Richtung = '8' or Richtung = '9'
     or Richtung = '+' or Richtung = '-';
     
   procedure GeheZuCursor (RasseExtern : in GlobaleDatentypen.Rassen);

private

   Wert : Integer;

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldRecord;
   
   procedure BewegungCursorBerechnen (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0;

   procedure BewegungCursorBerechnenStadt (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0;

end BewegungssystemCursor;
