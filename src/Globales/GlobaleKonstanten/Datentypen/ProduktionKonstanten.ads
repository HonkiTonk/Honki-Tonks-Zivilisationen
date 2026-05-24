with ProduktionDatentypen;
with AufgabenDatentypen;

package ProduktionKonstanten is
   pragma Pure;

   LeerProduktion : constant ProduktionDatentypen.Produktion := 0;

   LeerBonus : constant ProduktionDatentypen.Produktionsbonus := 1.00;
   LeerMalus : constant ProduktionDatentypen.Produktionsmalus := 1.00;

   KeinMalusVorhanden : constant Boolean := False;
   MalusVorhanden : constant Boolean := True;

   LeerArbeit : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;

   LeerArbeitszeit : constant ProduktionDatentypen.ArbeitszeitBasis := 0;
   UnmöglicheArbeit : constant ProduktionDatentypen.ArbeitszeitBasis := ProduktionDatentypen.ArbeitszeitBasis'First;
   MinimaleArbeitszeit : constant ProduktionDatentypen.ArbeitszeitBasis := 1;

   VorzeichenNegativ : constant ProduktionDatentypen.Vorzeichenwechsel := ProduktionDatentypen.Vorzeichenwechsel'First;
   VorzeichenPositiv : constant ProduktionDatentypen.Vorzeichenwechsel := ProduktionDatentypen.Vorzeichenwechsel'Last;

end ProduktionKonstanten;
