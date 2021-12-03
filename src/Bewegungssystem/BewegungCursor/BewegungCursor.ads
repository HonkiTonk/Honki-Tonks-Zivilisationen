pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemRecords;
with GlobaleVariablen;
with KartenRecords;

package BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in SystemDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
     
   procedure GeheZuCursor
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

private

   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   Position : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   
   type RichtungArray is array (SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         SystemDatentypen.Oben => (0, -1, 0),
                                         SystemDatentypen.Links => (0, 0, -1),
                                         SystemDatentypen.Unten => (0, 1, 0),
                                         SystemDatentypen.Rechts  => (0, 0, 1),
                                         SystemDatentypen.Links_Oben => (0, -1, -1),
                                         SystemDatentypen.Rechts_Oben => (0, -1, 1),
                                         SystemDatentypen.Links_Unten => (0, 1, -1),
                                         SystemDatentypen.Rechts_Unten => (0, 1, 1),
                                         SystemDatentypen.Ebene_Hoch => (1, 0, 0),
                                         SystemDatentypen.Ebene_Runter => (-1, 0, 0)
                                        );
   
   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

end BewegungCursor;
