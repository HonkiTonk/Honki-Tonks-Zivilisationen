package body Kampfgrenzen is

   -- Das heir auch durch die Grenzests ersetzen. äöü
   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.KampfwerteBasis;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
     return KampfDatentypen.KampfwerteBasis
   is begin
      
      if
        Float (KampfwertExtern) * Float (KampfbonusExtern) >= Float (KampfDatentypen.KampfwerteBasis'Last)
      then
         return KampfDatentypen.KampfwerteBasis'Last;
         
      else
         return KampfDatentypen.KampfwerteBasis (Float (KampfwertExtern) * Float (KampfbonusExtern));
      end if;
      
   end KampfwertKampfbonus;

end Kampfgrenzen;
