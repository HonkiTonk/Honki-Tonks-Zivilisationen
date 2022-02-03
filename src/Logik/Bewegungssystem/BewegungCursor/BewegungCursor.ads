pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemRecords;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;

package BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in SystemDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
     
   procedure GeheZuCursor
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);

private

   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   Position : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   
   type RichtungArray is array (SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         SystemKonstanten.ObenKonstante        => (0, -1, 0),
                                         SystemKonstanten.LinksKonstante       => (0, 0, -1),
                                         SystemKonstanten.UntenKonstante       => (0, 1, 0),
                                         SystemKonstanten.RechtsKonstante      => (0, 0, 1),
                                         SystemKonstanten.LinksObenKonstante   => (0, -1, -1),
                                         SystemKonstanten.RechtsObenKonstante  => (0, -1, 1),
                                         SystemKonstanten.LinksUntenKonstante  => (0, 1, -1),
                                         SystemKonstanten.RechtsUntenKonstante => (0, 1, 1),
                                         SystemKonstanten.EbeneHochKonstante   => (1, 0, 0),
                                         SystemKonstanten.EbeneRunterKonstante => (-1, 0, 0)
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
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

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
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

end BewegungCursor;
