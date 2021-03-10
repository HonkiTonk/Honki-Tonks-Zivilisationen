pragma SPARK_Mode (Off);

with Ada.Numerics.Discrete_Random;

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package ZufallsGeneratoren is

   function Spieleinstellungen (WelcheEinstellung : in Positive) return Positive with
     Pre  => (WelcheEinstellung <= 6),
     Post => (Spieleinstellungen'Result <= Positive (GlobaleDatentypen.Rassen'Last));
     
   function YXPosition return GlobaleRecords.AchsenKartenfeldPositivRecord with
     Post => (YXPosition'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and YXPosition'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   function Chaoskarte return GlobaleDatentypen.KartenGrund with
     Post => (Chaoskarte'Result >= 1);

private

   -- Generatoren für zufällige Spieleinstellungen
   SpieleinstellungenAuswahl : Positive;

   subtype ZufälligeKartengröße is Positive range 1 .. 9;
   subtype ZufälligeKartenart is Positive range 1 .. 5;
   subtype ZufälligeKartentemperatur is Positive range 1 .. 5;
   subtype ZufälligeSpieleranzahlRasse is Positive range Positive (GlobaleDatentypen.Rassen'First) .. Positive (GlobaleDatentypen.Rassen'Last);
   subtype ZufälligerSchwierigkeitsgrad is Positive range 1 .. 3;

   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartengröße);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartenart);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartentemperatur);
   package ZufälligeSpieleranzahlRasseWählen is new Ada.Numerics.Discrete_Random (ZufälligeSpieleranzahlRasse);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (ZufälligerSchwierigkeitsgrad);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeSpieleranzahlRasseGewählt : ZufälligeSpieleranzahlRasseWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   -- Generatoren für zufällige Spieleinstellungen



   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   ZufallsPunktKarte : GlobaleRecords.AchsenKartenfeldPositivRecord;

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
   KartenGrundGewählt : GlobaleDatentypen.KartenGrund;

   subtype ChaoskarteWert is GlobaleDatentypen.KartenGrund range 1 .. GlobaleDatentypen.KartenGrund'Last;

   package WerteWählenChaoskarte is new Ada.Numerics.Discrete_Random (ChaoskarteWert);
   
   GrundGewählt : WerteWählenChaoskarte.Generator;
   -- Generator für Chaoskarte

end ZufallsGeneratoren;
