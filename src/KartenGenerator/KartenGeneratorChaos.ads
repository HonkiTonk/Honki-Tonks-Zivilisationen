pragma SPARK_Mode (On);

with KartenDatentypen;

package KartenGeneratorChaos is

   procedure Chaos;

private

   GrundZufall : KartenDatentypen.Karten_Grund_Alle_Felder_Enum;

end KartenGeneratorChaos;
