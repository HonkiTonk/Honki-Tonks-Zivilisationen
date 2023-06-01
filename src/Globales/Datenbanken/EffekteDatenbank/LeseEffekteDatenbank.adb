with EffekteDatenbank;
with ProduktionKonstanten;

package body LeseEffekteDatenbank is

   function Produktion
     (EffektExtern : in KarteneffektDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        EffektExtern
      is
         when KarteneffektDatentypen.Leer_Effekt_Enum =>
            return ProduktionKonstanten.LeerMalus;
            
         when others =>
            return EffekteDatenbank.Effekteliste (EffektExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end Produktion;
   
      
   
   function Kampf
     (EffektExtern : in KarteneffektDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        EffektExtern
      is
         when KarteneffektDatentypen.Leer_Effekt_Enum =>
            return ProduktionKonstanten.LeerMalus;
            
         when others =>
            return EffekteDatenbank.Effekteliste (EffektExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end Kampf;

end LeseEffekteDatenbank;
