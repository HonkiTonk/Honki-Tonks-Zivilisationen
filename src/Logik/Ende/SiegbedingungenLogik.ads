pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

private with GrafikDatentypen;
private with KartenDatentypen;

package SiegbedingungenLogik is

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum;

private

   Sieg : GrafikDatentypen.Rassenhintergrund_Enum;

   VorhandeneRassen : KartenDatentypen.SichtweiteNatural;

   function RasseBesiegt
     return Boolean;

   function SiegbedingungEins
     return Boolean;

   function SiegbedingungZwei
     return Boolean;

   function SiegbedingungDrei
     return Boolean;

end SiegbedingungenLogik;
