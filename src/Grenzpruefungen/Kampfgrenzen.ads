with KampfDatentypen;

package Kampfgrenzen is
   pragma Pure;

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.KampfwerteBasis;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return KampfDatentypen.KampfwerteBasis;

end Kampfgrenzen;
