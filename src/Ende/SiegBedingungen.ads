pragma SPARK_Mode (On);

with GlobaleDatentypen;

package SiegBedingungen is

   function SiegBedingungen
     return Boolean;

private

   VorhandeneRassen : GlobaleDatentypen.SichtweiteMitNullwert;

   function SiegBedingungEins
     return Boolean;

   function SiegBedingungZwei
     return Boolean;

   function SiegBedingungDrei
     return Boolean;

end SiegBedingungen;
