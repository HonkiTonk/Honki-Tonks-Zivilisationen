with Ada.Numerics.Float_Random, Ada.Wide_Wide_Text_IO, Ada.Calendar, Ada.Numerics.Discrete_Random, Karten, GlobaleVariablen, KartenDatenbank, GlobaleDatentypen, SchleifenPruefungen;
use Ada.Numerics.Float_Random, Ada.Wide_Wide_Text_IO, Ada.Calendar;

package KartenGenerator is -- Klein = 40x40, Mittel = 80x80, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd? = 1000x1000

   Kartenart : Integer := 1; -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   Kartentemperatur : Integer := 1; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste

   procedure KartenGenerator;

private

   Gewählt : Generator;

   NochVerteilbareRessourcen : Integer;
   Überhang : Integer;
   Eisrand : constant Integer := 1;
   FelderVonTemperaturZuTemperatur : constant Integer := 5;
   Abstand : constant Integer := 2;
   WahrscheinlichkeitFluss : constant Float := 0.90;
   Wert2 : Integer;
   Test : Integer;
   Flusswert : Integer;

   Wert : Float;

   KartenWert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;

   type ZeitArray is array (1 .. 6) of Integer;
   Zeit : ZeitArray;

   type GrößeLandartArray is array (1 .. 3) of Integer;
   GrößeLandart : GrößeLandartArray;

   type FelderVonLandartZuLandartArray is array (1 .. 3) of Integer;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 0); -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
                                                                                       -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.

   type WahrscheinlichkeitenFürLandArray is array (1 .. 3, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (1 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 2 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70),
                                                                                 3 => (0.92, 0.98, 0.75, 0.80, 0.98, 0.15, 0.70));

   type GeneratorKarteArray is array (Karten.Karten'Range (1), Karten.Karten'Range (2)) of Integer;
   GeneratorKarte : GeneratorKarteArray;

   type EisWahrscheinlichkeitReduzierungspunktArray is array (1 .. 3) of Integer;
   EisWahrscheinlichkeitReduzierungspunkt : EisWahrscheinlichkeitReduzierungspunktArray;

   type WahrscheinlichkeitenFürLandartArray is array (1 .. 3, 1 .. 3) of Float;
   WahrscheinlichkeitenFürLandart : constant WahrscheinlichkeitenFürLandartArray := (1 => (0.60, 0.80, 0.80),
                                                                                       -- 1 = Eis bis zum Eisreduzierungspunkte, 2 = Eis, 3 = Wüste
                                                                                       2 => (0.60, 0.85, 0.70),
                                                                                       3 => (0.60, 0.90, 0.50));

   type WahrscheinlichkeitFürLandschaftArray is array (6 .. 10) of Float;
   WahrscheinlichkeitFürLandschaft : constant WahrscheinlichkeitFürLandschaftArray := (0.85, 0.75, 0.50, 0.30, 0.20);

   procedure GenerierungKartenart (Y, X : in Integer);
   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in Integer);
   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in Integer; Gezogen : in Float);
   procedure GenerierungKüstenSeeGewässer;

   procedure GenerierungKartentemperatur;
   procedure GenerierungTemperaturAbstand (YPosition, XPosition, Geländeart : in Integer);
   procedure GenerierungTemperaturZusatz (YAchse, XAchse, Geländeart : in Integer);

   procedure GenerierungLandschaft;
   procedure GenerierungLandschaftZusatz;

   procedure GenerierungFlüsse;
   procedure FlussBerechnung (YKoordinate, XKoordinate : in Integer);
   procedure GenerierungRessourcen;

end KartenGenerator;
