pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenRecords;

with Karten;

package ZufallsgeneratorenStartkoordinaten is
     
   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  Startkoordinaten'Result.EAchse in -1 .. 0
                and
                  Startkoordinaten'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  Startkoordinaten'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

private
   
   EAchse : KartenDatentypen.EbeneVorhanden;
   
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   YXAchsen : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   ZufallsPunktKarte : KartenRecords.AchsenKartenfeldNaturalRecord;

   package WerteWählen1000 is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);

   PositionGewählt1000 : WerteWählen1000.Generator;
      
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
     with
       Post => (
                  StartPunkteYXFestlegen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  StartPunkteYXFestlegen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

end ZufallsgeneratorenStartkoordinaten;
