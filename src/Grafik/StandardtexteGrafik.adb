with TextKonstanten;

package body StandardtexteGrafik is

   function Bauzeit
     (BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Wide_Wide_String
   is begin
      
      case
        BauzeitExtern
      is
         when ProduktionDatentypen.Produktion'Last =>
            return TextKonstanten.UnendlichGeklammert;
            
         when others =>
            return " (" & ProduktionAlsString (ZahlExtern => BauzeitExtern) & ")";
      end case;
      
   end Bauzeit;

end StandardtexteGrafik;
