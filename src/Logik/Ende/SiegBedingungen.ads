pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package SiegBedingungen is

   function SiegBedingungen
     return Boolean;

private

   VorhandeneRassen : KartenDatentypen.SichtweiteNatural;

   function SiegBedingungEins
     return Boolean;

   function SiegBedingungZwei
     return Boolean;

   function SiegBedingungDrei
     return Boolean;

end SiegBedingungen;
