with KampfDatentypen;

package Kampfgrenzen is
   pragma Pure;

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.Kampfwerte;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return KampfDatentypen.Kampfwerte;

end Kampfgrenzen;
