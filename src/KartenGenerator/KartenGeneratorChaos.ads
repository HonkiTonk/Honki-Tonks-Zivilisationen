pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenGeneratorChaos is

   procedure Chaos;

private

   GrundZufall : GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;

end KartenGeneratorChaos;
