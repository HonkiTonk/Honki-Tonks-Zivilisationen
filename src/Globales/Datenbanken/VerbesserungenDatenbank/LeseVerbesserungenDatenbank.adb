with VerbesserungenDatenbank;
with ProduktionKonstanten;
with KampfKonstanten;
with EinheitenKonstanten;

package body LeseVerbesserungenDatenbank is
      
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Passierbarkeit (UmgebungExtern);
      end case;
      
   end PassierbarkeitWeg;
   
   
   
   function BewegungWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return EinheitenKonstanten.LeerBewegungspunkte;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Bewegung (SpeziesExtern);
      end case;
      
   end BewegungWeg;
   
      
   
   function ProduktionVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerBonus;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionVerbesserung;
   
      
   
   function ProduktionWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerBonus;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionWeg;
   
   
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfWeg;

end LeseVerbesserungenDatenbank;
