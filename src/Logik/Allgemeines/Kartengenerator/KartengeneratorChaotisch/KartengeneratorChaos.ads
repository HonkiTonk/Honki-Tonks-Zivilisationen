pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

package KartengeneratorChaos is

   procedure Chaos;

private

   GrundZufall : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   RessourceZufall : KartengrundDatentypen.Karten_Ressourcen_Enum;

end KartengeneratorChaos;
