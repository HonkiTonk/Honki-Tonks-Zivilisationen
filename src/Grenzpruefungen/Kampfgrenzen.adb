package body Kampfgrenzen is

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.KampfwerteGroß;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
     return KampfDatentypen.KampfwerteGroß
   is begin
      
      if
        Float (KampfwertExtern) * Float (KampfbonusExtern) >= Float (KampfDatentypen.KampfwerteGroß'Last)
      then
         return KampfDatentypen.KampfwerteGroß'Last;
         
      else
         return KampfDatentypen.KampfwerteGroß (Float (KampfwertExtern) * Float (KampfbonusExtern));
      end if;
      
   end KampfwertKampfbonus;

end Kampfgrenzen;
