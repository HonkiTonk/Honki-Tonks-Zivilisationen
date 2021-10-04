pragma SPARK_Mode (On);

with GlobaleVariablen, KartenRecords, SonstigeDatentypen, KartenDatentypen;
use KartenDatentypen, SonstigeDatentypen;

package Karte is

   SichtweiteFestlegen : Positive;
   BewegungsfeldFestlegen : Positive;

   procedure SichtweiteBewegungsfeldFestlegen;

   procedure AnzeigeKarte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   type SichtweitenArray is array (1 .. 3) of KartenRecords.AchsenKartenfeldPositivRecord;
   Sichtweiten : constant SichtweitenArray := (1 => (0, 6, 8),
                                               2 => (0, 6, 16),
                                               3 => (0, 6, 24));

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1),
                                                 2 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1),
                                                 3 => (0, Sichtweiten (1).YAchse - 1, Sichtweiten (1).XAchse - 1));

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch
          and
            BewegungsfeldFestlegenExtern <= Bewegungsfeld'Last);

   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld);

   procedure AlteEAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

   procedure AlteXAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

end Karte;
