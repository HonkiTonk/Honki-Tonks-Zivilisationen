with ProduktionDatentypen;

private with UmwandlungssystemHTSEB;

package StandardtexteGrafik is

   function Bauzeit
     (BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Wide_Wide_String
     with
       Post => (
                  Bauzeit'Result'Length > 0
               );
   
private
   
   function ProduktionAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => ProduktionDatentypen.Produktion);

end StandardtexteGrafik;
