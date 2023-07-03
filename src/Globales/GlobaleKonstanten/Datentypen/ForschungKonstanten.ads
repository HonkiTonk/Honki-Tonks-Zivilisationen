with ForschungenDatentypen;
with ProduktionDatentypen;

package ForschungKonstanten is
   pragma Pure;
   
   LeerKosten : constant ProduktionDatentypen.Einzelproduktion := 0;
   
   LeerForschung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerAnforderung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant ForschungenDatentypen.ForschungIDUnmöglich := ForschungenDatentypen.ForschungIDUnmöglich'First;
   
end ForschungKonstanten;
