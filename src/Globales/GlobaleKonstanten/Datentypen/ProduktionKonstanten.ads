with ProduktionDatentypen;

package ProduktionKonstanten is
   pragma Pure;

   LeerProduktion : constant ProduktionDatentypen.Produktion := 0;

   LeerBonus : constant ProduktionDatentypen.Produktionsbonus := 1.00;
   LeerMalus : constant ProduktionDatentypen.Produktionsbonus := 1.00;

   KeinBonusVorhanden : constant Boolean := False;
   BonusVorhanden : constant Boolean := True;

   KeinMalusVorhanden : constant Boolean := False;
   MalusVorhanden : constant Boolean := True;

   WirtschaftNahrung : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Nahrung_Enum;
   WirtschaftMaterial : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Material_Enum;
   WirtschaftGeld : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Geld_Enum;
   WirtschaftForschung : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Forschung_Enum;

end ProduktionKonstanten;
