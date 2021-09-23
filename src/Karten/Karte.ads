pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Karte is

   SichtweiteFestlegen : Positive;
   BewegungsfeldFestlegen : Positive;

   procedure SichtweiteBewegungsfeldFestlegen;

   procedure AnzeigeKarte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

private

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type SichtweitenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   Sichtweiten : constant SichtweitenArray := (1 => (0, 6, 8),
                                               2 => (0, 6, 16),
                                               3 => (0, 6, 24));

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1),
                                                 2 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1),
                                                 3 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1));

   procedure CursorPositionAltFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch
          and
            BewegungsfeldFestlegenExtern <= Bewegungsfeld'Last);

   procedure NeueZeileKartenform
     (XAchseExtern : in GlobaleDatentypen.Kartenfeld);

   procedure AlteEAchseFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

   procedure AlteXAchseFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

end Karte;
