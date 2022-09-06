pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with GrafikDatentypen;
private with KartenDatentypen;

package SiegbedingungenLogik is

   function Siegbedingungen
     return Boolean;

private

   Sieg : GrafikDatentypen.Rassenhintergrund_Enum;

   VorhandeneRassen : KartenDatentypen.SichtweiteNatural;

   function SiegbedingungEins
     return Boolean;

   function SiegbedingungZwei
     return Boolean;

   function SiegbedingungDrei
     return Boolean;

end SiegbedingungenLogik;
