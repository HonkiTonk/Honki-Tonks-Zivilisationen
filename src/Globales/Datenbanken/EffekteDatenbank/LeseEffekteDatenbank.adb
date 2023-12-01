with EffekteDatenbank;
with ProduktionKonstanten;
with KampfKonstanten;

package body LeseEffekteDatenbank is

   function Produktion
     (EffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        EffektExtern
      is
         when KartenextraDatentypen.Leer_Effekt_Enum =>
            return ProduktionKonstanten.LeerMalus;
            
         when others =>
            return EffekteDatenbank.Effekteliste (EffektExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end Produktion;
   
      
   
   function Kampf
     (EffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is begin
      
      case
        EffektExtern
      is
         when KartenextraDatentypen.Leer_Effekt_Enum =>
            return KampfKonstanten.LeerMalus;
            
         when others =>
            return EffekteDatenbank.Effekteliste (EffektExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end Kampf;

end LeseEffekteDatenbank;
