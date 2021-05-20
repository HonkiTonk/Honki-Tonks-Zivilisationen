pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemCursor with
Abstract_State => (BewegungssystemCursorState)
is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in Positive;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
     
   procedure GeheZuCursor
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord with Part_Of => BewegungssystemCursorState;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with Part_Of => BewegungssystemCursorState;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord with Part_Of => BewegungssystemCursorState;

   Wert : Integer with Part_Of => BewegungssystemCursorState;
   
   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

end BewegungssystemCursor;
