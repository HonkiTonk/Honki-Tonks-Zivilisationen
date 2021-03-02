pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => ((Richtung = 'w' or Richtung = 'a' or Richtung = 's' or Richtung = 'd' or Richtung = '1' or Richtung = '2' or Richtung = '3' or Richtung = '4' or Richtung = '6' or Richtung = '7' or Richtung = '8' or Richtung = '9'
             or Richtung = '+' or Richtung = '-') and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
     
   procedure GeheZuCursor (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;

   Wert : Integer;
   
   procedure BewegungCursorBerechnen (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => ((ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure BewegungCursorBerechnenStadt (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => ((ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

end BewegungssystemCursor;
