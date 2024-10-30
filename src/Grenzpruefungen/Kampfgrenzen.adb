package body Kampfgrenzen is

   -- Das heir auch durch die Grenzests ersetzen. äöü
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
