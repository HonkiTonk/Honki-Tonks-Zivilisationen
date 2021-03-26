pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGenerator is -- Klein = 40x40, Mittel = 80x80, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd = 1000x1000

   procedure KartenGenerator;

private

   NochVerteilbareRessourcen : Integer;
   Flusswert : Integer;
   HügelGebirgeUmgebung : Integer;

   Eisrand : constant GlobaleDatentypen.KartenfeldPositiv := 1;
   FelderVonTemperaturZuTemperatur : constant GlobaleDatentypen.KartenfeldPositiv := 5;
   Abstand : constant GlobaleDatentypen.KartenfeldPositiv := 2;
   WahrscheinlichkeitFluss : constant Float := 0.85;

   Wert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   KartenWertHügel : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   type FelderVonLandartZuLandartArray is array (1 .. 4) of GlobaleDatentypen.KartenfeldPositiv;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 1, 1); -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
                                                                                          -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.

   type WahrscheinlichkeitenFürLandArray is array (1 .. 4, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (1 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 2 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 3 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 4 => (0.50, 0.00, 0.50, 0.00, 0.50, 0.00, 0.50));



   type KartengrundWahrscheinlichkeitenArray is array (1 .. 5, 4 .. 10) of Float; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (1 => (0.25, 0.35, 0.45, 0.55, 0.70, 0.75, 0.85),
                                                                                       -- 4 = Tundra, 5 = Wüste, 6 = Hügel, 7 = Gebirge, 8 = Wald, 9 = Dschungel, 10 = Sumpf
                                                                                       2 => (0.15, 0.30, 0.40, 0.50, 0.70, 0.75, 0.85),
                                                                                       3 => (0.05, 0.35, 0.45, 0.50, 0.65, 0.70, 0.90),
                                                                                       4 => (0.40, 0.44, 0.45, 0.55, 0.70, 0.71, 0.80),
                                                                                       5 => (0.00, 0.50, 0.55, 0.60, 0.70, 0.75, 0.95));

   type WahrscheinlichkeitFürLandschaftArray is array (6 .. 10) of Float;
   WahrscheinlichkeitFürLandschaft : constant WahrscheinlichkeitFürLandschaftArray := (0.85, 0.75, 0.50, 0.30, 0.20);

   procedure GenerierungKüstenSeeGewässer;

   procedure GenerierungLandschaft;
   procedure GenerierungLandschaftFelder (GrundExtern : in GlobaleDatentypen.KartenGrund; YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (GrundExtern > 0 and YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandschaftHügel (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungFlüsse;
   procedure FlussBerechnung (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungRessourcen;

   procedure AndereEbenen;

   procedure KartenfelderBewerten;



end KartenGenerator;
