pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type WahrscheinlichkeitenFürLandArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 GlobaleDatentypen.Inseln =>
                                                                                   (
                                                                                    1 => 0.92,
                                                                                    2 => 0.98,
                                                                                    3 => 0.75,
                                                                                    4 => 0.80,
                                                                                    5 => 0.98,
                                                                                    6 => 0.15,
                                                                                    7 => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Kontinente =>
                                                                                   (
                                                                                    1 => 0.92,
                                                                                    2 => 0.98,
                                                                                    3 => 0.75,
                                                                                    4 => 0.80,
                                                                                    5 => 0.98,
                                                                                    6 => 0.15,
                                                                                    7 => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Pangäa =>
                                                                                   (
                                                                                    1 => 0.92,
                                                                                    2 => 0.98,
                                                                                    3 => 0.75,
                                                                                    4 => 0.80,
                                                                                    5 => 0.98,
                                                                                    6 => 0.15,
                                                                                    7 => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Nur_Land =>
                                                                                   (
                                                                                    1 => 0.50,
                                                                                    2 => 0.00,
                                                                                    3 => 0.50,
                                                                                    4 => 0.00,
                                                                                    5 => 0.50,
                                                                                    6 => 0.00,
                                                                                    7 => 0.50),
                                                                                 
                                                                                 GlobaleDatentypen.Chaos =>
                                                                                   (
                                                                                    1 => 0.00,
                                                                                    2 => 0.00, 
                                                                                    3 => 0.00,
                                                                                    4 => 0.00,
                                                                                    5 => 0.00,
                                                                                    6 => 0.00,
                                                                                    7 => 0.00)
                                                                                );

   -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
   -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.
   type FelderVonLandartZuLandartArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range) of GlobaleDatentypen.KartenfeldPositiv;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 1, 1, 1);
   
   procedure GenerierungKartenart
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse
     (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseÜberhang
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      GezogenExtern : in Float)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungPangäa
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorStandard;
