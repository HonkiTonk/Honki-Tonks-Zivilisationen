with KampfDatentypen;

package Kampfgrenzen is
   pragma Elaborate_Body;

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.KampfwerteGroß;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return KampfDatentypen.KampfwerteGroß;

end Kampfgrenzen;
