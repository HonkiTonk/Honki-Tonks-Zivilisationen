pragma SPARK_Mode (On);

with KartenDatentypen;

package SiegBedingungen is

   function SiegBedingungen
     return Boolean;

private

   VorhandeneRassen : KartenDatentypen.SichtweiteMitNullwert;

   function SiegBedingungEins
     return Boolean;

   function SiegBedingungZwei
     return Boolean;

   function SiegBedingungDrei
     return Boolean;

end SiegBedingungen;
