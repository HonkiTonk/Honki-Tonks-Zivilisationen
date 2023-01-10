with SystemDatentypen;

private with GrafikDatentypen;

package SiegbedingungenLogik is
   pragma Elaborate_Body;

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum;

private

   Sieg : GrafikDatentypen.Spezieshintergrund_Enum;

   VorhandeneSpezies : Natural;



   function SpeziesBesiegt
     return Boolean;

   function SiegbedingungEins
     return Boolean;

   function SiegbedingungZwei
     return Boolean;

   function MenschlicherSpielerVorhanden
     return Boolean;

end SiegbedingungenLogik;
