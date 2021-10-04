pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, KartenRecords, SonstigeDatentypen, KartenDatentypen;
use GlobaleDatentypen, SonstigeDatentypen;

package BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in GlobaleDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
     
   procedure GeheZuCursor
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   Position : KartenRecords.AchsenKartenfeldPositivRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   Änderung : KartenRecords.AchsenKartenfeldRecord;

   KoordinatenPunkt : Integer;
   
   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

end BewegungCursor;
