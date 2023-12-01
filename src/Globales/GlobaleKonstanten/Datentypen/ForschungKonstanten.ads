with ForschungenDatentypen;
with ProduktionDatentypen;

package ForschungKonstanten is
   pragma Pure;
   
   LeerKosten : constant ProduktionDatentypen.Einzelproduktion := 0;
   
   LeerForschung : constant ForschungenDatentypen.ForschungID := ForschungenDatentypen.ForschungID'First;
   LeerAnforderung : constant ForschungenDatentypen.ForschungID := ForschungenDatentypen.ForschungID'First;
   ForschungUnmöglich : constant ForschungenDatentypen.ForschungIDUnmöglich := ForschungenDatentypen.ForschungIDUnmöglich'First;
   
end ForschungKonstanten;
