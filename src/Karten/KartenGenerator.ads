with Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Numerics.Float_Random, Ada.Calendar;

with Karten, KartenDatenbank, GlobaleDatentypen, SchleifenPruefungen, Ladezeiten, WerteFestlegen, ZufallsGeneratoren;
use GlobaleDatentypen;

package KartenGenerator is -- Klein = 40x40, Mittel = 80x80, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd = 1000x1000

   Kartenart : Integer := 1; -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   Kartentemperatur : Integer := 1; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste

   procedure KartenGenerator;

private

   Gewählt : Generator;

   NochVerteilbareRessourcen : Integer;
   Flusswert : Integer;

   Eisrand : constant GlobaleDatentypen.KartenfeldPositiv := 1;
   FelderVonTemperaturZuTemperatur : constant GlobaleDatentypen.KartenfeldPositiv := 5;
   Abstand : constant GlobaleDatentypen.KartenfeldPositiv := 2;
   WahrscheinlichkeitFluss : constant Float := 0.90;

   Wert : Float;

   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;

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

   type EisWahrscheinlichkeitReduzierungspunktArray is array (1 .. 3) of GlobaleDatentypen.KartenfeldPositiv;
   EisWahrscheinlichkeitReduzierungspunkt : EisWahrscheinlichkeitReduzierungspunktArray;

   type WahrscheinlichkeitenFürLandartArray is array (1 .. 3, 1 .. 3) of Float;
   WahrscheinlichkeitenFürLandart : constant WahrscheinlichkeitenFürLandartArray := (1 => (0.60, 0.80, 0.80),
                                                                                       -- 1 = Eis bis zum Eisreduzierungspunkte, 2 = Eis, 3 = Wüste
                                                                                       2 => (0.60, 0.85, 0.70),
                                                                                       3 => (0.60, 0.90, 0.50));

   type WahrscheinlichkeitFürLandschaftArray is array (6 .. 10) of Float;
   WahrscheinlichkeitFürLandschaft : constant WahrscheinlichkeitFürLandschaftArray := (0.85, 0.75, 0.50, 0.30, 0.20);

   procedure GenerierungKartenart (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv);
   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in GlobaleDatentypen.KartenfeldPositiv);
   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; Gezogen : in Float);
   procedure GenerierungKüstenSeeGewässer;

   procedure GenerierungKartentemperatur;
   procedure GenerierungTemperaturAbstand (Geländeart : GlobaleDatentypen.KartenGrund; YPosition, XPosition: in GlobaleDatentypen.KartenfeldPositiv);
   procedure GenerierungTemperaturZusatz (Geländeart : GlobaleDatentypen.KartenGrund; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv);

   procedure GenerierungLandschaft;
   procedure GenerierungLandschaftZusatz;

   procedure GenerierungFlüsse;
   procedure FlussBerechnung (YKoordinate, XKoordinate : in GlobaleDatentypen.Kartenfeld);
   procedure GenerierungRessourcen;

   procedure AndereEbenen;

   procedure KartenfelderBewerten;

   procedure Chaos;

end KartenGenerator;
