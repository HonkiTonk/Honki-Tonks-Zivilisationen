pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemRecords;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;
with TastenbelegungDatentypen;
with TastenbelegungKonstanten;

package BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum;
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
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         TastenbelegungKonstanten.ObenKonstante        => (0, -1, 0),
                                         TastenbelegungKonstanten.LinksKonstante       => (0, 0, -1),
                                         TastenbelegungKonstanten.UntenKonstante       => (0, 1, 0),
                                         TastenbelegungKonstanten.RechtsKonstante      => (0, 0, 1),
                                         TastenbelegungKonstanten.LinksObenKonstante   => (0, -1, -1),
                                         TastenbelegungKonstanten.RechtsObenKonstante  => (0, -1, 1),
                                         TastenbelegungKonstanten.LinksUntenKonstante  => (0, 1, -1),
                                         TastenbelegungKonstanten.RechtsUntenKonstante => (0, 1, 1),
                                         TastenbelegungKonstanten.EbeneHochKonstante   => (1, 0, 0),
                                         TastenbelegungKonstanten.EbeneRunterKonstante => (-1, 0, 0)
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
