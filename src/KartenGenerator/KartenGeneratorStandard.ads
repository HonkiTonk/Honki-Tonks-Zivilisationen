pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   type WahrscheinlichkeitenFürLandArray is array (1 .. 4, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (1 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 2 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 3 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 4 => (0.50, 0.00, 0.50, 0.00, 0.50, 0.00, 0.50));

   type FelderVonLandartZuLandartArray is array (1 .. 4) of GlobaleDatentypen.KartenfeldPositiv;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 1, 1); -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
   -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.
   
   procedure GenerierungKartenart
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse
     (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre => (YPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseÜberhang
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      GezogenExtern : in Float)
     with
       Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungPangäa
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorStandard;
