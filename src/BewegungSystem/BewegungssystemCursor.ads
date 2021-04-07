pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in Wide_Wide_Character;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre => ((RichtungExtern = 'w' or RichtungExtern = 'a' or RichtungExtern = 's' or RichtungExtern = 'd' or RichtungExtern = '1' or RichtungExtern = '2' or RichtungExtern = '3' or RichtungExtern = '4'
               or RichtungExtern = '6' or RichtungExtern = '7' or RichtungExtern = '8' or RichtungExtern = '9' or RichtungExtern = '+' or RichtungExtern = '-') and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
     
   procedure GeheZuCursor
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;

   Wert : Integer;
   
   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre => ((ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre => ((ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

end BewegungssystemCursor;
