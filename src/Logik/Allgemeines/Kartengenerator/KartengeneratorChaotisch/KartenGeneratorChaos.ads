pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;

package KartenGeneratorChaos is

   procedure Chaos;

private

   GrundZufall : KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;

   RessourceZufall : KartenGrundDatentypen.Karten_Ressourcen_Enum;

end KartenGeneratorChaos;
