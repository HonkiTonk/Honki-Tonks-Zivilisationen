with ProduktionDatentypen;

package Produktionsgrenzen is
   pragma Pure;

   function ProduktionswertProduktionsbonus
     (ProduktionswertExtern : in ProduktionDatentypen.Feldproduktion;
      ProduktionsbonusExtern : in ProduktionDatentypen.BonusMalus)
      return ProduktionDatentypen.Feldproduktion;

end Produktionsgrenzen;
