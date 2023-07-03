package body Kampfgrenzen is

   function KampfwertKampfbonus
     (KampfwertExtern : in KampfDatentypen.Kampfwerte;
      KampfbonusExtern : in KampfDatentypen.Kampfbonus)
     return KampfDatentypen.Kampfwerte
   is begin
      
      if
        Float (KampfwertExtern) * Float (KampfbonusExtern) >= Float (KampfDatentypen.Kampfwerte'Last)
      then
         return KampfDatentypen.Kampfwerte'Last;
         
      else
         return KampfDatentypen.Kampfwerte (Float (KampfwertExtern) * Float (KampfbonusExtern));
      end if;
      
   end KampfwertKampfbonus;

end Kampfgrenzen;
