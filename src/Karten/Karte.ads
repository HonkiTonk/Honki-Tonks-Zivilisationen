pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;

with Sichtweiten;

package Karte is

   BewegungsfeldFestlegen : Positive;

   procedure SichtweiteBewegungsfeldFestlegen;

   procedure AnzeigeKarte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant Sichtweiten.SichtweitenArray := (1 => (0, Sichtweiten.SichtweitenStandard (1).YAchse - 1, Sichtweiten.SichtweitenStandard (1).XAchse - 1),
                                                             2 => (0, Sichtweiten.SichtweitenStandard (1).YAchse - 1, Sichtweiten.SichtweitenStandard (1).XAchse - 1),
                                                             3 => (0, Sichtweiten.SichtweitenStandard (1).YAchse - 1, Sichtweiten.SichtweitenStandard (1).XAchse - 1));

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
