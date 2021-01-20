with Ada.Numerics.Discrete_Random;

with GlobaleDatentypen, Karten, GlobaleRecords;
use GlobaleDatentypen;

package ZufallsGeneratoren is

   function YXPosition return GlobaleRecords.AchsenAusKartenfeldPositiv;
   function Chaoskarte return GlobaleDatentypen.KartenGrund;

private   

   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   subtype Kartenwert20 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 20;
   subtype Kartenwert40 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 40;
   subtype Kartenwert80 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 80;
   subtype Kartenwert120 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 120;
   subtype Kartenwert160 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 160;
   subtype Kartenwert240 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 240;
   subtype Kartenwert320 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 320;
   subtype Kartenwert1000 is GlobaleDatentypen.KartenfeldPositiv range 1 .. 1000;

   package WerteWählen20 is new Ada.Numerics.Discrete_Random (Kartenwert20);
   package WerteWählen40 is new Ada.Numerics.Discrete_Random (Kartenwert40);
   package WerteWählen80 is new Ada.Numerics.Discrete_Random (Kartenwert80);
   package WerteWählen120 is new Ada.Numerics.Discrete_Random (Kartenwert120);
   package WerteWählen160 is new Ada.Numerics.Discrete_Random (Kartenwert160);
   package WerteWählen240 is new Ada.Numerics.Discrete_Random (Kartenwert240);
   package WerteWählen320 is new Ada.Numerics.Discrete_Random (Kartenwert320);
   package WerteWählen1000 is new Ada.Numerics.Discrete_Random (Kartenwert1000);
   
   PositionGewählt20 : WerteWählen20.Generator;
   PositionGewählt40 : WerteWählen40.Generator;
   PositionGewählt80 : WerteWählen80.Generator;
   PositionGewählt120 : WerteWählen120.Generator;
   PositionGewählt160 : WerteWählen160.Generator;
   PositionGewählt240 : WerteWählen240.Generator;
   PositionGewählt320 : WerteWählen320.Generator;
   PositionGewählt1000 : WerteWählen1000.Generator;
   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für



   -- Generator für Chaoskarte
   Wert : GlobaleDatentypen.KartenGrund;

   subtype ChaoskarteWert is GlobaleDatentypen.KartenGrund range 1 .. GlobaleDatentypen.KartenGrund'Last;

   package WerteWählenChaoskarte is new Ada.Numerics.Discrete_Random (ChaoskarteWert);
   
   GrundGewählt : WerteWählenChaoskarte.Generator;
   -- Generator für Chaoskarte

end ZufallsGeneratoren;
