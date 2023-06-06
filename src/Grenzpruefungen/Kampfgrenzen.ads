with KampfDatentypen;

package Kampfgrenzen is
   pragma Pure;

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.KampfwerteGroß;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return KampfDatentypen.KampfwerteGroß;

end Kampfgrenzen;
