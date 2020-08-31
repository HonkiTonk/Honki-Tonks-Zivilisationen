with Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random, Karten, GlobaleVariablen, KartenDatenbank;
use Ada.Numerics.Float_Random;

package KartenGenerator is -- Klein = 40x40, Mittel = 80x80, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd? = 1000x1000

   Kartenart : Integer := 1; -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   Kartentemperatur : Integer := 1; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste

   procedure KartenGenerator;

private

   Gewählt : Generator;
   subtype Zahl is Integer range 14 .. 28;
   package Wahl is new Ada.Numerics.Discrete_Random (Zahl);
   Wählen : Wahl.Generator;

   NochVerteilbareRessourcen : Integer;
   Überhang : Integer;
   Eisrand : constant Integer := 1;
   FelderVonTemperaturZuTemperatur : constant Integer := 5;
   Abstand : constant Integer := 2;
   WahrscheinlichkeitFluss : constant Float := 0.85;
   Wert2 : Integer;

   Wert : Float;

   type GrößeLandartArray is array (1 .. 3) of Integer;
   GrößeLandart : GrößeLandartArray;

   type FelderVonLandartZuLandartArray is array (1 .. 3) of Integer;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 20, 0);

   type WahrscheinlichkeitenFürLandArray is array (1 .. 3, 1 .. 7) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (1 => (0.90, 0.95, 0.70, 0.80, 0.95, 0.20, 0.70),
                                                                                 -- 1 = Landwert nahe Eissschild, 2 = Landwert nahe Eissschild mit Landflächenentstehung, 3 = Landwert,
                                                                                 -- 4 = Landwert mit Landflächenentstehung, 5 = Landwert, 6 = Landwert bei Landflächenentstehung, 7 = Landwert ohne Landflächenentstehung
                                                                                 2 => (0.90, 0.95, 0.60, 0.80, 0.90, 0.33, 0.66),
                                                                                 3 => (0.90, 0.95, 0.60, 0.80, 0.90, 0.33, 0.66));

   type GeneratorKarteArray is array (Karten.Karten'Range (1), Karten.Karten'Range (2)) of Integer;
   GeneratorKarte : GeneratorKarteArray;

   type EisWahrscheinlichkeitReduzierungspunktArray is array (1 .. 3) of Integer;
   EisWahrscheinlichkeitReduzierungspunkt : EisWahrscheinlichkeitReduzierungspunktArray;

   type WahrscheinlichkeitenFürLandartArray is array (1 .. 3, 1 .. 3) of Float;
   WahrscheinlichkeitenFürLandart : constant WahrscheinlichkeitenFürLandartArray := (1 => (0.60, 0.90, 0.60),
                                                                              2 => (0.60, 0.90, 0.70),
                                                                              3 => (0.60, 0.90, 0.70));

   type WahrscheinlichkeitFürLandschaftArray is array (6 .. 9) of Float;
   WahrscheinlichkeitFürLandschaft : constant WahrscheinlichkeitFürLandschaftArray := (0.85, 0.75, 0.50, 0.30);

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
   procedure GenerierungRessourcen;

end KartenGenerator;
