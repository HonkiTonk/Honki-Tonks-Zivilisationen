with VerbesserungenDatenbank;
with ProduktionKonstanten;
with EinheitenKonstanten;
with KampfKonstanten;

package body LeseVerbesserungenDatenbank is
      
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Passierbarkeit (WelcheUmgebungExtern);
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
   
      
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Wirtschaft (SpeziesExtern, WelcherWertExtern);
      end case;
      
   end WirtschaftVerbesserung;
   
      
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Wirtschaft (SpeziesExtern, WelcherWertExtern);
      end case;
      
   end WirtschaftWeg;
   
      
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Kampf (SpeziesExtern, WelcherWertExtern);
      end case;
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Kampf (SpeziesExtern, WelcherWertExtern);
      end case;
      
   end KampfWeg;

end LeseVerbesserungenDatenbank;
