package body Produktionsgrenzen is

   function ProduktionswertProduktionsbonus
     (ProduktionswertExtern : in ProduktionDatentypen.Feldproduktion;
      ProduktionsbonusExtern : in ProduktionDatentypen.BonusMalus)
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      if
        Float (ProduktionswertExtern) * Float (ProduktionsbonusExtern) >= Float (ProduktionDatentypen.Feldproduktion'Last)
      then
         return ProduktionDatentypen.Feldproduktion'Last;
         
      else
         return ProduktionDatentypen.Feldproduktion (Float (ProduktionswertExtern) * Float (ProduktionsbonusExtern));
      end if;
      
   end ProduktionswertProduktionsbonus;

end Produktionsgrenzen;
