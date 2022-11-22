with SystemDatentypen;

private with GrafikDatentypen;

package SiegbedingungenLogik is
   pragma Elaborate_Body;

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum;

private

   Sieg : GrafikDatentypen.Rassenhintergrund_Enum;

   VorhandeneRassen : Natural;



   function RasseBesiegt
     return Boolean;

   function SiegbedingungEins
     return Boolean;

   function SiegbedingungZwei
     return Boolean;

end SiegbedingungenLogik;
