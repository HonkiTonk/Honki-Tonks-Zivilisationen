with ProduktionDatentypen;

private with UmwandlungssystemHTB3;

package StandardtexteGrafik is

   function Bauzeit
     (BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Wide_Wide_String
     with
       Post => (
                  Bauzeit'Result'Length > 0
               );
   
private
   
   function ProduktionAlsString is new UmwandlungssystemHTB3.Zahlenstring (GanzeZahl => ProduktionDatentypen.Produktion);

end StandardtexteGrafik;
