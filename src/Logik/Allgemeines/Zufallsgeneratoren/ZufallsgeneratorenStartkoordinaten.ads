pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenRecords;

with Karten;

package ZufallsgeneratorenStartkoordinaten is
     
   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum),
           
         Post =>
           (Startkoordinaten'Result.EAchse in -1 .. 0
            and
              Startkoordinaten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
            and
              Startkoordinaten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

private
   
   EAchse : KartenDatentypen.EbeneVorhanden;
   
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   YXAchsen : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   ZufallsPunktKarte : KartenRecords.AchsenKartenfeldNaturalRecord;

   subtype Kartenwert20 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 20;
   subtype Kartenwert40 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 40;
   subtype Kartenwert80 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 80;
   subtype Kartenwert120 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 120;
   subtype Kartenwert160 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 160;
   subtype Kartenwert240 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 240;
   subtype Kartenwert320 is KartenDatentypen.KartenfeldPositiv range KartenDatentypen.KartenfeldPositiv'First .. 320;

   package WerteWählen20 is new Ada.Numerics.Discrete_Random (Kartenwert20);
   package WerteWählen40 is new Ada.Numerics.Discrete_Random (Kartenwert40);
   package WerteWählen80 is new Ada.Numerics.Discrete_Random (Kartenwert80);
   package WerteWählen120 is new Ada.Numerics.Discrete_Random (Kartenwert120);
   package WerteWählen160 is new Ada.Numerics.Discrete_Random (Kartenwert160);
   package WerteWählen240 is new Ada.Numerics.Discrete_Random (Kartenwert240);
   package WerteWählen320 is new Ada.Numerics.Discrete_Random (Kartenwert320);
   package WerteWählen1000 is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);
   
   PositionGewählt20 : WerteWählen20.Generator;
   PositionGewählt40 : WerteWählen40.Generator;
   PositionGewählt80 : WerteWählen80.Generator;
   PositionGewählt120 : WerteWählen120.Generator;
   PositionGewählt160 : WerteWählen160.Generator;
   PositionGewählt240 : WerteWählen240.Generator;
   PositionGewählt320 : WerteWählen320.Generator;
   PositionGewählt1000 : WerteWählen1000.Generator;
   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
      
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
     with
       Post =>
         (StartPunkteYXFestlegen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            StartPunkteYXFestlegen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end ZufallsgeneratorenStartkoordinaten;
