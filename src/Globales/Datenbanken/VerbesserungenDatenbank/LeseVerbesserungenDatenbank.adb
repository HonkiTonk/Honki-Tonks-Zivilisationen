with VerbesserungenDatenbank;

-- Mal alle Prüfungen ob der Grund/Verbesserung/Ressource/use. mal in die Lesebereiche verschieben? äöü
-- Sollte die Anzahl der nötigen Prüfungen verringern. äöü
-- Dabei auch alle leeren Rückgabewerte in Konstante umwandeln. äöü
package body LeseVerbesserungenDatenbank is
      
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
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
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Bewegung (RasseExtern);
      end case;
      
   end BewegungWeg;
   
      
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      end case;
      
   end WirtschaftVerbesserung;
   
      
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      end case;
      
   end WirtschaftWeg;
   
      
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Kampf (RasseExtern, WelcherWertExtern);
      end case;
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return VerbesserungenDatenbank.Wegeliste (WegExtern).Kampf (RasseExtern, WelcherWertExtern);
      end case;
      
   end KampfWeg;

end LeseVerbesserungenDatenbank;
