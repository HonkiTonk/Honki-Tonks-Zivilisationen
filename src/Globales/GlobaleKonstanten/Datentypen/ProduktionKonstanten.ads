with ProduktionDatentypen;

package ProduktionKonstanten is
   pragma Pure;

   LeerProduktion : constant ProduktionDatentypen.Produktion := 0;

   LeerBonus : constant ProduktionDatentypen.Produktionsbonus := 1.00;
   LeerMalus : constant ProduktionDatentypen.Produktionsmalus := 1.00;

   KeinBonusVorhanden : constant Boolean := False;
   BonusVorhanden : constant Boolean := True;

   KeinMalusVorhanden : constant Boolean := False;
   MalusVorhanden : constant Boolean := True;

end ProduktionKonstanten;
