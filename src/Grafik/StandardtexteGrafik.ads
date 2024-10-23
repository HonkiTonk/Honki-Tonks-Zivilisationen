with ProduktionDatentypen;

private with UmwandlungenAdaEigenes;

package StandardtexteGrafik is

   function Bauzeit
     (BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Wide_Wide_String
     with
       Post => (
                  Bauzeit'Result'Length > 0
               );
   
private
   
   function ProduktionAlsString is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Produktion);

end StandardtexteGrafik;
