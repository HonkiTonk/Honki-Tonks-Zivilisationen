pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;

package KartenGeneratorChaos is

   procedure Chaos;

private

   GrundZufall : KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum;

   RessourceZufall : KartenGrundDatentypen.Karten_Ressourcen_Enum;

end KartenGeneratorChaos;
