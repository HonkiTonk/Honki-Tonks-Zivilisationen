with Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Numerics.Float_Random, Ada.Calendar;

with Karten, KartenDatenbank, GlobaleDatentypen, SchleifenPruefungen, Ladezeiten, WerteFestlegen, ZufallsGeneratoren, GlobaleRecords;
use GlobaleDatentypen;

package KartenGenerator is -- Klein = 40x40, Mittel = 80x80, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd = 1000x1000

   Kartenart : Integer := 1; -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   Kartentemperatur : Integer := 1; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste

   procedure KartenGenerator;

private

   Gewählt : Generator;

   NochVerteilbareRessourcen : Integer;
   Flusswert : Integer;
   HügelGebirgeUmgebung : Integer;

   Eisrand : constant GlobaleDatentypen.KartenfeldPositiv := 1;
   FelderVonTemperaturZuTemperatur : constant GlobaleDatentypen.KartenfeldPositiv := 5;
   Abstand : constant GlobaleDatentypen.KartenfeldPositiv := 2;
   WahrscheinlichkeitFluss : constant Float := 0.90;

   Wert : Float;

   KartenWert : GlobaleRecords.AchsenAusKartenfeld;
   KartenWertHügel : GlobaleRecords.AchsenAusKartenfeld;

   type GrößeLandartArray is array (1 .. 3) of GlobaleDatentypen.KartenfeldPositiv;
   GrößeLandart : GrößeLandartArray;

   type FelderVonLandartZuLandartArray is array (1 .. 3) of GlobaleDatentypen.Kartenfeld;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 0); -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
                                                                                       -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.

   type WahrscheinlichkeitenFürLandArray is array (1 .. 3, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (1 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 2 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 3 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70));

   type GeneratorKarteArray is array (Karten.Karten'Range (2), Karten.Karten'Range (3)) of GlobaleDatentypen.Kartenfeld;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Karten'Range (2), Karten.Karten'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

   type KartengrundWahrscheinlichkeitenArray is array (1 .. 5, 4 .. 10) of Float; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (1 => (0.25, 0.35, 0.45, 0.55, 0.70, 0.75, 0.85),
                                                                                       -- 4 = Tundra, 5 = Wüste, 6 = Hügel, 7 = Gebirge, 8 = Wald, 9 = Dschungel, 10 = Sumpf
                                                                                       2 => (0.85, 0.75, 0.50, 0.30, 0.20, 0.20, 0.20),
                                                                                       3 => (0.85, 0.75, 0.50, 0.30, 0.20, 0.20, 0.20),
                                                                                       4 => (0.85, 0.75, 0.50, 0.30, 0.20, 0.20, 0.20),
                                                                                       5 => (0.85, 0.75, 0.50, 0.30, 0.20, 0.20, 0.20));

   type WahrscheinlichkeitFürLandschaftArray is array (6 .. 10) of Float;
   WahrscheinlichkeitFürLandschaft : constant WahrscheinlichkeitFürLandschaftArray := (0.85, 0.75, 0.50, 0.30, 0.20);

   procedure GenerierungKartenart (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => YPositionLandmasse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XPositionLandmasse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; Gezogen : in Float) with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure Generierungpangäa (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungKüstenSeeGewässer;

   procedure GenerierungLandschaft;
   procedure GenerierungLandschaftFelder (Grund : in GlobaleDatentypen.KartenGrund; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => Grund > 0 and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungLandschaftHügel (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungFlüsse;
   procedure FlussBerechnung (YKoordinate, XKoordinate : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => YKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure GenerierungRessourcen;

   procedure AndereEbenen;

   procedure KartenfelderBewerten;

   procedure Chaos;

end KartenGenerator;
