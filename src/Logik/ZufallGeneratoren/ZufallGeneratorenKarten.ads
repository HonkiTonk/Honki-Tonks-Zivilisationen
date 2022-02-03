pragma SPARK_Mode (Off);

with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;

with Karten;

package ZufallGeneratorenKarten is
     
   function StartPosition
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante),
         Post =>
           (StartPosition'Result.EAchse in -1 .. 0
            and
              StartPosition'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              StartPosition'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function ZufälligerWert
     return Float;
     
   function ChaoskarteGrund
     return KartenDatentypen.Karten_Grund_Alle_Felder_Enum;
   
   function ChaoskarteFluss
     return KartenDatentypen.Karten_Grund_Enum;
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return KartenDatentypen.Karten_Grund_Enum;

private
   
   FlussWert : KartenDatentypen.Karten_Grund_Enum;
   RessourceWert : KartenDatentypen.Karten_Grund_Enum;
   
   GrundWert : Karten_Grund_Alle_Felder_Enum;
   
   EAchse : KartenDatentypen.EbeneVorhanden;
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   

   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   ZufallsPunktKarte : KartenRecords.AchsenKartenfeldPositivRecord;

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



   -- Generatoren für KartenGeneratorStandard
   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;
   -- Generatoren für KartenGeneratorStandard



   -- Generator für Chaoskarte
   package WerteWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenDatentypen.Karten_Grund_Alle_Felder_Enum);
   GrundGewählt : WerteWählenChaoskarte.Generator;
   
   package FlussWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenDatentypen.Karten_Grund_Enum);
   FlussGewählt : FlussWählenChaoskarte.Generator;
   
   package RessourceWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenDatentypen.Karten_Grund_Enum);
   RessourceGewählt : RessourceWählenChaoskarte.Generator;
   -- Generator für Chaoskarte
   
   procedure StartPunkteYXFestlegen;
   
   
   
   function StartPositionEAchse
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden;

end ZufallGeneratorenKarten;
